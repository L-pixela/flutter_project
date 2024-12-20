import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      if (!context.mounted) return; // Check if the context is still mounted
      final journalService =
          Provider.of<JournalService>(context, listen: false);
      if (index == null) {
        journalService.addJournal(passedData);
      } else {
        journalService.updateJournal(passedData, index);
      }
    }
  }
}
