import 'package:flutter/material.dart';
import 'dart:io';
import './main.dart';
class DetailPage extends StatelessWidget {
  
  //final String title;
  //final String description;
  //final File _image;
  final  user;
    // void initState() {
    //   super.initState();
    //   removeItem(item);
    // }
    const DetailPage({Key key, this.user}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
  
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // DecoratedBox(
              //   child: Container(height: 400,width:400,
              //   ),
              //   // decoration: BoxDecoration(
              //   //   image: DecorationImage(
              //   //     image: FileImage(File(user.image),)
              //   //   )
              //   // ),
              // ),
              Text(user.title, style: Theme.of(context).textTheme.display1,),
              SizedBox(height: 20.0,),
              Text(user.description),
              SizedBox(height: 20.0,),
              
            ],
          ),
        ),
      ); 
    }
    
  }
  
  