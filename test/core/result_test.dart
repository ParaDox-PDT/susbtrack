import 'package:flutter_test/flutter_test.dart';
import 'package:substrack/core/error/failures.dart';
import 'package:substrack/core/utils/result.dart';

void main() {
  group('Result functional pattern tests', () {
    test('Success returns correct data and reports isSuccess = true', () {
      const result = Result<String, Failure>.success('hello');
      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.dataOrNull, equals('hello'));
      expect(result.errorOrNull, isNull);
    });

    test('Failure returns correct error and reports isFailure = true', () {
      const failure = ServerFailure(message: 'Server error', statusCode: 500);
      const result = Result<String, Failure>.failure(failure);
      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.errorOrNull, equals(failure));
    });

    test('fold correctly invokes branch handlers', () {
      const success = Result<int, Failure>.success(42);
      final val = success.fold(
        onSuccess: (d) => d * 2,
        onFailure: (f) => 0,
      );
      expect(val, equals(84));
    });
  });
}
