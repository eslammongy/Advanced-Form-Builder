import 'package:flutter/material.dart';
import 'package:form_builder/form_builder/widgets/app_tab_bar.dart';
import 'package:form_builder/form_builder/widgets/signin_form.dart';
import 'package:form_builder/form_builder/widgets/signup_form.dart';
import 'package:form_builder/utils/app_extensions.dart';
import 'package:form_builder/utils/sizer_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: 60.h,
          right: 20.w,
          left: 20.w,
          bottom: 30.h,
        ),
        child: DefaultTabController(
          length: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.person_rounded, size: 100.h),
              Text("Form Builder", style: context.textTheme.titleLarge),
              SizerUtil.gapH(40),
              AppTabBar(),
              SizerUtil.gapH(40),
              Expanded(
                child: TabBarView(
                  children: [
                    SignInForm(),
                    SignUpForm(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
