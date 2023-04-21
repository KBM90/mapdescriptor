class MapDescriptor {
  Map<String, dynamic> convertTimeStampToStr(Map<String, dynamic> myMap) =>
      processDateTimeValues(myMap);

  convertStrToTimeStamp(Map<String, dynamic> myMap,
      {bool haveTimeStamps = false,
      List<List<String>> timeStampsKeys = const []}) {
    if (haveTimeStamps) {
      for (List<String> tKey in timeStampsKeys) {
        switch (tKey.length) {
          case 1:
            if (myMap[tKey[0]] != null) {
              String timestampString =
                  myMap[tKey[0]]; //get the timestamp stored as String
              myMap[tKey[0]] = DateTime.parse(timestampString);
            }
            break;
          case 2:
            if (myMap[tKey[0]][tKey[1]] != null) {
              String timestampString =
                  myMap[tKey[0]][tKey[1]]; //get the timestamp stored as String
              myMap[tKey[0]][tKey[1]] = DateTime.parse(timestampString);
            }
            break;
          case 3:
            if (myMap[tKey[0]][tKey[1]][tKey[2]] != null) {
              String timestampString = myMap[tKey[0]][tKey[1]]
                  [tKey[2]]; //get the timestamp stored as String
              myMap[tKey[0]][tKey[1]][tKey[2]] =
                  DateTime.parse(timestampString);
            }
            break;
        }
      }
    }
    return myMap;
  }

  Map<String, dynamic> processDateTimeValues(Map<String, dynamic> map) {
    map.forEach((key, value) {
      if (value is Timestamp) {
        String timestampString = value.toDate().toIso8601String();
        map[key] = timestampString;
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        processDateTimeValues(value);
      }
    });
    return map;
  }
}

class Timestamp {
  final int seconds;
  final int nanoseconds;

  Timestamp(this.seconds, this.nanoseconds) {
    _validateRange(seconds, nanoseconds);
  }

  factory Timestamp.fromMillisecondsSinceEpoch(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    final int nanoseconds = (milliseconds - seconds * 1000) * 1000000;
    return Timestamp(seconds, nanoseconds);
  }

  factory Timestamp.fromMicrosecondsSinceEpoch(int microseconds) {
    final int seconds = microseconds ~/ 1000000;
    final int nanoseconds = (microseconds - seconds * 1000000) * 1000;
    return Timestamp(seconds, nanoseconds);
  }

  factory Timestamp.fromDate(DateTime date) {
    return Timestamp.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
  }

  factory Timestamp.now() {
    return Timestamp.fromMicrosecondsSinceEpoch(
      DateTime.now().microsecondsSinceEpoch,
    );
  }

  DateTime toDate() {
    return DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  }

  int get millisecondsSinceEpoch => seconds * 1000 + nanoseconds ~/ 1000000;

  int get microsecondsSinceEpoch => seconds * 1000000 + nanoseconds ~/ 1000;

  void _validateRange(int seconds, int nanoseconds) {
    if (nanoseconds < 0 || nanoseconds >= 1000000000) {
      throw ArgumentError('Timestamp nanoseconds out of range: $nanoseconds');
    }
    if (seconds < -62135596800 || seconds > 253402300799) {
      throw ArgumentError('Timestamp seconds out of range: $seconds');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Timestamp &&
      other.seconds == seconds &&
      other.nanoseconds == nanoseconds;

  @override
  int get hashCode => Object.hash(seconds, nanoseconds);

  @override
  String toString() {
    return 'Timestamp(seconds=$seconds, nanoseconds=$nanoseconds)';
  }
}
