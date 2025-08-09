import 'package:flutter/material.dart';
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
      child: ClipRRect(
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
            tabs: [
              buildTabItem(context, AppStrings.signIN),
              buildTabItem(context, AppStrings.signUp),
              buildTabItem(context, AppStrings.admin),
              buildTabItem(context, AppStrings.guest),
            ],
          ),
        ),
      ),
    );
  }

  Tab buildTabItem(BuildContext context, String title) {
    return Tab(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
