
This is an MapDescriptor package that allows users to convert DateTime values to strings and vice versa in a given Map of key-value pairs. It depends on the cloud_firestore package and is especially useful for users who receive data in Map form from Firestore and need to convert the DateTime values for their application needs. The package provides two methods - convertTimeStampToStr and convertStrToTimeStamp - that handle the conversion of DateTime values to strings and vice versa respectively, and a third helper method processDateTimeValues that recursively searches for DateTime values in nested Maps..

### Features
This package can convert Timestamp objects to ISO 8601 strings in a given Map. This package can also convert ISO 8601 strings to Timestamp objects in a given Map, provided that the keys of the Timestamp objects are specified. The package can handle nested Maps containing Timestamp objects. This package is designed to work with data retrieved from Firestore, where Timestamp objects are commonly used to store date and time information. Overall, this package provides a simple way to handle Timestamp objects in Dart and Firestore, making it easier for developers to work with date and time information in their apps.

### Getting started
TODO: Prerequisites for using this package are: A Flutter project created using Flutter SDK. The cloud_firestore package added as a dependency in the project. This can be done by adding cloud_firestore: ^2.5.4 to the dependencies section of the pubspec.yaml file and running flutter pub get. A basic understanding of working with maps and Firestore in Flutter. To start using the package, users can simply import the MapDescriptor class and create an instance of it. They can then use the convertTimeStampToStr method to convert any DateTime or Timestamp values in their map to strings, and the convertStrToTimeStamp method to convert any strings back to DateTime values. It is recommended that users read the documentation and examples provided in the package to understand how to use it effectively.

### Usage
1-Convert timestamps in a Firestore document to DateTime objects:
```dart
    import 'package:mapdescriptor/mapdescriptor.dart';
    import 'package:cloud_firestore/cloud_firestore.dart';
    
   main() async {
      final doc =  await FirebaseFirestore.instance.collection('my_collection').doc('my_doc').get();
      Map myMap =  doc.data();
      final convertedMap = MapDescriptor().convertStrToTimeStamp(myMap, haveTimeStamps: true, timeStampsKeys: [['birthday']]);
      print(convertedMap['birthday']); should print a DateTime object
    }
```    
# 2 Convert all timestamps in a nested JSON object to ISO 8601 strings:
```dart
  import 'package:mapdescriptor/mapdescriptor.dart';

void main() {
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

  final convertedMap = MapDescriptor().convertTimeStampToStr(myMap);
  print(convertedMap['timestamp']); // should print an ISO 8601 string
  print(convertedMap['activities']['activity1']['timestamp']); // should print an ISO 8601 string
  print(convertedMap['activities']['activity2']['timestamp']); // should print an ISO 8601 string
}
```
### Additional information

To find more information about the package, users can visit the package's GitHub repository at :
# https://github.com/KBM90/mapdescriptor.
The repository contains a README file with information on how to use the package, as well as the package's API reference. Users can contribute to the package by submitting pull requests through GitHub. The package authors welcome contributions, but ask that contributors follow the guidelines outlined in the CONTRIBUTING file in the repository. To file issues with the package, users can submit a GitHub issue in the repository. The package authors will do their best to respond to issues in a timely manner and provide assistance where possible. Users can expect a friendly and responsive interaction from the package authors. The authors are dedicated to maintaining and improving the package, and are open to feedback and suggestions from users.

### Libraries

# mapdescriptor

Support for doing something awesome.
