
This is an MapDescriptor package that allows users to convert TimeStamp values to strings and vice versa in a given Map of key-value pairs. This package is especially useful for users who receive data in Map form from Firestore and need to convert the ISO 8601 string values for their application needs. The package provides four methods - convertTimeStampToStr and convertStrToTimeStamp - that handle the conversion of TimeStamp values to strings and vice versa respectively. -containsTimeStamp and containsISO8601String - that check if a map contains timestamp or string format of timestamp respectively.

### Features
This package can convert Timestamp objects to ISO 8601 string in a given Map. This package can also convert ISO 8601 strings to Timestamp objects in a given Map.
The package can handle nested Maps containing Timestamp objects. This package is designed to work with data retrieved from Firestore, where Timestamp objects are commonly used to store date and time information. Overall, this package provides a simple way to handle Timestamp objects in Dart and Firestore, making it easier for developers to work with date and time information in their apps.

### Getting started

Prerequisites for using this package are: A Flutter project created using Flutter SDK. The cloud_firestore package added as a dependency in the project.
A basic understanding of working with maps and Firestore in Flutter. To start using the package, users can simply import the MapDescriptor class and create an instance of it. They can then use the convertTimeStampToStr method to convert any  Timestamp values in their map to strings, and the convertStrToTimeStamp method to convert any strings back to TimeStamp values. It is recommended that users read the documentation and examples provided in the package to understand how to use it effectively.

### Usage :

# 1-Convert timestamps in a Firestore document to String form of date (ISO 8601 strings):
```dart
    import 'package:mapdescriptor/mapdescriptor.dart';
     
   main() async {
      final doc =  await FirebaseFirestore.instance.collection('my_collection').doc('my_doc').get();
      Map myMap =  doc.data();// equal :{'name': 'John Doe','age': 30,'birthday': Timestamp(seconds=1560523991, nanoseconds=286000000),};
      final convertedMap = MapDescriptor().convertStrToTimeStamp(myMap);
      print(convertedMap['birthday']); // should print 1990-12-12T05:14:15.541Z
    }
```    
# 2 Convert all timestamps in a nested JSON object to ISO 8601 strings:
```dart
  import 'package:mapdescriptor/mapdescriptor.dart';

void main() {
  final myMap = {
    'name': 'Sami Youssuf',
    'age': 45,
    'timestamp': Timestamp(1560523991, 286000000),
    'activities': {
      'activity1': {
        'type': 'sport',
        'start': Timestamp(1560523991, 286000000),
      },
      'activity2': {
        'type': 'Sing',
        'start': Timestamp(1560523991, 286000000),
      }
    }
  };

  final convertedMap = MapDescriptor().convertTimeStampToStr(myMap);
  print(convertedMap['timestamp']); // should print an ISO 8601 string of this date ex :1990-12-12T05:14:15.541Z
  print(convertedMap['activities']['activity1']['start']); // should print an ISO 8601 string of this date ex :1990-12-12T05:14:15.541Z
  print(convertedMap['activities']['activity2']['start']); // should print an ISO 8601 string of this date ex :1990-12-12T05:14:15.541Z
}
```
# 3 Convert all ISO 8601 strings in a nested JSON object to TimeStamp :
```dart
  import 'package:mapdescriptor/mapdescriptor.dart';

void main() {
  final myMap = {
    'name': 'Andrew Tate',
    'age': 30,
    'birthday': "1990-12-12T05:14:15.541Z",
    'activities': {
      'activity1': {
        'type': 'Boxing',
        'start': "1999-07-04T05:14:15.541Z"),
      },
      'activity2': {
        'type': 'Netflix',
        'start': "2019-01-06T04:15:15.746Z",
      }
    }
  };

  final convertedMap = MapDescriptor().convertStrToTimeStamp(myMap);
  print(convertedMap['birthday']); // should print Timestamp(seconds=1560523991, nanoseconds=286000000)
  print(convertedMap['activities']['activity1']['start']); // should print Timestamp(seconds=1560523991, nanoseconds=286000000)
  print(convertedMap['activities']['activity2']['start']); // should print Timestamp(seconds=1560523991, nanoseconds=286000000)
}
```
# 4-Check if there is a TimeStamp Value inside a Map:
```dart
    import 'package:mapdescriptor/mapdescriptor.dart';
    
    
   main() async {
     final map1 = {
    'name': 'Khalid Ibn Walid',
    'age': 70,
    'birthday': Timestamp(1560523991, 286000000),
    };
    print(MapDescriptor().containsTimeStamp(map1)); //output True
     final map2 = {
    'name': 'Andrew Tate',
    'age': 30,
    };
    
     print(MapDescriptor().containsTimeStamp(map2)); //output false
}
``` 

