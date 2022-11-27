import 'package:clean_architecture/2_application/2_application.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  group(
    'GoldenBuilder',
    () {
      testGoldens(
        'Custom Button should look correct',
        (tester) async {
          final GoldenBuilder builder = GoldenBuilder.grid(columns: 1, widthToHeightRatio: 1)
            ..addScenario(
              'Disabled',
              const CustomButton(),
            )
            ..addScenario(
              'Enabled',
              CustomButton(
                onTap: () {},
              ),
            );
          await tester.pumpWidgetBuilder(builder.build());
          await screenMatchesGolden(tester, 'custom_button_enabled_golden_toolkit');
        },
        tags: ['golden_toolkit'],
      );
    },
  );
}
