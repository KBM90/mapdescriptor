import 'package:mapdescriptor/mapdescriptor.dart';
import 'package:test/test.dart';

void main() {
  MapDescriptor mapdescriptor = MapDescriptor();
  group('MapDescriptor Test', () {
    test('Process DateTime values in a map', () {
      Map<String, dynamic> map = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': Timestamp(1560523991, 286000000),
        'activities': {
          'activity1': {
            'type': 'sport',
            'timestamp': Timestamp(1560523991, 286000000),
          },
          'activity2': {
            'type': 'Netflix',
            'timestamp': Timestamp(1560523991, 286000000),
          },
        },
      };

      Map<String, dynamic> processedMap =
          mapdescriptor.processDateTimeValues(map);

      expect(processedMap, same(map));
      expect(processedMap['timestamp'], isA<String>());
      expect(
          processedMap['activities']['activity1']['timestamp'], isA<String>());
      expect(
          processedMap['activities']['activity2']['timestamp'], isA<String>());
    });

    /*   test('Convert timestamp to string', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': DateTime.now(),
      };

      Map<String, dynamic> newMap = mapdescriptor.convertTimeStampToStr(myMap);

      expect(newMap['name'], equals('John Doe'));
      expect(newMap['age'], equals(30));
      expect(newMap['timestamp'], isA<String>());
    });
*/
    test('Convert string to timestamp', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': DateTime.now().toIso8601String(),
      };

      List<List<String>> timeStampsKeys = [
        ['timestamp']
      ];

      Map<String, dynamic> newMap = mapdescriptor.convertStrToTimeStamp(myMap,
          haveTimeStamps: true, timeStampsKeys: timeStampsKeys);

      expect(newMap['name'], equals('John Doe'));
      expect(newMap['age'], equals(30));
      expect(newMap['timestamp'], isA<DateTime>());
    });
  });
}
