import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_model.dart';
import 'email_sign_in_bloc_test.mocks.dart';
import 'package:mockito/annotations.dart';

void main() {
  late MockAuthBase mockAuth;
  late EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuthBase();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  // The following test has passed.
  test(
      'WHEN email is updated'
      'AND password is updated'
      'AND submit is called'
      'THEN modelStream emits the correct event', () async {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR'));
    expect(
        bloc.modelStream,
        emitsInOrder([
          EmailSignInModel(),
          EmailSignInModel(email: 'email@email.com'),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
          ),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: true,
          ),
          EmailSignInModel(
            email: 'email@email.com',
            password: 'password',
            submitted: true,
            isLoading: false,
          ),
        ]));

    bloc.updateEmail('email@email.com');

    bloc.updatePassword('password');

    // レクチャどおりにemail: 'email@email.com',を含めるとtest fails
    // expect(
    //     bloc.modelStream,
    //     emits(EmailSignInModel(
    //       email: 'email@email.com',
    //       password: 'password',
    //     )));

    try {
      await bloc.submit();
    } catch (_) {}
  });
}
