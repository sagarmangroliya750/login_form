// ignore_for_file: sort_child_properties_last, null_argument_to_non_null_type, prefer_const_constructors, camel_case_types, avoid_print

import 'package:cont_book/viewpage.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:sqflite/sqflite.dart';

import 'Model.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
    return WillPopScope(child: Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
        title: Text("Create Contact"),
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
            padding:EdgeInsets.all(8.0),
            child:TextField(
                autofocus:true,
              controller:tname,style:TextStyle(color:Colors.white),
              decoration: InputDecoration(
                  contentPadding:EdgeInsets.all(6),
                  //ok
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
            padding:EdgeInsets.all(8.0),
            child:TextField(
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
              String name = tname.text;
              String contact = tcontact.text;
              String qry =
                  "insert into contactbook (name,contact) values ('$name','$contact')";
              db!.rawInsert(qry).then((value) {
                print(value);

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return viewpage();
                  },
                ));
              });
            },
            text: "Save",textStyle:TextStyle(fontSize:15),
            icon: Icon(Icons.save,color:Colors.white,),
          ),

        ],
      ),
    ), onWillPop: goback);
  }
}
