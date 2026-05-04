import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/auth_service.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/router.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

/// Holds the app locale. Default is English.
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

/// Holds the active theme mode. Synced from the user's Firestore profile.
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Disable google_fonts from downloading fonts at runtime.
  // Fonts are bundled as assets — no network calls needed.
  // Without this, the app throws unhandled exceptions when offline.
  GoogleFonts.config.allowRuntimeFetching = false;

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FCM background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request notification permissions
  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    const ProviderScope(
      child: IkiminaApp(),
    ),
  );
}

class IkiminaApp extends ConsumerStatefulWidget {
  const IkiminaApp({super.key});

  @override
  ConsumerState<IkiminaApp> createState() => _IkiminaAppState();
}

class _IkiminaAppState extends ConsumerState<IkiminaApp> {
  StreamSubscription<String>? _navSub;

  @override
  void initState() {
    super.initState();
    // Forward notification-tap routes to GoRouter
    _navSub = NotificationService.navigationStream.stream.listen((route) {
      final router = ref.read(routerProvider);
      router.go(route);
    });
  }

  @override
  void dispose() {
    _navSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    // Restore locale and theme from user's saved preferences
    ref.listen(currentUserProvider, (_, next) {
      final user = next.valueOrNull;
      if (user != null) {
        ref.read(localeProvider.notifier).state =
            Locale(user.preferredLanguage);
        ref.read(themeModeProvider.notifier).state =
            user.preferredTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
      }
    });

    final appLocale = ref.watch(localeProvider);

    // Kinyarwanda (rw) is not in GlobalMaterialLocalizations, so we tell
    // MaterialApp to use 'en' for Material widgets.  Our own strings are
    // handled by _FixedAppLocalizationsDelegate below, which always loads
    // the user's real chosen language regardless of the Material locale.
    final materialLocale =
        appLocale.languageCode == 'rw' ? const Locale('en') : appLocale;

    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Ikimina Digital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      locale: materialLocale,
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('rw')],
      localizationsDelegates: [
        // Our delegate ignores the Material locale and always returns the
        // language the user actually selected (en / fr / rw).
        _FixedAppLocalizationsDelegate(appLocale),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.2),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}

/// A [LocalizationsDelegate] for [AppLocalizations] that always loads the
/// locale supplied at construction time, ignoring whatever locale Flutter
/// resolves from [MaterialApp.locale].  This lets us show rw/fr strings even
/// when the Material locale is forced to 'en' (because rw isn't in
/// GlobalMaterialLocalizations).
class _FixedAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale fixedLocale;
  const _FixedAppLocalizationsDelegate(this.fixedLocale);

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
      lookupAppLocalizations(fixedLocale),
    );
  }

  @override
  bool shouldReload(_FixedAppLocalizationsDelegate old) =>
      old.fixedLocale != fixedLocale;
}
