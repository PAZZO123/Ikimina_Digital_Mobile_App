/**
 * Ikimina Digital — Firebase Cloud Functions
 * Sends real FCM push notifications when a notification document is created in Firestore.
 *
 * Trigger: onCreate on /notifications/{notifId}
 * Flow:
 *  1. Read userId from the new notification document
 *  2. Look up the user's FCM token from /users/{userId}
 *  3. Send an FCM message via Firebase Admin SDK
 *  4. Write the messageId back to the notification document (for debugging)
 */

const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");

initializeApp();

const db = getFirestore();

/**
 * sendPushNotification — triggered whenever a new document is added
 * to the top-level `notifications` collection.
 *
 * Expected document shape:
 * {
 *   userId:    string,   // recipient user ID
 *   title:     string,
 *   body:      string,
 *   type:      string,   // e.g. "contribution_approved", "loan_approved", etc.
 *   groupId?:  string,   // optional, for deep linking
 *   data?:     map,      // extra key-value pairs forwarded to the app
 *   createdAt: Timestamp,
 *   isRead:    bool
 * }
 */
exports.sendPushNotification = onDocumentCreated(
  {
    document: "notifications/{notifId}",
    region: "us-central1",
  },
  async (event) => {
    const snap = event.data;
    if (!snap) {
      console.log("No data in event — skipping.");
      return null;
    }

    const notif = snap.data();
    const notifId = event.params.notifId;

    const userId = notif.userId;
    const title = notif.title || "Ikimina Digital";
    const body = notif.body || "";
    const type = notif.type || "";
    const groupId = notif.groupId || "";

    if (!userId) {
      console.log(`[${notifId}] Missing userId — skipping push.`);
      return null;
    }

    // --- Fetch the recipient's FCM token ---
    let fcmToken = null;
    try {
      const userSnap = await db.collection("users").doc(userId).get();
      if (!userSnap.exists) {
        console.log(`[${notifId}] User ${userId} not found — skipping push.`);
        return null;
      }
      fcmToken = userSnap.data().fcmToken || null;
    } catch (err) {
      console.error(`[${notifId}] Error fetching user ${userId}:`, err);
      return null;
    }

    if (!fcmToken) {
      console.log(`[${notifId}] User ${userId} has no FCM token — skipping push.`);
      return null;
    }

    // --- Build extra data payload (string values only for FCM) ---
    const dataPayload = {
      notifId,
      type,
      groupId,
      ...(notif.data
        ? Object.fromEntries(
            Object.entries(notif.data).map(([k, v]) => [k, String(v)])
          )
        : {}),
    };

    // --- Send the FCM message ---
    const message = {
      token: fcmToken,
      notification: {
        title,
        body,
      },
      data: dataPayload,
      android: {
        priority: "high",
        notification: {
          channelId: "ikimina_notifications", // matches channel created in notification_service.dart
          sound: "default",
        },
      },
      apns: {
        payload: {
          aps: {
            sound: "default",
            badge: 1,
          },
        },
      },
    };

    try {
      const messageId = await getMessaging().send(message);
      console.log(`[${notifId}] FCM sent to ${userId}: ${messageId}`);

      // Write messageId back so we can audit delivery
      await snap.ref.update({ fcmMessageId: messageId, fcmSentAt: new Date() });
    } catch (err) {
      // Token expired / unregistered — clear it so we don't keep trying
      if (
        err.code === "messaging/registration-token-not-registered" ||
        err.code === "messaging/invalid-registration-token"
      ) {
        console.warn(`[${notifId}] Invalid token for ${userId} — clearing token.`);
        await db.collection("users").doc(userId).update({ fcmToken: null });
      } else {
        console.error(`[${notifId}] FCM send error:`, err);
      }
    }

    return null;
  }
);
