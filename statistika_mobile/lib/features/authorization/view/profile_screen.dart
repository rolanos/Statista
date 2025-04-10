import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';
import 'package:statistika_mobile/core/utils/extensions.dart';
import 'package:statistika_mobile/features/authorization/domain/enum/gender.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/authorization_cubit.dart';
import 'package:statistika_mobile/features/authorization/view/cubit/user_profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Gender? genderValue;

  DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<UserProfileCubit>()
                          .updateUserProfileInfo(genderValue, birthday);
                    },
                    child: Text('Сохранить',
                        style: context.textTheme.bodySmall
                            ?.copyWith(color: AppColors.white)),
                  ),
                ],
              ),
              const Spacer(),
              DropdownButton<Gender>(
                value: genderValue,
                hint: const Text('Пол'),
                items: [
                  DropdownMenuItem(
                    value: Gender.male,
                    child: Row(
                      children: [Text(Gender.male.name)],
                    ),
                  ),
                  DropdownMenuItem(
                    value: Gender.female,
                    child: Row(
                      children: [Text(Gender.female.name)],
                    ),
                  ),
                ],
                onChanged: (value) => setState(
                  () => genderValue = value,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  birthday = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1920),
                    lastDate: DateTime(2020),
                  );
                  setState(() {});
                },
                child: Text(
                  birthday != null
                      ? birthday.toString()
                      : 'Выбрать дату рождения',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
