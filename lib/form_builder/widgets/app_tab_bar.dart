import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_controller.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/form_builder/widgets/tab_bar_item.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/app_extensions.dart';
import 'package:form_builder/utils/sizer_util.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: Consumer(
        builder: (context, ref, child) {
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: ColoredBox(
              color: context.colorScheme.surface,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: context.customColors.textPrimary,
                onTap: (value) {
                  final formNotifier = ref.read(formNotifierProvider.notifier);
                  if (value == 1) {
                    formNotifier.setFormType(type: FormType.signUp);
                  } else if (value == 2) {
                    formNotifier.setFormType(type: FormType.admin);
                  } else if (value == 3) {
                    formNotifier.setFormType(type: FormType.guest);
                  } else {
                    formNotifier.setFormType();
                  }
                },

                tabs: [
                  TabItem(title: AppStrings.signIN),
                  TabItem(title: AppStrings.signUp),
                  TabItem(title: AppStrings.admin),
                  TabItem(title: AppStrings.guest),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
