import 'package:mapdescriptor/mapdescriptor.dart';
import 'package:test/test.dart';

void main() {
  MapDescriptor mapdescriptor = MapDescriptor();
  group('MapDescriptor Test', () {
    test('Convert timestamp to string', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': Timestamp(12115454, 121254),
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": Timestamp(12115454, 121254),
          },
        }
      };

      Map<String, dynamic> newMap = mapdescriptor.convertTimeStampToStr(myMap);

      expect(newMap['name'], equals('John Doe'));
      expect(newMap['age'], equals(30));
      expect(newMap['timestamp'], isA<String>());
      expect(newMap['activities']["sport"]["start"], isA<String>());
    });

    test('Convert timestamp to DateTime', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': Timestamp(12115454, 121254),
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": Timestamp(12115454, 121254),
          },
        }
      };

      Map<String, dynamic> newMap =
          mapdescriptor.convertTimeStampToDateTime(myMap);

      expect(newMap['timestamp'], isA<DateTime>());
      expect(newMap['activities']["sport"]["start"], isA<DateTime>());
    });
    test('Convert string to timestamp', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': "2012-12-12T12:14:40.412",
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": "2012-12-12T12:14:40.412",
          },
        }
      };

      Map<String, dynamic> newMap = mapdescriptor.convertStrToTimeStamp(myMap);

      expect(newMap['name'], equals('John Doe'));
      expect(newMap['age'], equals(30));
      expect(newMap['timestamp'], isA<Timestamp>());
      expect(newMap['activities']["sport"]["start"], isA<Timestamp>());
    });
    test('Check if contains TimeStamp', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': "2012-12-12T12:14:40.412",
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": "2012-12-12T12:14:40.412",
          },
        }
      };
      Map<String, dynamic> myMap2 = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': Timestamp(12115454, 121254),
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": Timestamp(12115454, 121254),
          },
        }
      };

      bool contains = mapdescriptor.containsTimeStamp(myMap2);
      bool notcontains = mapdescriptor.containsTimeStamp(myMap);

      expect(contains, true);
      expect(notcontains, false);
    });
    test('Check if contains ISO 8601 String', () {
      Map<String, dynamic> myMap = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': "2012-12-12T12:14:40.412Z",
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": "2012-12-12T12:14:40.412Z",
          },
        }
      };
      Map<String, dynamic> myMap2 = {
        'name': 'John Doe',
        'age': 30,
        'timestamp': Timestamp(12115454, 121254),
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": Timestamp(12115454, 121254),
          },
        }
      };

      bool contains = mapdescriptor.containsISO8601Str(myMap);
      bool notcontains = mapdescriptor.containsISO8601Str(myMap2);

      expect(contains, true);
      expect(notcontains, false);
    });
  });
}
