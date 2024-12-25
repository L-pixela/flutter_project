import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/journal.dart';

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
