import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/features/form/domain/model/available_answer.dart';
import 'package:statistika_mobile/features/form/domain/model/question.dart';

class SingleChoiseCreateWidget extends StatefulWidget {
  const SingleChoiseCreateWidget({
    super.key,
    required this.question,
    this.onDeleteQuestion,
    this.onAddAnswer,
    this.onUpdateTitle,
    this.onDeleteAvailableAnswer,
    this.onUpdateAvailableAnswer,
  });

  final Question question;

  final Function(Question)? onDeleteQuestion;

  final Function()? onAddAnswer;

  final Function(String)? onUpdateTitle;

  final Function(AvailableAnswer)? onDeleteAvailableAnswer;

  final Function(AvailableAnswer, String)? onUpdateAvailableAnswer;

  @override
  State<SingleChoiseCreateWidget> createState() =>
      _SingleChoiseCreateWidgetState();
}

class _SingleChoiseCreateWidgetState extends State<SingleChoiseCreateWidget> {
  final titleController = TextEditingController();

  final availableControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    if (widget.question.title.isNotEmpty) {
      titleController.text = widget.question.title;
      titleController.addListener(() {
        if (widget.onUpdateTitle != null) {
          if (titleController.text != widget.question.title) {
            widget.onUpdateTitle!(titleController.text);
          }
        } else {}
      });
    }
    if (widget.question.availableAnswers.isNotEmpty) {
      for (var available in widget.question.availableAnswers) {
        var controller = TextEditingController(text: available.text);
        availableControllers.add(controller);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppConstants.smallPadding,
      children: [
        Row(
          children: [
            Flexible(
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Текст вопроса'),
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.onDeleteQuestion != null) {
                  widget.onDeleteQuestion!(widget.question);
                }
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.question.availableAnswers.length,
          onReorder: (int oldIndex, int newIndex) {},
          itemBuilder: (BuildContext context, int index) => ListTile(
            key: ValueKey(widget.question.availableAnswers[index].id),
            leading: const Text('•'),
            title: TextFormField(
              controller: availableControllers[index],
              decoration: const InputDecoration(hintText: 'Текст вопроса'),
            ),
            contentPadding: EdgeInsets.zero,
            trailing: IconButton(
              onPressed: () {
                if (widget.onDeleteAvailableAnswer != null) {
                  widget.onDeleteAvailableAnswer!(
                    widget.question.availableAnswers[index],
                  );
                }
              },
              icon: const Icon(Icons.delete),
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
