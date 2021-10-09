import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/intro/splash_screen.dart';
import 'controller/langController.dart';
import 'controller/userPlacesController.dart';
import 'helper/appLocalization.dart';

String firebaseMessaging;
FirebaseMessaging _fcm;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await localization.init();
  _fcm = FirebaseMessaging();
  firebaseMessaging = await _fcm.getToken();
  print("firebaseMessaging ===================> $firebaseMessaging");
  // await SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

//
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => MainController()),
        ChangeNotifierProvider(create: (_) => PlasesController()),
        ChangeNotifierProvider(create: (_) => LangContoller()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FACEBOX',
        theme: ThemeData(
          fontFamily: "Tajawal",
          accentColor: accentColor,
          primaryColor: primaryColor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
///