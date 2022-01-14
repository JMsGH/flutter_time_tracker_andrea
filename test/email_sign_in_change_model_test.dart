import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_change_model.dart';
import 'email_sign_in_bloc_test.mocks.dart';

void main() {
  MockAuthBase mockAuth;
  late EmailSignInChangeModel model;

  setUp(() {
    mockAuth = MockAuthBase();
    model = EmailSignInChangeModel(auth: mockAuth);
  });

  // The below test has passed!
  test('updateEmail', () {
    var didNotifyListeners = false;
    model.addListener(() => didNotifyListeners = true);
    const sampleEmail = 'email@cmail.com';
    model.updateEmail(sampleEmail);
    expect(model.email, sampleEmail);
    expect(didNotifyListeners, true);
  });
}
