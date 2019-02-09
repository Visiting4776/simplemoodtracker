import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsWidget>{

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      color: Colors.lightGreenAccent,
      child: Center(
        child: Text('Settings'),
      ),
    );
    
    return widget;
  }
}