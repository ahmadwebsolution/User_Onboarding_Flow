import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
   createState() => _MyAppState();

}

class _MyAppState extends State<MyApp>{
  bool isDark =false;

  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(
          title: Text("Theme changer"),
          actions: [
            Switch(
            value: isDark,
            onChanged:(value){
              setState(() {
                isDark=value;
              });
            },
            ),
          ],
        ),

        body: Center(
          child: Text("Current Theme: ${isDark ? "Dark" : "Light"}"
          ),
        ),
      ),
    );
  }

}