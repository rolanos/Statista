import 'package:flutter/material.dart';
import 'package:statistika_mobile/core/constants/app_constants.dart';

class GeneralQuestionScreen extends StatelessWidget {
  const GeneralQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: RefreshIndicator(
        onRefresh: () => Future.delayed(Duration(seconds: 2)),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 100,
                        height: 100,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
