import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:testing_project/Project/model/moodtype.dart';
import 'package:testing_project/Project/widgets&utils/utils.dart';

import '../../database/data.dart';
import '../../model/journal.dart';
import '../../widgets&utils/journal_grid_tile.dart';

class JournalsTab extends StatefulWidget {
  const JournalsTab({super.key});

  @override
  State<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends State<JournalsTab> {
  final String emptyJournal = "There is no journal entry";
  MoodType? selectedMood;

  @override
  void initState() {
    super.initState();
  }

  void _onDeleteJournal(Journal journal) {
    Provider.of<JournalService>(context, listen: false).removeJournal(journal);
  }

  void _onEditJournal(BuildContext context, Journal journal, int index) async {
    await JournalUtil.onAddNewJournal(
        context,
        Provider.of<JournalService>(context, listen: false),
        journals[index],
        index);
  }

  void _onSortJournal(MoodType mood) {
    Provider.of<JournalService>(context, listen: false).sortJournal(mood);
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Consumer<JournalService>(builder: (context, service, child) {
      final journals = service.journals;
      Widget content = Center(
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

      if (journals.isNotEmpty) {
        content = GridView.builder(
            itemCount: journals.length,
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context) ? 2 : 5),
            itemBuilder: (context, index) {
              return JournalGridTile(
                journal: journals[index],
                onDelete: () => _onDeleteJournal(journals[index]),
                onEdit: () => _onEditJournal(context, journals[index], index),
              );
            });
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Filter by:"),
              DropdownButton<MoodType>(
                value: selectedMood,
                hint: Text('Select Mood'),
                items: MoodType.values.map((MoodType mood) {
                  return DropdownMenuItem<MoodType>(
                    value: mood,
                    child: Text(mood.moodType),
                  );
                }).toList(),
                onChanged: (MoodType? newValue) {
                  if (newValue != null) {
                    _onSortJournal(newValue);
                    selectedMood = newValue;
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: content,
          )
        ],
      );
    });
  }
}
