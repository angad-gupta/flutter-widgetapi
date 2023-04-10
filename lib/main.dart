import 'package:flutter/material.dart';
import 'package:projectapp/provider/note_provider.dart';
import 'package:projectapp/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // here we use provider for note module
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NoteProvider())],
      child: MaterialApp(
        title: 'Project Application',
        theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
