import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_application/designs/home_page_design.dart';
import 'package:note_application/designs/note_page_design.dart';
import 'package:note_application/models/note_model.dart';
import 'package:note_application/my_app/setup.dart';
import 'package:note_application/pages/home_page.dart';
import 'package:note_application/services/hive_service.dart';
import 'package:path_provider/path_provider.dart';

class NotePage extends StatefulWidget {
  int index;
  NotePage({super.key, required this.index});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController titleController;
  late TextEditingController textController;
  bool isCamera = false;
  bool isImageSelected = false;
  File? file;

  Future<void> createImage() async {
    isImageSelected = false;
    final ImagePicker picker = ImagePicker();
    XFile? xFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (xFile != null) {
      file = File(xFile.path);
      final directory = await getApplicationDocumentsDirectory();
      await file!.copy("${titleController.text.substring(0,2)}/${directory.path}/image.png");
      isImageSelected = true;
      setState(() {});
    }
  }

  Future<void> read() async {
    final directory = await getApplicationDocumentsDirectory();
    await for (var event in directory.list()) {
      if (event.path.contains('image.png')) {
        isImageSelected = true;
      }
    }
    if (isImageSelected) {
      file = File("${directory.path}/image.png");
      setState(() {});
    }
  }

  @override
  void initState() {
    titleController = TextEditingController(text: noteList[widget.index].title);
    textController = TextEditingController(text: noteList[widget.index].text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HomePageDesign.lightBackground,
      appBar: AppBar(
        title: const Text("create").tr(),
        centerTitle: true,
        titleTextStyle: GoogleFonts.quicksand(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w700
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context)=> HomePage()
                  ),
                      (route) => false
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: ()async{
                NoteModel noteModel = NoteModel(
                    title: titleController.text,
                    text: textController.text,
                    path: file?.path
                );

                await HiveService.editData(noteModel: noteModel, index: widget.index);

                noteList = await HiveService.getData();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> HomePage()
                    ),
                        (route)=>false
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: const Icon(
                  Icons.save,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            GestureDetector(
              onTap: ()async{
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                isCamera = true;
                                await createImage();
                              },
                              child: Container(
                                height: 50,
                                width: 340,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.black
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "camera".tr(),
                                  style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),
                                ),
                              )
                          ),

                          const SizedBox(height: 10),

                          MaterialButton(
                              minWidth: double.infinity,
                              onPressed: () async {
                                isCamera = false;
                                await createImage();
                              },
                              child: Container(
                                height: 50,
                                width: 340,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.black
                                    )
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "gallery".tr(),
                                  style: GoogleFonts.quicksand(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 50,
                child: file != null ? ClipOval(
                  child: Image.file(
                    file!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ) : const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),

            Text(
              "set".tr(),
              style: GoogleFonts.quicksand(
                  fontSize: 28,
                  color: Colors.black
              ),
            ),


            Padding(
                padding: const EdgeInsets.only(left: 40),
                child: NotePageDesign.textFormField(
                    controller: titleController,
                    cursorHeight: 40,
                    cursorColor: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    hintText: "title".tr()
                )
            ),

            Padding(
                padding: const EdgeInsets.only(bottom: 470, left: 40),
                child: NotePageDesign.textFormField(
                    controller: textController,
                    cursorHeight: 30,
                    cursorColor: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    hintText: "here".tr()
                )
            ),
          ],
        ),
      ),
    );
  }
}
