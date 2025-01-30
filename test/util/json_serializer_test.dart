import 'package:flutter_test/flutter_test.dart';
import 'package:tikka/util/json_serializer.dart';

class TestJsonSerializer extends JsonSerializer {}

void main() {
  late TestJsonSerializer serializer;

  setUp(() {
    serializer = TestJsonSerializer();
  });

  group('JsonSerializer', () {
    test('asDouble converts num to double', () {
      expect(serializer.asDouble(1), 1.0);
      expect(serializer.asDouble(1.5), 1.5);
    });

    test('asDouble returns 0.0 for non-num values', () {
      expect(serializer.asDouble('string'), 0.0);
      expect(serializer.asDouble(null), 0.0);
      expect(serializer.asDouble([]), 0.0);
    });

    test('asInt converts num to int', () {
      expect(serializer.asInt(1), 1);
      expect(serializer.asInt(1.5), 1);
    });

    test('asInt returns 0 for non-num values', () {
      expect(serializer.asInt('string'), 0);
      expect(serializer.asInt(null), 0);
      expect(serializer.asInt([]), 0);
    });


    test('asString converts values to String', () {
      expect(serializer.asString(1), '1');
      expect(serializer.asString('string'), 'string');
      expect(serializer.asString(null), '');
    });



    test('asStringList converts list to List<String>', () {
      expect(serializer.asStringList([1, 'string', null]), ['1', 'string', '']);
      expect(serializer.asStringList(null), isEmpty);

    });

    test('asStringList handles null elements in list', () {
      expect(serializer.asStringList([1, null, 'string']), ['1', '', 'string']);
    });
  });
}
