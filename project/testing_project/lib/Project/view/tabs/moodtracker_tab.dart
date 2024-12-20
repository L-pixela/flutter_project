import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/Project/database/data.dart';
import 'package:testing_project/Project/model/journal.dart';
import 'package:testing_project/Project/model/moodtype.dart';

import '../../widgets/mood_indicator.dart';

class MoodtrackerTab extends StatefulWidget {
  const MoodtrackerTab({super.key});

  @override
  State<MoodtrackerTab> createState() => _MoodtrackerTabState();
}

class _MoodtrackerTabState extends State<MoodtrackerTab> {
  final JournalService service = JournalService(journals);
  final String emptyJournal = "No Journal Data Found!";

  @override
  void initState() {
    super.initState();
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalService>(
      builder: (context, service, child) {
        Map<MoodType, int> moodCount = JournalService(journals).moodCount();
        Widget moodTracker = Center(
          child: Column(
            children: [
              Lottie.asset("assets/animation_gif/empty_journal_whale.json",
                  width: isMobile(context) ? 200 : 250,
                  height: isMobile(context) ? 200 : 250),
              Text(
                emptyJournal,
                style: TextStyle(
                    fontSize: isMobile(context) ? 12 : 14, color: Colors.grey),
              )
            ],
          ),
        );

        Widget moodTrackerContent = Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust the number of columns as needed
              childAspectRatio: 4, // Adjust the aspect ratio to fit your design
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: moodCount.entries.length,
            itemBuilder: (context, index) {
              final mood = moodCount.entries.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: isMobile(context) ? 25 : 40,
                    height: isMobile(context) ? 25 : 40,
                    decoration: BoxDecoration(color: mood.key.color),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    mood.key.moodType,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile(context) ? 14 : 24),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    mood.value.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile(context) ? 14 : 24),
                  )
                ],
              );
            },
          ),
        );

        if (journals.isNotEmpty) {
          moodTracker = SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Your Mood Tracker: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile(context) ? 16 : 26),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DynamicCircularPercentIndicator(
                        moods: service.getMoodPercentages(journals),
                      ),
                    ),
                    moodTrackerContent
                  ],
                ),
              ),
            ),
          );
        }

        return moodTracker;
      },
    );
  }
}
