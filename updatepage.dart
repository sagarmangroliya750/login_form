// ignore_for_file: prefer_const_constructors, null_argument_to_non_null_type, avoid_print

import 'package:cont_book/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';

class updatepage extends StatefulWidget {
  Map map;
  updatepage(this.map);

  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {


  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tname.text = widget.map['name'];
    tcontact.text = widget.map['contact'];

    Model().createDatabase().then((value) {
      db = value;
    });
  }

  Future<bool> goback()
  {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return viewpage();
      },
    ));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: goback, child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text("Update Contact"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return viewpage();
            },
          ));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                autofocus:true,
                controller:tname,style:TextStyle(color:Colors.white),
                decoration: InputDecoration(
                    contentPadding:EdgeInsets.all(6),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.5),
                    labelText: "Enter name",labelStyle:TextStyle(color:Colors.white70),
                    prefixIcon: Icon(Icons.person,size: 23,color:Colors.blue,),
                    suffixIcon: IconButton(onPressed: () {
                      tname.text ="";
                    },icon:Icon(Icons.clear,size:21,color:Colors.red,)),
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(13))
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                maxLength:10,clipBehavior:Clip.antiAlias,
                keyboardType:TextInputType.numberWithOptions(),
                autofocus:true,
                controller: tcontact,style:TextStyle(color:Colors.white),
                decoration: InputDecoration(
                    contentPadding:EdgeInsets.all(6),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.5),
                    labelText: "Enter contact",labelStyle:TextStyle(color:Colors.white70),
                    prefixIcon: Icon(Icons.call, size: 22,color:Colors.green,),
                    suffixIcon: IconButton(onPressed: () {
                      tcontact.text ="";
                    },icon:Icon(Icons.clear,size:21,color:Colors.red,)),
                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(13))
                )
            ),
          ),
          GFButton(
            onPressed: (){
              String newname = tname.text;
              String newcontact = tcontact.text;

              int id = widget.map['id'];

              String qry =
                  "update contactbook set name='$newname',contact='$newcontact' where id='$id'";
              db!.rawUpdate(qry).then((value) {
                print(value);

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return viewpage();
                  },
                ));
              });

            },
            text: "Update",
            icon: Icon(Icons.update),textStyle:TextStyle(fontSize:15,color:Colors.black),
            color:Colors.green,
          ),
        ],
      ),
    ));
  }
}
