# Ikimina Digital 🏦
### A Digital Savings Group Management Mobile Application
**University of Rwanda | College of Science and Technology | Mobile Application System Design**

---

## Overview

Ikimina Digital is a production-ready Flutter mobile application that digitises Rwanda's traditional **Ikimina** (ROSCA — Rotating Savings and Credit Association) savings system. The app brings transparency, accountability, and ease of use to community savings groups across Rwanda.

---

## Features

| Feature | Status |
|---|---|
| User Registration & Login (Firebase Auth) | ✅ |
| Role-based Access (Admin / Member) | ✅ |
| Group Creation & Invite Code System | ✅ |
| Real-time Contribution Tracking | ✅ |
| Automated Payout Rotation Scheduling | ✅ |
| Loan Request, Approval & Repayment | ✅ |
| Fine Management | ✅ |
| Interactive Dashboard with fl_chart | ✅ |
| PDF Financial Report Generation | ✅ |
| Push Notifications (FCM) | ✅ |
| Offline-first SQLite Caching (Drift) | ✅ |
| Multi-language (English + Kinyarwanda) | ✅ |
| Deep Linking (GoRouter) | ✅ |
| Biometric Authentication | ✅ |

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart) |
| State Management | Riverpod 2.x |
| Authentication | Firebase Auth |
| Database | Cloud Firestore (real-time) |
| Local Cache | Drift (SQLite) |
| Navigation | GoRouter |
| Charts | fl_chart |
| PDF Generation | pdf + printing |
| Notifications | Firebase Cloud Messaging + flutter_local_notifications |
| Animations | flutter_animate |
| HTTP | Dio |

---

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase config (generated)
├── core/
│   ├── constants/
│   │   └── app_constants.dart        # Global constants & route names
│   ├── services/
│   │   ├── auth_service.dart         # Firebase Auth logic
│   │   ├── group_service.dart        # Firestore CRUD (groups, contributions, loans)
│   │   ├── pdf_service.dart          # PDF report generation
│   │   ├── notification_service.dart # FCM & local notifications
│   │   └── local_database.dart       # Drift SQLite offline DB
│   ├── theme/
│   │   └── app_theme.dart            # Design system (colors, typography, theme)
│   └── utils/
│       └── router.dart               # GoRouter configuration
├── shared/
│   ├── models/
│   │   └── app_models.dart           # Freezed data models
│   └── widgets/
│       └── shared_widgets.dart       # Reusable UI components
└── features/
    ├── auth/
    │   └── presentation/screens/
    │       ├── splash_screen.dart
    │       ├── onboarding_screen.dart
    │       ├── login_screen.dart
    │       ├── register_screen.dart
    │       ├── forgot_password_screen.dart
    │       └── profile_screen.dart
    ├── dashboard/
    │   └── presentation/screens/
    │       ├── home_screen.dart       # Bottom navigation shell
    │       └── dashboard_screen.dart  # Charts, stats, quick actions
    ├── groups/
    │   └── presentation/screens/
    │       ├── groups_screen.dart
    │       ├── group_detail_screen.dart  # Overview/Contribute/Loans/Payouts tabs
    │       ├── create_group_screen.dart
    │       └── group_members_screen.dart
    ├── contributions/
    │   └── presentation/screens/
    │       └── add_contribution_screen.dart
    ├── loans/
    │   └── presentation/screens/
    │       ├── loans_screen.dart
    │       ├── request_loan_screen.dart
    │       └── loan_detail_screen.dart
    ├── reports/
    │   └── presentation/screens/
    │       └── reports_screen.dart
    └── notifications/
        └── presentation/screens/
            └── notifications_screen.dart
