import 'package:alchemist/alchemist.dart';
import 'package:clean_architecture/2_application/2_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomButton Alchemist Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'custom_button_alchemist',
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 600),
        children: [
          GoldenTestScenario(
            name: 'Enabled',
            child: CustomButton(
              onTap: () {},
            ),
          ),
          GoldenTestScenario(
            name: 'Disabled',
            child: const CustomButton(),
          ),
        ],
      ),
      tags: ['alchemist'],
    );
  });
}