# 5 check if a map contains ISO 8601 String (the string form of TimeStamp):
```dart
    import 'package:mapdescriptor/mapdescriptor.dart';
    ...
Map<String, dynamic> myMap = {
        'name': 'Hicham Hatri',
        'age': 32,
        'bithday': "1990-12-12T12:14:40.412Z",
        "activities": {
          "sport": {
            "type": "Boxing",
            "start": "2001-11-06T12:14:40.412Z",
          },
        }
      };
      Map<String, dynamic> myMap2 = {
        'name': 'Ayoub Arabi',
        'age': 30,
        'bithday': Timestamp(12115454, 121254),
        "activities": {
          "sport": {
            "type": "Soccer",
            "start": Timestamp(12115454, 121254),
          },
        }
      };

      bool contains = mapdescriptor.containsISO8601Str(myMap);//output true
      bool notcontains = mapdescriptor.containsISO8601Str(myMap2);// output false

```
# 6 Compare two nested Maps that contain TimeStamp Values


  In Firestore, timestamps are stored as Timestamp objects, which are not directly comparable to other data types. 
  When comparing two maps that contain Timestamp objects, 
  The equals() of DeepCollectionEquality class from collection.dart package  method may return false even if the maps have the same data, 
  because the Timestamp objects are not considered equal.
  That's why isEqual() method of the MapDescriptor package comes as a solution. 
```dart
  final map1 = {
    'name': 'John',
    'age': 30,
    'timestamp': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
    'address': {
      'street': '123 Main St',
      'city': 'Anytown',
      'state': 'CA',
    },
  };

  final map2 = {
    'name': 'John',
    'age': 30,
    'timestamp': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
    'address': {
      'street': '123 Main St',
      'city': 'Anytown',
      'state': 'CA',
    },
  };

  final map3 = {
    'name': 'Jane',
    'age': 25,
    'timestamp': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
    'address': {
      'street': '456 Oak St',
      'city': 'Sometown',
      'state': 'NY',
    },
  };

  print(isEqual(map1, map2)); // true
  print(isEqual(map1, map3)); // false
```
# Convert all TimeStamp Values inside nested maps to DateTime format :
```dart
final myMap = {
  'name': 'John Doe',
  'age': 30,
  'timestamp': Timestamp(seconds=1560523991, nanoseconds=286000000),
  'activities': {
    'activity1': {
      'type': 'sport',
      'timestamp': Timestamp(seconds=1560523991, nanoseconds=286000000),
    },
    'activity2': {
      'type': 'Netflix',
      'timestamp': Timestamp(seconds=1560523991, nanoseconds=286000000),
    }
  }
};

final newMap = convertTimeStampToDateTime(map);
print(newMap) //output a map with all timestamp values converted to DateTime 
```




# Behind the scene this method convert any existing Timestamp value inside a map to ISO8601 String before comparing .

### Additional information

To find more information about the package, users can visit the package's GitHub repository at :
# https://github.com/KBM90/mapdescriptor.
The repository contains a README file with information on how to use the package, as well as the package's API reference. Users can contribute to the package by submitting pull requests through GitHub. The package authors welcome contributions, but ask that contributors follow the guidelines outlined in the CONTRIBUTING file in the repository. To file issues with the package, users can submit a GitHub issue in the repository. The package authors will do their best to respond to issues in a timely manner and provide assistance where possible. Users can expect a friendly and responsive interaction from the package authors. The authors are dedicated to maintaining and improving the package, and are open to feedback and suggestions from users.

### Libraries

# mapdescriptor

Support for doing something awesome.
