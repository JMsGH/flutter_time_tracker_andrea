import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/home_page.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'landing_page_test.mocks.dart';

void main() {
  late MockAuthBase mockAuth;
  late MockDatabase mockDatabase;
  late StreamController<User?> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuthBase();
    mockDatabase = MockDatabase();
    onAuthStateChangedController = StreamController<User?>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase?>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: LandingPage(
            databaseBuilder: (_) => mockDatabase,
          ),
        ),
      ),
    );
    await tester.pump();
  }

  void stubOnAuthStateChangedYields(Iterable<User?> onAuthStateChanged) {
    onAuthStateChangedController.addStream(
      Stream<User?>.fromIterable(onAuthStateChanged),
    );
    when(mockAuth.authStateChanges()).thenAnswer((_) {
      return onAuthStateChangedController.stream;
    });
  }

  // テストで次のエラー
  // The following _TypeError was thrown running a test:
  // type 'Null' is not a subtype of type 'Stream<User?>'
  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([]);

    await pumpLandingPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  // test/landing_page_test.dart:62:35:
  // Error: The value 'null' can't be assigned to a variable of type 'User' because 'User' is not nullable.
  testWidgets('null user', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([null]);

    await pumpLandingPage(tester);

    expect(find.byType(SignInPage), findsOneWidget);
    // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
  }, skip: true);

  // The following _TypeError was thrown running a test:
  // type 'Null' is not a subtype of type 'String'
  testWidgets('non-null user', (WidgetTester tester) async {
    final mockUser = MockUser();
    when(mockUser.uid).thenReturn('123');
    stubOnAuthStateChangedYields([mockUser]);

    await pumpLandingPage(tester);

    expect(find.byType(HomePage), findsOneWidget);
    // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
  }, skip: true);
}
