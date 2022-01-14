import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_elevated_button.dart';

void main() {
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;
    const childWidget = Text('TEST');
    await tester.pumpWidget(MaterialApp(
      home: CustomElevatedButton(
        child: childWidget,
        onPressed: () => pressed = true,
      ),
    ));
    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
    expect(find.byWidget(childWidget), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
    expect(find.text('TEST'), findsOneWidget);
    await tester.tap(button);
    expect(pressed, true);
  });
}
