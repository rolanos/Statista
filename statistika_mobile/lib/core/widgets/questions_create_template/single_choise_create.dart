import 'package:flutter/material.dart';

class SingleChoiseCreateWidget extends StatelessWidget {
  const SingleChoiseCreateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(hintText: 'Текст вопроса'),
        ),
        ReorderableList(
          shrinkWrap: true,
          itemCount: 5,
          onReorder: (int oldIndex, int newIndex) {},
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(
              index.toString(),
            ),
          ),
        ),
      ],
    );
  }
}
