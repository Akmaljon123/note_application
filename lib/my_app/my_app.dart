import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:note_application/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: HomePage(),
    );
  }
}
