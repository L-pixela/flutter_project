import 'package:flutter/material.dart';
import 'package:testing_project/Project/database/data.dart';
import 'package:testing_project/Project/model/journal.dart';
import 'package:testing_project/Project/view/entry/journal_entry.dart';

class JournalUtil {
  static Future<void> onAddNewJournal(BuildContext context,
      JournalService service, Journal? journal, int? index) async {
    final passedData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                JournalEntry(journal: journal, isEditMode: index != null)));

    if (passedData != null) {
      if (index == null) {
        service.addJournal(journals, passedData);
      } else {
        service.updateJournal(journals, passedData, index);
      }
    }
  }
}
