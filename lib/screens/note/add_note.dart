import 'package:flutter/material.dart';

import 'package:projectapp/provider/note_provider.dart';

// add note dialog
class AddNote extends StatelessWidget {
  final NoteProvider state;
  final BuildContext context;
  AddNote({
    Key? key,
    required this.state,
    required this.context,
  }) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  addNote(NoteProvider state) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 220,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Note Title",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      controller: descController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Description",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                state.addNote(
                    context: context,
                    title: titleController.text,
                    desc: descController.text);
                titleController.clear();
                descController.clear();
              },
              child: const Text(
                "Add",
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
                "Cancel",
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
    return IconButton(
      onPressed: () {
        addNote(state);
      },
      icon: const Icon(
        Icons.add_circle,
        color: Colors.white,
        size: 25,
      ),
    );
  }
}
