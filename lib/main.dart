import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/provider/contract_provider.dart';
import 'package:ctware/provider/news_provider.dart';
import 'package:ctware/provider/request_types_provider.dart';
import 'package:ctware/provider/send_request_provider.dart';
import 'package:ctware/provider/send_response_provider.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/load.dart';
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
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => ContractProvider()),
        ChangeNotifierProvider(create: (_) => BillProvider()),
        ChangeNotifierProvider(create: (_) => RequestTypesProvider()),
        ChangeNotifierProvider(create: (_) => SendRequestProvider()),
        ChangeNotifierProvider(create: (_) => SendResponseProvider()),
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
        home: const LoadApp(),
      ),
    );
  }
}