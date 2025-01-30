import 'package:test/test.dart';
import 'package:tikka/util/rest_response.dart';

void main() {
  group('RestResponse', () {
    group('Success', () {
      test('should hold data', () {
        final data = {'key': 'value'};
        final successResponse = Success(data);
        expect(successResponse.data, data);
      });

      test('should handle null data', () {
        final successResponse = Success<Map<String, String>?>(null);
        expect(successResponse.data, null);
      });


      test('should handle different data types', () {
        final intData = 123;
        final intSuccessResponse = Success(intData);
        expect(intSuccessResponse.data, intData);

        final stringData = 'test string';
        final stringSuccessResponse = Success(stringData);
        expect(stringSuccessResponse.data, stringData);

        final listData = [1, 2, 3];
        final listSuccessResponse = Success(listData);
        expect(listSuccessResponse.data, listData);
      });
    });

    group('Failure', () {
      test('should hold error message', () {
        final errorMessage = 'Something went wrong';
        final failureResponse = Failure(errorMessage);
        expect(failureResponse.errorMessage, errorMessage);
      });

      test('should handle empty error message', () {
        final failureResponse = Failure('');
        expect(failureResponse.errorMessage, '');
      });
    });

        test('should differentiate between Success and Failure', () {
          final successResponse = Success(1);
          final failureResponse = Failure('Error');

          expect(successResponse, isA<Success>());
          expect(failureResponse, isA<Failure>());
          expect(successResponse, isNot(isA<Failure>()));
          expect(failureResponse, isNot(isA<Success>()));

        });
  });
}
