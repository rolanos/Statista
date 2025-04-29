import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statistika_mobile/core/constants/constants.dart';
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

  final nameController = TextEditingController();

  final nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final state = context.read<UserProfileCubit>().state;
    nameController.addListener(() => setState(() {}));
    if (state is UserProfileInitial) {
      nameController.text = state.user.userInfo?.name ?? '';
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
            final showSaveButton = (userState is UserProfileLoading ||
                (userState is UserProfileInitial &&
                    userState.notCompare(
                      nameController.text.trim(),
                      genderValue?.isMan(),
                      birthday,
                    )));
            return RefreshIndicator(
              onRefresh: () async => context.read<UserProfileCubit>().update(),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppConstants.mediumPadding,
                            right: AppConstants.mediumPadding,
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              Visibility(
                                visible: showSaveButton,
                                maintainAnimation: true,
                                maintainState: true,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 256),
                                  curve: Curves.fastOutSlowIn,
                                  opacity: showSaveButton ? 1 : 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UserProfileCubit>()
                                          .updateUserProfileInfo(
                                            nameController.text.trim(),
                                            genderValue,
                                            birthday,
                                          );
                                    },
                                    child: userState is UserProfileLoading
                                        ? SizedBox(
                                            height: (context.textTheme
                                                        .bodyMedium?.fontSize ??
                                                    12) *
                                                (context.textTheme.bodyMedium
                                                        ?.height ??
                                                    1),
                                            width: (context.textTheme.bodyMedium
                                                        ?.fontSize ??
                                                    12) *
                                                (context.textTheme.bodyMedium
                                                        ?.height ??
                                                    1),
                                            child:
                                                const CircularProgressIndicator(
                                              color: AppColors.white,
                                            ),
                                          )
                                        : Text(
                                            'Сохранить',
                                            style: context.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: AppColors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin:
                              const EdgeInsets.all(AppConstants.mediumPadding),
                          padding:
                              const EdgeInsets.all(AppConstants.mediumPadding),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: AppTheme.smallShadows,
                            borderRadius: BorderRadius.circular(
                              AppConstants.mediumPadding,
                            ),
                          ),
                          child: Column(
                            children: [
                              TapRegion(
                                onTapOutside: (event) =>
                                    nameFocusNode.unfocus(),
                                child: TextField(
                                  controller: nameController,
                                  focusNode: nameFocusNode,
                                  style: context.textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: 'Ваше имя',
                                    hintStyle: context.textTheme.bodyMedium,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              const Divider(),
                              DropdownButton<Gender>(
                                isExpanded: true,
                                value: genderValue,
                                hint: const Text(
                                  'Пол',
                                ),
                                underline: const SizedBox(),
                                style: context.textTheme.bodyMedium,
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
                              const Divider(),
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
                                      ? 'День рождения'
                                      : 'Выбрать дату рождения',
                                  style: context.textTheme.bodyMedium,
                                ),
                                trailing: Text(
                                  birthday != null
                                      ? birthday!.toFormattedString()
                                      : 'Пусто',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
