import 'package:uuid/uuid.dart';
import 'moodtype.dart';

class Journal {
  static var uuid = Uuid();

  final String entryID;
  final String title;
  final DateTime date;
  final String content;
  final MoodType mood;

  Journal({
    required this.title,
    required this.content,
    required this.mood,
  })  : entryID = uuid.v4(),
        date = DateTime.now();
}

class JournalService {
  Map<MoodType, int> moodCount(List<Journal> journals) {
    Map<MoodType, int> moodCounts = {
      MoodType.happy: 0,
      MoodType.sad: 0,
      MoodType.mad: 0,
      MoodType.unfair: 0,
      MoodType.upset: 0,
    };

    for (var journal in journals) {
      moodCounts[journal.mood] = moodCounts[journal.mood]! + 1;
    }

    return moodCounts;
  }

  List<Map<String, dynamic>> getMoodPercentages(List<Journal> journals) {
    Map<MoodType, int> moodCounts = moodCount(journals);
    int totalJournal = journals.length;

    if (totalJournal == 0) {
      return [];
    }

    List<Map<String, dynamic>> moodPercentage = [];

    for (var mood in moodCounts.entries) {
      double percent = mood.value / totalJournal;
      moodPercentage.add({'percent': percent, 'color': mood.key.color});
    }

    return moodPercentage;
  }

  void addJournal(List<Journal> journal, Journal journals) {
    journal.add(journals);
  }

  void removeJournal(List<Journal> journal, Journal journals) {
    journal.remove(journals);
  }

  void updateJournal(List<Journal> journal, Journal journals, int index) {
    journal[index] = journals;
  }
}

void main() {
  JournalService journalService = JournalService();
  Journal journals1 = Journal(title: "A", content: "AAA", mood: MoodType.happy);
  Journal journals2 = Journal(title: "B", content: "AAA", mood: MoodType.happy);
  Journal journals3 = Journal(title: "C", content: "AAA", mood: MoodType.mad);

  List<Journal> journals = [];
  journals.add(journals1);
  journals.add(journals2);
  journals.add(journals3);

  Map<MoodType, int> moodCounts = journalService.moodCount(journals);

  moodCounts.forEach((mood, count) {
    print("${mood.moodType} : $count");
  });
}
