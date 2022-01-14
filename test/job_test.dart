import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      // final job = Job.fromMap(null, 'abc');
      expect(
          () => Job.fromMap(null, 'abc'), throwsA(isInstanceOf<StateError>()));
    });

    test('job with all properties', () {
      final job = Job.fromMap({
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
      // expect(job.name, 'Blogging');
      // expect(job.ratePerHour, 10);
      // expect(job.id, 'abc');
      // 上の3行を下のようにまとめて書ける。でもその前にhashCodeとoperator ==をJob classに追加する必要あり
      expect(job, Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing name', () {
      expect(
          () => Job.fromMap({
                'ratePerHour': 10,
              }, 'abc'),
          throwsA(isInstanceOf<StateError>()));
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      final job = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job.toMap(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });

  group('equality', () {
    test('different properties, equality returns false', () {
      final job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      final job2 = Job(name: 'Podcasting', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('different properties, equality returns false', () {
      final job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      final job2 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job1 == job2, true);
    });
  });
}
