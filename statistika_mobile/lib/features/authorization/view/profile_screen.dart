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
  void initState() {
    super.initState();
    final state = context.read<UserProfileCubit>().state;
    if (state is UserProfileInitial) {
      birthday = state.user.userInfo?.birthday;
      switch (state.user.userInfo?.isMan) {
        case true:
          genderValue = Gender.male;
        case false:
          genderValue = Gender.female;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorizationCubit, AuthorizationState>(
      builder: (context, state) {
        return BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileInitial) {
              birthday = state.user.userInfo?.birthday;
              switch (state.user.userInfo?.isMan) {
                case true:
                  genderValue = Gender.male;
                case false:
                  genderValue = Gender.female;
                default:
              }
            }
          },
          builder: (context, userState) {
            return Padding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              child: RefreshIndicator(
                onRefresh: () async => context
                    .read<UserProfileCubit>()
                    .updateUserProfileInfo(genderValue, birthday),
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
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
                                      .updateUserProfileInfo(
                                          genderValue, birthday);
                                },
                                child: Text('Сохранить',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(color: AppColors.white)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          DropdownButton<Gender>(
                            isExpanded: true,
                            value: genderValue,
                            hint: const Text('Пол'),
                            style: context.textTheme.bodySmall,
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
                                  children: [
                                    Text(
                                      Gender.female.name,
                                    )
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) => setState(
                              () => genderValue = value,
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            onTap: () async {
                              birthday = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1920),
                                lastDate: DateTime(2020),
                              );
                              setState(() {});
                            },
                            title: Text(
                              birthday != null
                                  ? birthday.toString()
                                  : 'Выбрать дату рождения',
                              style: context.textTheme.bodySmall,
                            ),
                            trailing: Text(
                              userState is UserProfileInitial &&
                                      userState.user.userInfo?.birthday != null
                                  ? userState.user.userInfo!.birthday.toString()
                                  : 'Укажите',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
