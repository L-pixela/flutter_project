import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:testing_project/Project/widgets/utils.dart';

import '../../database/data.dart';
import '../../model/journal.dart';

class JournalsTab extends StatefulWidget {
  const JournalsTab({super.key});

  @override
  State<JournalsTab> createState() => _JournalsTabState();
}

class _JournalsTabState extends State<JournalsTab> {
  final JournalService service = JournalService();
  final String emptyJournal = "There is no journal entry";

  void _onDeleteJournal(Journal journal) {
    setState(() {
      service.removeJournal(journals, journal);
    });
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
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
              onEdit: () => JournalUtil.onAddNewJournal(
                  context, service, journals[index], index),
            );
          });
    }
    return content;
  }
}

class JournalGridTile extends StatelessWidget {
  final Journal journal;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const JournalGridTile(
      {super.key,
      required this.journal,
      required this.onEdit,
      required this.onDelete});

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: journal.mood.color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 5, offset: Offset(0.5, 1))
            ]),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(14),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    padding:
                        EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
                    child: Center(
                        child: Text(
                      DateFormat.yMd().format(journal.date),
                      style: TextStyle(
                        fontSize: isMobile(context) ? 12 : 12,
                      ),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: isMobile(context) ? 24 : 6,
              ),
              Text(
                journal.title,
                style: TextStyle(fontSize: isMobile(context) ? 18 : 12),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
                  IconButton(onPressed: onDelete, icon: Icon(Icons.delete))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
