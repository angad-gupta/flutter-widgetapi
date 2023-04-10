import 'package:flutter/material.dart';
import 'package:projectapp/provider/note_provider.dart';
import 'package:projectapp/screens/greeting_page.dart';
import 'package:projectapp/screens/note/add_note.dart';
import 'package:projectapp/screens/note/note_page.dart';
import 'package:projectapp/screens/weather/weather_page.dart';
import 'package:provider/provider.dart';



// home page, this is main page of application

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  List<String> appbarNameList = ["Welcome page", "Note", "Weather"];
  String appBarName = "";
  int correntIndex = 0;

  onPageChange(int index) {
    pageController.jumpToPage(index);
    appBarName = appbarNameList[index];
    correntIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    appBarName = appbarNameList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(appBarName),
        actions: [
          correntIndex == 1
              ? AddNote(
                  context: context,
                  state: Provider.of<NoteProvider>(context, listen: false),
                )
              : const SizedBox(),
        ],
      ),
      floatingActionButton: correntIndex == 1
          ? AddNote(
              context: context,
              state: Provider.of<NoteProvider>(context, listen: false),
            )
          : null,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text(
                "hello user",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Greating page'),
              onTap: () {
                Navigator.pop(context);
                onPageChange(0);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.note,
              ),
              title: const Text('Note Section'),
              onTap: () {
                Navigator.pop(context);
                onPageChange(1);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.wb_sunny,
              ),
              title: const Text('Weather section'),
              onTap: () {
                Navigator.pop(context);
                onPageChange(2);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          GreetingPage(),
          NotePage(),
          WeatherPage(),
        ],
      ),
    );
  }
}
