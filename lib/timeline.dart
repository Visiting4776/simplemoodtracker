import 'package:flutter/material.dart';
import 'dart:math';
import 'moodentry.dart';

class TimelineWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _TimelineState();
  }
}

class _TimelineState extends State<TimelineWidget>{
  @override
  Widget build(BuildContext context) {
    List<MoodEntry> _moodEntries = generatePlaceholderMoods();
    List<Widget> timelineDayElements = collectTimelineDays(_moodEntries);

    return Container(
      padding: EdgeInsets.only(left: 56, right: 14),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: timelineDayElements.length,
        itemBuilder: (context, index) => timelineDayElements[timelineDayElements.length-1 - index], //TODO: items should arrive in reversed order instead
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black45,
        ),
      ),
    );
  }

  static List<MoodEntry> generatePlaceholderMoods([int days=10]){
    List<MoodEntry> entries = [];
    Random rng = new Random();

    print("Generating entries for $days days...");
    
    DateTime now = DateTime.now();
    now = new DateTime.utc(now.year, now.month, now.day);
    DateTime currentDay = now.subtract(Duration(days: days-1));

    for(int i=0; i<days; i++){
      for(int hour=11; hour<24; hour+=5){
        currentDay = currentDay.subtract(Duration(hours: currentDay.hour - hour));
        MoodEntry entry = new MoodEntry(
          currentDay, 
          rng.nextInt(5),
        );

        entries.add(entry);
      }

      currentDay = currentDay.add(Duration(days: 1));
    }

    return entries;
  }

  static List<Widget> collectTimelineDays(List<MoodEntry> moodEntries){
    final List<Widget> timelineDayElements = [];

    //moodEntries.sort();
    print("${moodEntries.length} total entries.");

    /*
    TODO: This implementation has O(n + n*m complexity and needs to be improved!!)
    At least sort moodEntries (needs to implement sortable).
    */
    
    //Find the first day with a mood entry
    DateTime currentDay = DateTime.now();
    DateTime now = DateTime.now();
    for(int i=0; i<moodEntries.length; i++){
      if( moodEntries[i].time.isBefore(currentDay) ){
        currentDay = moodEntries[i].time;
      }
    }
    currentDay = new DateTime(currentDay.year, currentDay.month, currentDay.day);
    print("The first day is $currentDay");

    while(currentDay.isBefore(now)){
      MoodEntryDay day = new MoodEntryDay(currentDay);

      print("Looking for entries on $currentDay");

      for(int i=0; i<moodEntries.length; i++){
        MoodEntry e = moodEntries[i];
        DateTime dayOfMoodEntry = e.getDay();

        if( currentDay.compareTo(dayOfMoodEntry) != 0 ){
          continue;
        }
        print("mood entry found! $e");
        day.addMoodEntry(e.time, e.score);
      }

      timelineDayElements.add(day.generateListEntry());
      currentDay = currentDay.add(new Duration(days: 1));
    }

    return timelineDayElements;
  }
}