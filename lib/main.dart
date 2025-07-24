import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/widgets/home_screen.dart';
import 'package:form_builder/theme/app_theme.dart';
import 'package:form_builder/utils/sizer_util.dart';

void main() {
 runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizerUtil.init(context);
    return MaterialApp(
      title: "FormBuilder",
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
