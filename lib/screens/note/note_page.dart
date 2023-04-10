import 'package:flutter/material.dart';
import 'package:projectapp/provider/note_provider.dart';
import 'package:projectapp/screens/note/note_list.dart';
import 'package:provider/provider.dart';

// note main page
class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
        builder: (BuildContext context, state, Widget? child) {
      return Container(
        child: state.fetching
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: state.data.isEmpty
                    ? const Center(child: Text("add new notes"))
                    : ListView.builder(
                        itemCount: state.data.length,
                        itemBuilder: (BuildContext context, int index) =>
                            NoteList(
                          index: index,
                          data: state.data[index],
                          state: state,
                        ),
                      ),
              ),
      );
    });
  }
}
