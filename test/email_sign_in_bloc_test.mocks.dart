// Mocks generated by Mockito 5.0.0 from annotations
// in time_tracker_flutter_course/test/email_sign_in_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:firebase_auth/firebase_auth.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:time_tracker_flutter_course/app/services/auth.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeUser extends _i1.Fake implements _i2.User {}

/// A class which mocks [AuthBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthBase extends _i1.Mock implements _i3.AuthBase {
  MockAuthBase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<_i2.User?> authStateChanges() =>
      (super.noSuchMethod(Invocation.method(#authStateChanges, []),
          returnValue: Stream<_i2.User?>.empty()) as _i4.Stream<_i2.User?>);
  @override
  _i4.Future<_i2.User> signInAnonymously() =>
      (super.noSuchMethod(Invocation.method(#signInAnonymously, []),
          returnValue: Future.value(_FakeUser())) as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> signInWithEmailAndPassword(
          String? email, String? password) =>
      (super.noSuchMethod(
          Invocation.method(#signInWithEmailAndPassword, [email, password]),
          returnValue: Future.value(_FakeUser())) as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> createUserWithEmailAndPassword(
          String? email, String? password) =>
      (super.noSuchMethod(
          Invocation.method(#createUserWithEmailAndPassword, [email, password]),
          returnValue: Future.value(_FakeUser())) as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> signInWithGoogle() =>
      (super.noSuchMethod(Invocation.method(#signInWithGoogle, []),
          returnValue: Future.value(_FakeUser())) as _i4.Future<_i2.User>);
  @override
  _i4.Future<_i2.User> signInWithFacebook() =>
      (super.noSuchMethod(Invocation.method(#signInWithFacebook, []),
          returnValue: Future.value(_FakeUser())) as _i4.Future<_i2.User>);
  @override
  _i4.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i4.Future<void>);
}
