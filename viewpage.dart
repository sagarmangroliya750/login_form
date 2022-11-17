// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print, prefer_is_empty

import 'package:cont_book/updatepage.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';
import 'insertpage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {

  Database? db;
  List<Map> l = [];

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // READ  :SELECT
    Model().createDatabase().then((value) {
      db = value;

      String qry = "select * from contactbook";
      db!.rawQuery(qry).then((value1) {
        l = value1;
        print(l);

        setState(() {
          status = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text("All Contact",style:TextStyle(color:Colors.green),),
        actions: [
          PopupMenuButton(position: PopupMenuPosition.under,itemBuilder: (context) =>
          [
            PopupMenuItem(child:Text("Scan Card")),
            PopupMenuItem(child:Text("New Card Folder")),
            PopupMenuItem(child:Text("My Groups")),
            PopupMenuItem(child:Text("Setting")),
          ]
          ),
        ],
      ),
      body: status
          ? (l.length > 0
          ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Map map = l[index];
          String name = map['name'];
          String contact = map['contact'];

          int id = map['id'];

          return ListTile(
            title: Text(name,style:TextStyle(color:Colors.white54)),
            subtitle: Text(contact,style:TextStyle(color:Colors.white)),
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("Select Choice"),
                    children: [
                      ListTile(
                        title: Text("Update"),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return updatepage(map);
                                },
                              ));

                        },
                      ),
                      ListTile(
                        title: Text("Delete"),
                        onTap: () {

                          Navigator.pop(context);

                          String qry =
                              "delete from contactbook where id='$id'";
                          db!.rawDelete(qry).then((value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return viewpage();
                                  },
                                ));
                          });
                        },
                      )
                    ],
                  );
                },
              );
            },
          );
        },
      )
          : Center(child: Text("No data found")))
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.green,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return insertpage();
              },
            ));
          },
          child: Icon(Icons.add)),
    ));
  }
}
