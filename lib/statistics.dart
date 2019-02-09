import 'package:flutter/material.dart';

class StatisticsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _StatisticsState();
  }
}

class _StatisticsState extends State<StatisticsWidget>{

  @override
  Widget build(BuildContext context) {
    Widget widget = Container(
      color: Colors.cyanAccent,
      child: Center(
        child: Text('Statistics'),
      ),
    );
    
    return widget;
  }
}