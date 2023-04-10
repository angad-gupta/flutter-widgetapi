import 'package:flutter/material.dart';

import 'package:projectapp/provider/note_provider.dart';

// delete note dialog
class DeleteNote extends StatelessWidget {
  final NoteProvider state;
  final int index;
  final BuildContext context;
  const DeleteNote({
    Key? key,
    required this.state,
    required this.index,
    required this.context,
  }) : super(key: key);
  delete(NoteProvider state, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 50,
            child: Column(
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Are you sure your want to delete ?")),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                state.deleteNote(index: index, context: context);
              },
              child: const Text(
                "yes",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "no",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          delete(state, index);
        },
        child: const Icon(Icons.delete));
  }
}
