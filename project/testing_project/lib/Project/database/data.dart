import '../model/journal.dart';
import '../model/moodtype.dart';

List<Journal> journals = [
  Journal(
    title: "Journal 1",
    content:
        "this is for testing, this is for testing, this is for testing, this is for testing",
    mood: MoodType.happy,
  ),
  Journal(
    title: "Journal 2",
    content: "this is for testing1",
    mood: MoodType.mad,
  ),
  Journal(
    title: "Journal 3",
    content: "this is for testing2",
    mood: MoodType.sad,
  ),
  Journal(title: "Journal 4", content: "Content", mood: MoodType.unfair),
  Journal(title: "Journal 5", content: "Content", mood: MoodType.upset),
  Journal(title: "Journal 6", content: "Content", mood: MoodType.mad),
  Journal(title: "Journal 7", content: "Content", mood: MoodType.sad),
];
