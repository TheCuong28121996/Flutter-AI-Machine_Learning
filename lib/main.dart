import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_learning/page/pages.dart';

import 'routers/router_settings.dart';
import 'utils/screen_util/screen_util_init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 820),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => Builder(
        builder: (context) => MaterialApp(
          title: 'Machine Learning',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouterSettings.allRoutes,
          initialRoute: SplashPage.routeName,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF101010),
              appBarTheme: const AppBarTheme(
                  color: Color(0xFF1F1F1F),
                  iconTheme: IconThemeData(color: Colors.white)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFF1F1F1F)),
              iconTheme: const IconThemeData(color: Colors.white)),
        ),
      ),
    );
  }
}
