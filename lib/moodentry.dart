import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodEntry /*implements Comparable*/{
  DateTime _time;
  int _score;
  bool _isRegularEntry;

  MoodEntry(DateTime time, int score, [bool isRegularEntry = true]){
    this._time = time;
    this._score = score;
    this._isRegularEntry = isRegularEntry;
  }

  /*int compareTo(MoodEntry other){
    if( this._time.isBefore(other._time) ){
      return -1;
    }
  }*/

  @override
  String toString() {
    return "MoodEntry at $_time: $_score/5";
  }

  DateTime getDay(){
    return new DateTime(
      this._time.year,
      this._time.month,
      this._time.day,
    );
  }

  DateTime get time => _time;
  int get score => _score;
  bool get regular => _isRegularEntry;
}

class MoodEntryDay {
  
  static List moods = [
    {'label': 'Very Bad',
      'icon': Icons.sentiment_very_dissatisfied,
      'color': Colors.indigo[900],
    },
    {'label': 'Bad',
      'icon': Icons.sentiment_dissatisfied,
      'color': Colors.blue,
    },
    {'label': 'Moderate',
      'icon': Icons.face,
      'color': Colors.grey,
    },
    {'label': 'Good',
      'icon': Icons.sentiment_satisfied,
      'color': Colors.green[600],
    },
    {'label': 'Very Good',
      'icon': Icons.sentiment_very_satisfied,
      'color': Colors.green[400],
    },
  ];

  DateTime _day;
  List _entries;

  MoodEntryDay(DateTime day){
    this._day = day;
    this._entries = [];
    //print("A new moodentryday was generated on $day");
  }

  void addMoodEntry(DateTime time, int score){
    this._entries.add(
      new MoodEntry(time, score)
    );
  }

  Widget generateListEntry(){
    DateTime now = DateTime.now();
    DateFormat dateFormatter = new DateFormat('MM/dd/yyyy');
    DateFormat weekdayFormatter = new DateFormat('EEEE');

    String label = weekdayFormatter.format(this._day);
    String subLabel = dateFormatter.format(this._day);

    FontWeight labelWeight = this._day.weekday == 7 ? FontWeight.w500 : FontWeight.w400;
    if(this._day.difference(now).inDays == 0){
      labelWeight = FontWeight.w600;
      label = 'Today';
    }

    List<Widget> rowChildren = [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  //either a Sunday or todays date
                  fontWeight: labelWeight,
                ),
              ),
            ),
            Text(
              subLabel,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey[500]
              ),
            ),
          ],
        ),
      ),
    ];
    print(this._entries.length);
    for(int i=0, score; i<3; i++){
      score = this._entries[i].score;
      Container iconContainer = Container(
        padding: EdgeInsets.only(left: 5),
        child: Icon(
          moods[score]['icon'],
          color: moods[score]['color'],
        ),
      );

      rowChildren.add(iconContainer);
    };
    

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: rowChildren,
      ),
    );
  }
}