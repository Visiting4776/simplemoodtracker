import 'package:flutter/material.dart';
import 'timeline.dart';
import 'statistics.dart';
import 'settings.dart';

class LayoutWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LayoutState();
  }
}

class _LayoutState extends State<LayoutWidget>{
  int _tabIndex = 1;

  FloatingActionButton addMoodEntryButton = new FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () => {},
  );

  @override
  Widget build(BuildContext context) {
    PageController _defaultPageController = PageController(
      initialPage: 1,
    );

    PageView _defaultPageView = PageView(
      controller: _defaultPageController,
      onPageChanged: (int index) => this.onPageChange(index),
      children: <Widget>[
        new StatisticsWidget(),
        new TimelineWidget(),
        new SettingsWidget(),
      ],
    );
    
    Widget widget = Scaffold(
      appBar: AppBar(
        title: Text('SimpleMoodTracker'),
        /*actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,

          )
        ],*/
      ),
      body: _defaultPageView,
      /*floatingActionButton: AnimatedCrossFade(
        firstChild: addMoodEntryButton,
        secondChild: Container(),
        crossFadeState: true ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: new Duration(milliseconds: 100),
      ),*/
      floatingActionButton: addMoodEntryButton,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) { setState(() {
          onTabTapped(index, _defaultPageController);
        });},
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.show_chart),
            title: new Text('Statistics'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.filter_hdr),
            title: new Text('History'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Settings'),
          ),
        ],
      ),
    );

    return widget;
  }  

  void onTabTapped(int index, PageController controller){
    print("onTabtapped called with index $index");

    new TimelineWidget();

    _tabIndex = index;
    controller.animateToPage(index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void onPageChange(int index){
    setState((){
      _tabIndex = index;
      print("onpagechange to index $index");

    });
  }
}