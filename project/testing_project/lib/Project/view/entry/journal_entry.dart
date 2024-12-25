import 'package:flutter/material.dart';

import '../../model/journal.dart';
import '../../model/moodtype.dart';
import '../../widgets&utils/app_button.dart';

class JournalEntry extends StatefulWidget {
  final Journal? journal;
  final bool isEditMode;
  final Function(Journal)? onSave;
  const JournalEntry(
      {super.key, this.journal, required this.isEditMode, this.onSave});

  @override
  State<JournalEntry> createState() => _JournalEntryState();
}

class _JournalEntryState extends State<JournalEntry> {
  final _formKey = GlobalKey<FormState>();
  String? title = '';
  String? content = '';
  MoodType? moodType = MoodType.happy;

  @override
  void initState() {
    if (widget.isEditMode && widget.journal != null) {
      title = widget.journal!.title;
      content = widget.journal!.content;
      moodType = widget.journal!.mood;
    } else {
      title = '';
      content = '';
      moodType = MoodType.happy;
    }
    super.initState();
  }

  void onSaved(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      final passedData =
          Journal(title: title!, content: content!, mood: moodType!);

      Navigator.pop(context, passedData);
    }
  }

  String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return "Enter at least one character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Journal Entry"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: title,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellowAccent)),
                    hintText: 'Title',
                  ),
                  validator: validateTitle,
                  onSaved: (value) {
                    title = value;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: content,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your feelings',
                  ),
                  onSaved: (value) {
                    content = value;
                  },
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<MoodType>(
                  value: moodType,
                  items: [
                    for (final mood in MoodType.values)
                      DropdownMenuItem<MoodType>(
                        value: mood,
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              color: mood.color,
                            ),
                            SizedBox(width: 10),
                            Text(mood.moodType),
                          ],
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      moodType = value;
                    });
                  },
                  onSaved: (value) {
                    moodType = value;
                  },
                ),
                SizedBox(height: 20),
                AppButton(title: "Save", onPressed: () => onSaved(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
