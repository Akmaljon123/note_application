import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_application/my_app/setup.dart';
import 'package:note_application/pages/new_note_page.dart';
import 'package:note_application/services/hive_service.dart';

@immutable
sealed class HomePageDesign{
  static const Color lightBackground = Colors.white;
  static const Color nightBackground = Colors.black;


  static Widget cardDesign({
    required String title,
    required String subtitle,
    required int index}){
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const NewNotePage()
                  )
              );
            },
            autoClose: false,
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Edit",
            borderRadius: BorderRadius.circular(20),
          ),

          SlidableAction(
            onPressed: (context)async{
              await HiveService.deleteData(index);
              noteList = await HiveService.getData();
            },
            autoClose: false,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.circular(20),
          )
        ],
      ),
      child: GestureDetector(
          child: Card(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
              ),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          )
      ),
    );
  }


  static TextStyle appBarDesign({required num fontSize, required Color color}){
    return GoogleFonts.quicksand(
        fontSize: 28,
        color: Colors.black,
        fontWeight: FontWeight.w600
    );
  }
}