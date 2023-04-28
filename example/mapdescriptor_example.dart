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
  print("Converted to ISO String");
  print(
      convertedData); // Output: {name: John Doe, age: 30, timestamp: 2022-11-22T09:28:56.654196}

  // Convert the String value back to a Timestamp
  Map<String, dynamic> convertedBackData =
      mapDescriptor.convertStrToTimeStamp(convertedData);

  // Print the converted back data
  print("Converted to TimeStamp");
  print(convertedBackData);

  //Get a deep copy of map
  Map<String, dynamic> deepCopy = mapDescriptor.deepCopy(firestoreData);
  deepCopy["name"] = "Larsson";

  print("original map");
  print(firestoreData);
  print("deep copy");
  print(deepCopy);

  // Output: {name: John Doe, age: 30, timestamp: Timestamp(seconds=1669192136, nanoseconds=654196000)}

  //# 4-Check if there is a TimeStamp Value inside a Map:

  Map<String, dynamic> myMap = {
    'central_name': 'madagh',
    'pumps': {
      'pump1': {
        'covered_sensors': ['sensor1', 'sensor2'],
        'isOn': true,
        'worked_hours': 12.2,
      },
    },
    'soil_moisture_sensors': {
      'sensor2': {
        'plant': 'apple',
        'moisture_level': 10.222222,
        'in_service_date': Timestamp(1670383563, 721000000),
      },
      'sensor1': {
        'plant': 'grapes',
        'moisture_level': 10.222,
        'in_service_date': Timestamp(1677641013, 685000000),
      },
    },
    'location': {
      'latitude': 35.010123454,
      'longitude': -2.3427629190125705,
    },
    'updated_at': Timestamp(1678557939, 503000000),
  };

  print(MapDescriptor().containsTimeStamp(myMap)); //output True
  print(MapDescriptor().containsISO8601Str(myMap)); //output false
}
