import 'package:flutter/material.dart';

enum MoodType {
  happy(
      moodType: "Happy",
      icons: "assets/mood_emoji/happy.png",
      color: Colors.yellow),
  mad(moodType: "Mad", icons: "assets/mood_emoji/mad.webp", color: Colors.red),
  sad(moodType: "Sad", icons: "assets/mood_emoji/sad.png", color: Colors.blue),
  upset(
      moodType: "Upset",
      icons: "assets/mood_emoji/happy.png",
      color: Colors.lightBlue),
  unfair(
      moodType: "Unfair",
      icons: "assets/mood_emoji/happy.png",
      color: Colors.indigoAccent),
  neutral(
      moodType: "Neutral",
      icons: "assets/mood_emoji/happy.png",
      color: Colors.blueGrey);

  final String moodType;
  final String icons;
  final Color color;

  const MoodType(
      {required this.moodType, required this.icons, required this.color});

  @override
  String toString() => moodType;
}
