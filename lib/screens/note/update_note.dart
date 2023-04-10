import 'package:flutter/material.dart';

import 'package:projectapp/provider/note_provider.dart';

// updae note dialog
class UpdateNote extends StatelessWidget {
  NoteProvider state;
  BuildContext context;
  int index;
  UpdateNote({
    Key? key,
    required this.state,
    required this.context,
    required this.index,
  }) : super(key: key);

  updateNote(NoteProvider state, int index) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    maxLines: 4,
                    controller: descController,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                state.updateNote(
                    context: context,
                    index: index,
                    title: titleController.text,
                    desc: descController.text);
              },
              child: const Text(
                "Update",
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

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = state.data[index].title;
    descController.text = state.data[index].desc;

    return TextButton(
      child: const Text(" Update",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: Colors.blue)),
      onPressed: () {
        updateNote(state, index);
      },
    );
  }
}
