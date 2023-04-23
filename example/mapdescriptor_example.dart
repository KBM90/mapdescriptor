/*
In this example, we create a sample Firestore document with a Timestamp value and then use the MapDescriptor package to convert the Timestamp value to a String. We then print the converted data to the console.

Next, we use the convertStrToTimeStamp method to convert the String value back to a Timestamp. We pass in the convertedData map and specify the key where the Timestamp is located (timeStampsKeys: [['timestamp']]). We then print the converted back data to the console.
*/
import 'package:mapdescriptor/src/mapdescriptor_base.dart';

void main() {
  // Create a sample Firestore document with a Timestamp value
  Map<String, dynamic> firestoreData = {
    'name': 'John Doe',
    'age': 30,
    'timestamp': Timestamp.fromDate(DateTime.now()),
  };

  // Convert the Timestamp value to a String
  MapDescriptor mapDescriptor = MapDescriptor();
  Map<String, dynamic> convertedData =
      mapDescriptor.convertTimeStampToStr(firestoreData);

  // Print the converted data
  print(
      convertedData); // Output: {name: John Doe, age: 30, timestamp: 2022-11-22T09:28:56.654196}

  // Convert the String value back to a Timestamp
  Map<String, dynamic> convertedBackData =
      mapDescriptor.convertStrToTimeStamp(convertedData);

  // Print the converted back data
  print(convertedBackData);

  // Output: {name: John Doe, age: 30, timestamp: Timestamp(seconds=1669192136, nanoseconds=654196000)}

  //# 4-Check if there is a TimeStamp Value inside a Map:

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

  bool contains = MapDescriptor().containsISO8601Str(myMap);
  print(contains); //output true
  bool notcontains = MapDescriptor().containsISO8601Str(myMap2);
  print(notcontains); // output false
}
