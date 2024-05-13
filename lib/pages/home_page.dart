import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_application/designs/home_page_design.dart';
import 'package:note_application/my_app/setup.dart';
import 'package:note_application/pages/new_note_page.dart';
import 'package:note_application/pages/note_page.dart';
import 'package:note_application/pages/settings_page.dart';
import 'package:path_provider/path_provider.dart';
import '../services/hive_service.dart';

class HomePage extends StatefulWidget {
  File? file;
  HomePage({super.key, this.file});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isImageSelected = false;

  Widget cardDesign(
      {required String title,
      required String subtitle,
      String? path,
      required int index}) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotePage(index: index)));
            },
            autoClose: false,
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "edit".tr(),
            borderRadius: BorderRadius.circular(20),
          ),
          SlidableAction(
            onPressed: (context) async {
              await HiveService.deleteData(index);
              noteList = await HiveService.getData();
              setState(() {});
            },
            autoClose: false,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "delete".tr(),
            borderRadius: BorderRadius.circular(20),
          )
        ],
      ),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 50,
              child: path != null
                  ? ClipOval(
                      child: Image.file(
                        File(path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      ),
    );
  }

  Future<void> read() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        isImageSelected = true;
      }
    }
    if (isImageSelected) {
      widget.file = File("${directory.path}/image.png");
      setState(() {});
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePageDesign.lightBackground,
      drawer: Drawer(
        backgroundColor: HomePageDesign.lightBackground,
        child: Column(
          children: [
            const SizedBox(height: 50),

            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/akmaljon.jpg"),
            ),
            const SizedBox(height: 10),
            Text(
              "me".tr(),
              style: GoogleFonts.quicksand(fontSize: 22, color: Colors.black),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),

                  const Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 28,
                  ),
                  Text(
                    "settings".tr(),
                    style: GoogleFonts.quicksand(
                        fontSize: 20, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: HomePageDesign.lightBackground,
        title: const Text("note").tr(),
        titleTextStyle:
            HomePageDesign.appBarDesign(fontSize: 24, color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          noteList.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 400),
                    child: Text(
                      "noNote".tr(),
                      style: GoogleFonts.quicksand(
                          fontSize: 24, color: Colors.black),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      return cardDesign(
                          title: noteList[index].title,
                          subtitle: noteList[index].text,
                          path: noteList[index].path,
                          index: index);
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: HomePageDesign.lightBackground,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewNotePage()));
          },
          child: Text(
            "+",
            style: GoogleFonts.quicksand(fontSize: 28),
          )),
    );
  }
}
