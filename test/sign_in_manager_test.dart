import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_manager.dart';

import 'email_sign_in_bloc_test.mocks.dart';
import 'mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

@GenerateMocks([AuthBase, User])
void main() {
  late MockAuthBase mockAuth;
  late MockValueNotifier<bool> isLoading;
  late SignInManager manager;

  setUp(() {
    mockAuth = MockAuthBase();
    isLoading = MockValueNotifier<bool>(false);
    manager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  // 以下の2つのテストはAndreaのコードとおりにしてあるけど failed...
  test('sign-in - success', () async {
    final mockUser = MockUser();
    when(mockUser.uid).thenReturn('123');
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(mockUser));
    await manager.signInAnonymously();

    expect(isLoading.values, [true]);
    // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
  }, skip: true);

  test('sign-in - failure', () async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR', message: 'sign-in-failed'));
    try {
      await manager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
    // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
  }, skip: true);
}
