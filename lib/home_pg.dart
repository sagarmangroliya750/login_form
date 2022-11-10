// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, null_argument_to_non_null_type

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_form/main.dart';
import 'package:login_form/registration.dart';

class home_pg extends StatefulWidget {
  @override
  State<home_pg> createState() => _home_pgState();
}

class _home_pgState extends State<home_pg> {

  Future<bool> goback()
  {
    SystemNavigator.pop();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: goback,child:  Scaffold(
      drawer: Drawer(
        backgroundColor:Colors.black,
        child:ListView(
          children: [
            UserAccountsDrawerHeader(accountName:Text("Sagar Mangroliya"),accountEmail:Text("demo123@gmail.com"),
              decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topLeft, colors: [Colors.blueAccent,Colors.orangeAccent,Colors.lightBlue])),
              currentAccountPicture:CircleAvatar(
                backgroundImage:NetworkImage("https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_0.jpg"),
              ),
            ),
            ListTile(
              leading:Icon(Icons.account_circle),
              title:Text("Account",style:TextStyle(color:Colors.white,fontSize:16)),onTap: () {
              Navigator.pop(context);
            },
              trailing:Icon(Icons.arrow_forward_ios,size:17),iconColor:Colors.blueAccent,
            ),
            ListTile(
              leading:Icon(Icons.download_outlined),
              title:Text("Download",style:TextStyle(color:Colors.white,fontSize:16)),onTap: () {
              Navigator.pop(context);
            },
              trailing:Icon(Icons.arrow_forward_ios,size:17),iconColor:Colors.blueAccent,
            ),
            ListTile(
              leading:Icon(Icons.playlist_add_sharp),
              title:Text("Watchlist",style:TextStyle(color:Colors.white,fontSize:16)),onTap: () {
              Navigator.pop(context);
            },
              trailing:Icon(Icons.arrow_forward_ios,size:17),iconColor:Colors.blueAccent,
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text("Home Page"),
        actions: [
          PopupMenuButton(color:Colors.blueAccent.shade100,
              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
              itemBuilder: (context) =>
              [
                PopupMenuItem( child:Text("Edit")),
                PopupMenuItem( child:Text("Information")),
                PopupMenuItem( child:Text("Setting")),
                PopupMenuItem( child:Text("Logout")),
                PopupMenuItem( child:Text("About")),
              ]
          )
        ],
      ),
    ),);
  }
}
