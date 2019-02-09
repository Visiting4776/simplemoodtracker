import 'package:flutter/material.dart';

import 'timeline.dart';
import 'layout.dart';

void main () => (runApp(App()));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleMoodTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LayoutWidget(),
    );
  }
}