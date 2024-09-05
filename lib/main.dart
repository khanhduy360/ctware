import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/splash_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CTWareApp());
}

class CTWareApp extends StatelessWidget {
  const CTWareApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Hello FreeLanecer First',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        locale: const Locale('vi', 'VN'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}