import 'package:flutter/material.dart';
import 'package:testing_project/Project/database/data.dart';
import 'package:testing_project/Project/model/journal.dart';

import '../../widgets/mood_indicator.dart';

class MoodtrackerTab extends StatefulWidget {
  const MoodtrackerTab({super.key});

  @override
  State<MoodtrackerTab> createState() => _MoodtrackerTabState();
}

class _MoodtrackerTabState extends State<MoodtrackerTab> {
  final JournalService service = JournalService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            DynamicCircularPercentIndicator(
              moods: service.getMoodPercentages(journals),
            ),
          ],
        ),
      ),
    );
  }
}
