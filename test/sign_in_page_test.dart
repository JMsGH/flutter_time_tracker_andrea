import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';

import 'sign_in_page_test.mocks.dart';

void main() {
  late MockAuthBase mockAuth;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAuth = MockAuthBase();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Future<void> pumpSignInPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(builder: (context) {
            return SignInPage.create(context);
          }),
          navigatorObservers: [mockNavigatorObserver],
        ),
      ),
    );
    //The argument type 'Null' can't be assigned to the parameter type 'Route<dynamic>'.
    //verify(mockNavigatorObserver.didPush(any, any)).called(1);
  }

  testWidgets('email & password navigation', (WidgetTester tester) async {
    await pumpSignInPage(tester);

    final emailSignInButton = find.byKey(SignInPage.emailPasswordKey);
    expect(emailSignInButton, findsOneWidget);

    await tester.tap(emailSignInButton);
    await tester.pumpAndSettle();

    //The argument type 'Null' can't be assigned to the parameter type 'Route<dynamic>'.
    verify(mockNavigatorObserver.didPush(any, any)).called(1);
    // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
  }, skip: true);
}
