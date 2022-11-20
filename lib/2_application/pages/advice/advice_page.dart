import 'package:clean_architecture/2_application/pages/advice/widgets/custom_button.dart';
import 'package:clean_architecture/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/theme_service.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adviser',
          style: themeData.textTheme.headline1,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: const [
            Expanded(
              child: Center(
                child: ErrorMessage(message: 'message'),
                // child: Text(
                //   'Your advice is waiting for you!',
                //   style: themeData.textTheme.headline1  ,
                // ),
                // child: CircularProgressIndicator(
                //   color: themeData.colorScheme.secondary,
                // ),
              ),
            ),
            CustomButton(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
