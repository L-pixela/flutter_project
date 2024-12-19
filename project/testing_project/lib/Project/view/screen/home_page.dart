import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing_project/Project/widgets/utils.dart';

import '../../model/journal.dart';
import '../../widgets/tabs.dart';
import '../tabs/journals_tab.dart';
import '../tabs/moodtracker_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JournalService service = JournalService();
  List<Widget> myTabs = [
    MyTab(
      tabIcon: Icons.home,
    ),
    MyTab(tabIcon: Icons.mood)
  ];

  void _onAddNewJournal(
      BuildContext context, Journal? journal, int? index) async {
    await JournalUtil.onAddNewJournal(context, service, journal, index);
    setState(() {});
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          floatingActionButton: Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => _onAddNewJournal(context, null, null),
                tooltip: 'Add Journal',
                child: Icon(Icons.add),
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Home Page'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 25),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 36,
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                child: Row(
                  children: [
                    Text(
                      "Hi There! Welcome to ",
                      style: TextStyle(fontSize: isMobile(context) ? 12 : 18),
                    ),
                    Text(
                      "JOURNAL",
                      style: TextStyle(
                          fontSize: isMobile(context) ? 14 : 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              // my Tabs
              TabBar(tabs: myTabs),

              //my tabs view

              Expanded(
                  child: TabBarView(children: [
                // journal tab
                JournalsTab(),
                // mood tracker tab
                MoodtrackerTab()
              ])),
            ],
          )),
    );
  }
}

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