```

---

## Setup Guide

### Prerequisites
- Flutter SDK ≥ 3.10.0
- Dart SDK ≥ 3.0.0
- Android Studio or VS Code
- Firebase account (free Spark plan is sufficient)
- Node.js (for Firebase CLI)

---

### Step 1 — Clone and install dependencies

#### How to Clone & Run This Project

Follow these steps carefully to set up and run the **Ikimina Digital** application locally.

---

### 1. Clone the Repository

```bash
git clone https://github.com/PAZZO123/ikimina_digital_Mobile_App.git
cd ikimina_digital

```bash
# Navigate to project folder
cd ikimina_digital

# Install all Flutter packages
flutter pub get
```

---

### Step 2 — Firebase Setup

1. Go to [https://console.firebase.google.com](https://console.firebase.google.com)
2. Click **"Add project"** → name it `ikimina-digital`
3. Enable **Google Analytics** (optional)

#### 2a. Enable Firebase Services
In your Firebase project, enable:
- **Authentication** → Sign-in method → Email/Password ✅
- **Firestore Database** → Create in **production mode**
- **Firebase Storage** (for profile images)
- **Cloud Messaging** (for push notifications)

#### 2b. Add Apps to Firebase
- Click ⚙️ → **Project settings** → **Your apps**
- Add **Android app**: package name = `com.ikimina.digital`
- Add **iOS app**: bundle ID = `com.ikimina.digital`
- Download `google-services.json` → place in `android/app/`
- Download `GoogleService-Info.plist` → place in `ios/Runner/`

#### 2c. Configure FlutterFire CLI
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure (auto-generates firebase_options.dart)
flutterfire configure
```

---

### Step 3 — Deploy Firestore Rules & Indexes

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Deploy security rules
firebase deploy --only firestore:rules

# Deploy indexes (required for compound queries)
firebase deploy --only firestore:indexes
```

---

### Step 4 — Generate Code

The project uses `freezed` for models and `drift` for local DB. Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

### Step 5 — Run the App

```bash
# Check connected devices
flutter devices

# Run on Android
flutter run

# Build release APK
flutter build apk --release

# Build release App Bundle (for Play Store)
flutter build appbundle --release
```

---

## Firestore Data Model

```
users/{userId}
  ├── id, fullName, email, phone
  ├── role: "admin" | "member"
  ├── groupIds: string[]
  └── preferredLanguage, biometricEnabled...

groups/{groupId}
  ├── name, description, adminId
  ├── contributionAmount, contributionFrequency
  ├── memberIds: string[], payoutOrder: string[]
  ├── currentPayoutIndex, totalBalance
  └── inviteCode, status, nextContributionDate...

contributions/{contributionId}
  ├── groupId, memberId, memberName
  ├── amount, contributionDate, status
  └── confirmedBy, confirmedAt, notes...

loans/{loanId}
  ├── groupId, borrowerId, borrowerName
  ├── amount, interestRate, durationMonths
  ├── amountRepaid, status, purpose
  └── approvedBy, approvedAt, dueDate...

payouts/{payoutId}
  ├── groupId, memberId, memberName
  ├── amount, roundNumber, status
  └── scheduledDate, paidAt...

fines/{fineId}
  ├── groupId, memberId, reason
  ├── amount, status
  └── issuedAt, paidAt...

notifications/{notifId}
  ├── userId, title, body, type
  ├── isRead, groupId, actionId
  └── createdAt...
```

---

## Screenshots Flow

```
Splash → Onboarding (4 slides) → Login/Register
    → Home (Dashboard)
        → Groups tab → Group List → Group Detail
            → Overview (stats, payout cycle, invite code)
            → Contribute (record contributions)
            → Loans (request/approve/repay)
            → Payouts (rotation timeline)
        → Loans tab → All loans across groups
        → Profile tab → Settings, language, biometric
    → Notifications
    → Reports → Generate/Share PDF
```

---

## Authors

- **Patrick Straton Mbabazi** | ID: 223019253
- **Habayimana Vincent** | ID: 223007703

**University of Rwanda | College of Science and Technology**
**Mobile Application System Design | April 2026**

---

## License

Academic project — University of Rwanda. All rights reserved.
