import 'package:flutter/material.dart';
import 'package:form_builder/form_builder/widgets/app_tab_bar.dart';
import 'package:form_builder/utils/sizer_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(
          top: 100.h,
          right: 20.w,
          left: 20.w,
          bottom: 30.h,
        ),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              AppTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(),
                    Container(),
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
