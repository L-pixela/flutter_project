import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/journal.dart';

class JournalTile extends StatelessWidget {
  final Journal journal;
  const JournalTile({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: journal.mood.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
              child: Image.asset(
            journal.mood.icons,
            width: 60,
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(journal.title),
          )),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 15, 0),
                child: Text(
                  DateFormat.MMM().format(journal.date),
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 8),
                child: Text(DateFormat.d().format(journal.date)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
