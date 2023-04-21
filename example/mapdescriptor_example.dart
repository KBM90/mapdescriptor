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
  Map<String, dynamic> convertedBackData = mapDescriptor.convertStrToTimeStamp(
      convertedData,
      haveTimeStamps: true,
      timeStampsKeys: [
        ['timestamp']
      ]);

  // Print the converted back data
  print(convertedBackData);

  // Output: {name: John Doe, age: 30, timestamp: Timestamp(seconds=1669192136, nanoseconds=654196000)}
}
