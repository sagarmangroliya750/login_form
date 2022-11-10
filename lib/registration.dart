// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_final_fields, use_build_context_synchronously, avoid_print, non_constant_identifier_names, depend_on_referenced_packages, unrelated_type_equality_checks, unnecessary_null_comparison

import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'home_pg.dart';
import 'main.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conf_password = TextEditingController();
  TextEditingController city = TextEditingController();

  String gen = "Male";
  dynamic c1 = true, c2 = false, c3 = false, c4 = false;
  ImagePicker _picker = ImagePicker();
  XFile? image;
  String img = "";
  bool temp = false;
  bool _isObsecure = true;
  bool _Obsecure = true;
  Database? database;
  String ChValue = "Cricket";
  var items = ['   ~ Select City ~','   Surat','   Ahmadabad','   Amreli','   Junagadh','   Bharuch','   Gandhinagar' ];
  String dropdownvalue = '   ~ Select City ~';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_permission();
    create_db();
  }

  get_permission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  create_db() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'login.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Registration (id INTEGER PRIMARY KEY AUTOINCREMENT,Name TEXT,Contact INTEGER,Email TEXT,password TEXT,Confirm Password TEXT,City TEXT,Gender TEXT,Hobby TEXT)');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.orange.shade50,
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return myapp(email.text,password.text);
                          },
                        ));
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.blueAccent,
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 70),
                    child: Text(
                      "User Registration",
                      style: TextStyle(
                          fontFamily: "usr",
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.blueAccent),
                    ),
                  ),
                  Icon(
                    Icons.app_registration,
                    color: Colors.blue,
                  )
                ],
              ),
              SizedBox(
                height: 48,
                width: 330,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child:TextFormField(
                    controller:name,
                    decoration:InputDecoration(
                      labelText:"Enter Name",
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      prefixIcon:Icon(Icons.person,size:20,),
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(15))
                    ),
                  )
                ),
              ),
              SizedBox(
                height: 58,width: 330,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: contact,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        labelText: "Enter Contact",
                        prefixIcon: Icon(Icons.call, size: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 58,
                width: 330,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        labelText: "Enter Email",
                        prefixIcon: Icon(Icons.mail, size: 21),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 58,
                width: 330,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: password,
                    cursorColor: Colors.black,
                    obscureText: _isObsecure,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        labelText: "Enter Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecure = !_isObsecure;
                              });
                            },
                            icon: Icon(
                              _isObsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 21,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              SizedBox(
                height: 58,
                width: 330,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: conf_password,
                    cursorColor: Colors.black,
                    obscureText: _Obsecure,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _Obsecure = !_Obsecure;
                              });
                            },
                            icon: Icon(
                              _Obsecure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 21,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  height: 43,
                  width: 330,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    underline: SizedBox(),
                    isExpanded: true,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    value: dropdownvalue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 27,
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        alignment: Alignment.centerLeft,
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.centerLeft,
                height: 20,
                width: 330,
                child: Text(
                  "*  Select your gender :-",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: "Male",
                    groupValue: gen,
                    onChanged: (value) {
                      setState(() {
                        gen = value.toString();
                      });
                    },
                  ),
                  Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: gen,
                    onChanged: (value) {
                      setState(() {
                        gen = value.toString();
                      });
                    },
                  ),
                  Text("Female"),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 20,
                width: 330,
                child: Text(
                  "*  Select your hobby :-",
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: c1,
                    onChanged: (value) {
                      setState(() {
                        c1 = value!;
                        if(c1 == true)
                          {
                             ChValue ="Cricket";
                             c1 == ChValue;
                          }
                        c2 = false;c3 = false;c4 = false;
                      });
                    },
                  ),
                  Text("Cricket"),
                  Checkbox(
                    value: c2,
                    onChanged: (value) {
                      setState(() {
                        c2 = value!;
                        if(c2 == true)
                        {
                          ChValue ="Music";
                          c2 == ChValue;
                        }
                        c1=false;c3=false;c4=false;
                      });
                    },
                  ),
                  Text("Music"),
                  Checkbox(
                    value: c3,
                    onChanged: (value) {
                      setState(() {
                        c3 = value!;
                        if(c3 == true)
                        {
                          ChValue ="Chess";
                          c3 == ChValue;
                        }
                        c1=false;c2=false;c4=false;
                      });
                    },
                  ),
                  Text("Chess"),
                  Checkbox(
                    value: c4,
                    onChanged: (value) {
                      setState(() {
                        c4 = value!;
                        if(c4 == true)
                        {
                          ChValue ="Pool";
                          c4 == ChValue;
                        }
                        c1=false;c2=false;c3=false;
                      });
                    },
                  ),
                  Text("Pool")
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 70, right: 30),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      border: Border.all(color: Colors.black),
                      image: DecorationImage( fit: BoxFit.cover, image: FileImage(File(img))))),
                  GFButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Photos",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            content: Text(
                                "Select Which Option To Use for Upload Your Image..!?"),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    image = await _picker.pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      temp == true;
                                      img = image!.path;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Camera")),
                              TextButton(
                                  onPressed: () async {
                                    image = await _picker.pickImage( source: ImageSource.gallery);
                                    setState(() {
                                      img = image!.path;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Gallery")),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",
                                    style: TextStyle(color: Colors.redAccent)),
                              )
                            ],
                          );
                        },
                      );
                    },
                    text: "Upload",
                    textStyle:
                        TextStyle(fontSize: 12, color: Colors.blueAccent),
                    icon: Icon(Icons.add_photo_alternate),
                    type: GFButtonType.outline,
                    shape: GFButtonShape.pills,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 33, left: 50),
                    height: 32,
                    width: 90,
                    child: GFButton(
                      onPressed: () {
                      Navigator.pop(context);
                      },
                      text: "Cancel",
                      textStyle: TextStyle(fontSize: 15, color: Colors.red),
                      shape: GFButtonShape.standard,
                      type: GFButtonType.outline,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 33, left: 80),
                    height: 32,
                    width: 90,
                    child: GFButton(
                      onPressed: () {

                        String str  = name.text;
                        String str1 = contact.text;
                        String str2 = email.text;
                        String str3 = password.text;
                        String str4 = conf_password.text;

                        String qry =
                            "insert into Registration values(null,'$str','$str1','$str2','$str3','$str4','$dropdownvalue','$gen','$ChValue')";
                        database!.rawInsert(qry);
                        print("Database Table : $qry");

                        if(email.text != "" && password.text != "" && conf_password.text != "")
                          {
                             if(password.text == conf_password.text)
                             {
                               Navigator.push(context,MaterialPageRoute(builder: (context) {
                                return myapp(email.text, password.text);
                                },));
                             }
                             else
                               {
                                 Fluttertoast.showToast(
                                     msg:"Enter Valid Confirm Password !?",
                                     toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.CENTER,
                                     timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.white,
                                     textColor: Colors.red,
                                     fontSize: 15.0
                                 );
                               }
                          }
                        else
                          {
                            Fluttertoast.showToast(
                                msg:"Enter Some Details Pls !!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.red,
                                fontSize: 15.0
                            );
                          }

                      },
                      text: " Submit",
                      textStyle: TextStyle(fontSize: 15),
                      shape: GFButtonShape.standard,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
