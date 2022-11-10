// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, non_constant_identifier_names, unrelated_type_equality_checks, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:login_form/home_pg.dart';
import 'package:login_form/registration.dart';

import 'main.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner:false,
    home: myapp(AutofillHints.email,AutofillHints.password),
  ));
}

class myapp extends StatefulWidget {

  String email;
  String password;
  myapp(this.email,this.password);


  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {

  bool _isObscure = true;
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  String email = "";
  String password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
    password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.8),
                    borderRadius:BorderRadius.only(bottomRight: Radius.circular(150)),
                    gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                      Colors.orange.shade100,
                      Colors.orangeAccent,
                    ])),
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 30, fontFamily: "wlcm"),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(120))),
                  child: ListView(
                    // shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 130),
                        child: Text("User Login",style: TextStyle(
                              fontSize: 20, fontFamily: "usr",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 110,
                        child: Padding( padding: EdgeInsets.all(30),
                          child: TextField(cursorColor:Colors.black,
                            controller:Email,
                            decoration: InputDecoration(labelText:"Email Id",prefixIcon:Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:88,
                        child: Padding(padding:EdgeInsets.only(bottom:20,left:30,right:30),
                          child: TextField(maxLength:14,cursorColor:Colors.black,obscureText: _isObscure,
                            controller:Password,
                            decoration: InputDecoration(labelText:"Password",
                            suffixIcon:IconButton(onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }, icon:Icon( _isObscure ? Icons.visibility_off : Icons.visibility,size:21),),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(right:130,left:120),
                        child: GFButton(
                          onPressed: (){
                            if(Email.text == email && Password.text == password)
                            {
                              Fluttertoast.showToast(
                                  msg: "Login Successfully !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.transparent,
                                  textColor: Colors.green,
                                  fontSize: 15.0
                              );
                              if(Email.text != "" && Password.text != "")
                              {
                                Navigator.push(context,MaterialPageRoute(builder: (context) {
                                  return home_pg();
                                },));
                              }
                            }
                            else
                            {
                              showDialog(
                                barrierDismissible:false,
                                context: context, builder: (context) {
                                return AlertDialog(
                                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
                                  title:Text("Wrong ⚠ ",style:TextStyle(color:Colors.red),),
                                  content:Text("Invalid Username or Password re-enter and try again !!"),
                                  actions: [
                                    GFButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                        Email.text="";Password.text="";
                                      },
                                      text:"Try Again",textStyle:TextStyle(color:Colors.red),
                                      shape: GFButtonShape.pills,
                                      type: GFButtonType.outline,
                                    ),
                                  ],
                                );
                              },);
                            }
                          },
                          text: "Log in",textStyle:TextStyle(color:Colors.white,fontSize:16),
                          shape: GFButtonShape.standard,size:40,color:Colors.green.shade400,
                          icon: Icon(Icons.login),
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.only(right:60,left:60,top:50),
                        child:GFButton(
                          onPressed: (){
                             Email.text="";Password.text="";
                            Navigator.push(context,MaterialPageRoute(builder: (context) {
                              return registration();
                            },));
                          },
                          text: "Don't Have An Account? Register",textStyle:TextStyle(color:Colors.blue,fontSize:15),
                          shape: GFButtonShape.pills,color:Colors.black.withOpacity(0.5),
                          type: GFButtonType.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
