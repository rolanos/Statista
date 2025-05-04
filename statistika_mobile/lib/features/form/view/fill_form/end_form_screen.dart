import 'package:flutter/material.dart';

class EndFormScreen extends StatelessWidget {
  const EndFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Спасибо за прохождение формы,\nформа успешно отправлена'),
      ],
    );
  }
}
