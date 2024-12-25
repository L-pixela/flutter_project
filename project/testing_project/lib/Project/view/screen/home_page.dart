import 'package:flutter/material.dart';
import 'package:testing_project/Project/database/data.dart';
import 'package:testing_project/Project/view/screen/profile_page.dart';
import 'package:testing_project/Project/widgets&utils/utils.dart';

import '../../database/profile_data.dart';
import '../../model/journal.dart';
import '../../widgets&utils/tabs.dart';
import '../tabs/journals_tab.dart';
import '../tabs/moodtracker_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  JournalService service = JournalService(journals);
  List<Widget> myTabs = [
    MyTab(
      tabIcon: Icons.home,
    ),
    MyTab(tabIcon: Icons.mood),
  ];

  void _onTapToProfile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => ProfilePage(
                  profileData: myProfile,
                )));
  }

  void _onAddNewJournal(
      BuildContext context, Journal? journal, int? index) async {
    await JournalUtil.onAddNewJournal(context, service, journal, index);
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
                shape: CircleBorder(),
                onPressed: () => _onAddNewJournal(context, null, null),
                tooltip: 'Add Journal',
                child: Icon(Icons.add),
              ),
            ),
          ),
          appBar: AppBar(
            title: const Text('Your Journal App'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: IconButton(
                    onPressed: () => _onTapToProfile(context),
                    icon: Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 36,
                    ),
                  ))
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
                MoodtrackerTab(),
              ])),
            ],
          )),
    );
  }
}
