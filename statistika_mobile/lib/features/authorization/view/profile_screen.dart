import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Сохранить', style: context.textTheme.bodySmall),
                ),
              ],
            ),
            const Spacer(),
            TextFormField(decoration: InputDecoration(hintText: 'D')),
            const Spacer(),
          ],
        );
      },
    );
  }
}
