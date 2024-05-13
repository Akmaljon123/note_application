import 'package:choice/choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../designs/home_page_design.dart';
import 'home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedChoice = "en";
  String selectedCountryChoice = "US";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HomePageDesign.lightBackground,
          title: const Text("setting").tr(),
          titleTextStyle:
          HomePageDesign.appBarDesign(fontSize: 24, color: Colors.black),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Choice(
                builder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioListTile(
                        title: const Text('english').tr(),
                        value: 'en',
                        groupValue: selectedChoice,
                        onChanged: (String? value) {
                          setState(() {
                            selectedChoice = value!;
                            selectedCountryChoice = "US";
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      RadioListTile(
                        title: const Text('russian').tr(),
                        value: 'ru',
                        groupValue: selectedChoice,
                        onChanged: (String? value) {
                          setState(() {
                            selectedChoice = value!;
                            selectedCountryChoice = "RU";
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      RadioListTile(
                        title: const Text('uzbek').tr(),
                        value: 'uz',
                        groupValue: selectedChoice,
                        onChanged: (String? value) {
                          setState(() {
                            selectedChoice = value!;
                            selectedCountryChoice = "UZ";
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      const SizedBox(height: 20),
                      const Text('selected').tr(),
                    ],
                  );
                },
              ),

              GestureDetector(
                onTap: (){
                  context.setLocale(Locale(selectedChoice, selectedCountryChoice));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>HomePage()
                      ),
                          (route) => false
                  );
                },
                child: Container(
                  height: 75,
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.grey
                      )
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "update".tr(),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 22
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
