import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_application/my_app/my_app.dart';

import 'my_app/setup.dart';

void main()async{
  await setup();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("en", "US"), Locale("ru", "RU"), Locale("uz", "UZ")],
      path: "assets/translations",
      startLocale: const Locale("en", "US"),
      child: const MyApp()
  )
  );
}