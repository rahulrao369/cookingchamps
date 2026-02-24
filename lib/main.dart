import 'package:cooking_champs/constant/my_color.dart';
import 'package:cooking_champs/constant/stringfile.dart/app_localization.dart';
import 'package:cooking_champs/constant/stringfile.dart/locale_constant.dart';
import 'package:cooking_champs/new_ui/splash.dart';
import 'package:cooking_champs/services/notification_services.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'firebase_options.dart';
import 'new_ui/let_create_your_kid.dart' show LetCreateYourKid;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  debugPrint('---_backgroundHandler--${message.data}-');
  await Firebase.initializeApp();
  // setupLocator();
  NotificationService.handleMessage(message);
}

Future<void> _initializeApp() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  // Set system UI overlays
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // statusBarColor: MyColors.bg,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  NotificationService().initialize(); // Initialize the notification service
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Utility.getId();
    Utility.getFcm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MediaQuery(
      data: data.copyWith(textScaleFactor: 1.0),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Cooking Champs',
        theme: ThemeData(
          useMaterial3: true,
          dialogTheme: const DialogThemeData(
            backgroundColor: MyColor.white,
          ),
          scaffoldBackgroundColor: MyColor.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primarySwatch: MaterialColor(
            0xffFD7418,
            <int, Color>{
              50: Color(0xff48335C),
              100: Color(0xff48335C),
              200: Color(0xff48335C),
              300: Color(0xff48335C),
              400: Color(0xff48335C),
              500: Color(0xff48335C),
              600: Color(0xff48335C),
              700: Color(0xff48335C),
              800: Color(0xff48335C),
              900: Color(0xff48335C),
            },
          ),
        ),

        locale: _locale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: SplashView(),
      ),
    );
  }
}


/*

import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  debugPrint('---_backgroundHandler--${message.data}-');
  await Firebase.initializeApp();
  NotificationService.handleMessage(message);
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
  ));
}

void main() async {
  await _initializeApp();
  NotificationService().initialize();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    final state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setState(() => _locale = locale));
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Utility.getId();
    Utility.getFcm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Cooking Champs',
        theme: ThemeData(
          dialogTheme: const DialogTheme(backgroundColor: MyColor.white),
          scaffoldBackgroundColor: MyColor.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primarySwatch: const MaterialColor(0xffFD7418, {
            50: Color(0xff48335C),
            100: Color(0xff48335C),
            200: Color(0xff48335C),
            300: Color(0xff48335C),
            400: Color(0xff48335C),
            500: Color(0xff48335C),
            600: Color(0xff48335C),
            700: Color(0xff48335C),
            800: Color(0xff48335C),
            900: Color(0xff48335C),
          }),
          useMaterial3: true,
        ),
        locale: _locale,
        supportedLocales: const [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) => supportedLocales.firstWhere(
              (supportedLocale) => supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode,
          orElse: () => supportedLocales.first,
        ),
        home: const SplashView(),
      ),
    );
  }
  }
*/
