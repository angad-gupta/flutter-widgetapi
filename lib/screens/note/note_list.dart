import 'package:flutter/material.dart';
import 'package:projectapp/model/note_model.dart';
import 'package:projectapp/provider/note_provider.dart';
import 'package:projectapp/screens/note/update_note.dart';

import 'delete_note.dart';

// note listing page
class NoteList extends StatelessWidget {
  final NoteModel data;
  final NoteProvider state;

  final int index;

  const NoteList(
      {super.key,
      required this.data,
      required this.state,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              data.desc,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 12),
              maxLines: 10,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                UpdateNote(
                  state: state,
                  context: context,
                  index: index,
                ),
                DeleteNote(context: context, state: state, index: index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
