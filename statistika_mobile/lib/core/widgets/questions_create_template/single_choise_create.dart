import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

class SingleChoiseCreateWidget extends StatefulWidget {
  const SingleChoiseCreateWidget({
    super.key,
    required this.question,
    this.onAddAnswer,
  });

  final Question question;

  final Function()? onAddAnswer;

  @override
  State<SingleChoiseCreateWidget> createState() =>
      _SingleChoiseCreateWidgetState();
}

class _SingleChoiseCreateWidgetState extends State<SingleChoiseCreateWidget> {
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.question.title.isNotEmpty) {
      titleController.text = widget.question.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstants.smallPadding,
      children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(hintText: 'Текст вопроса'),
        ),
        ReorderableListView.builder(
          shrinkWrap: true,
          itemCount: widget.question.availableAnswers.length,
          onReorder: (int oldIndex, int newIndex) {},
          itemBuilder: (BuildContext context, int index) => ListTile(
            key: ValueKey(widget.question.availableAnswers[index].id),
            title: Text(
              widget.question.availableAnswers[index].text ?? 'Пустой ответ',
            ),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: widget.onAddAnswer,
              child: const Icon(Icons.add, color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }
}
