class MapDescriptor {
  Map<String, dynamic> convertTimeStampToStr(Map<String, dynamic> myMap) =>
      _processDateTimeValues(myMap);

  // convert String form of timestamp to timestamp
  Map<String, dynamic> convertStrToTimeStamp(
    Map<String, dynamic> myMap,
  ) {
    Map<String, dynamic> newMap = {...myMap};
    RegExp timestampRegex =
        RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}');

    myMap.forEach((key, value) {
      if (value is String && timestampRegex.hasMatch(value)) {
        newMap[key] = Timestamp.fromDate(DateTime.parse(value));
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        newMap[key] = convertStrToTimeStamp(value);
      }
    });
    return newMap;
  }

  Map<String, dynamic> _processDateTimeValues(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = {...map};
    map.forEach((key, value) {
      if (value is Timestamp) {
        String timestampString = value.toDate().toIso8601String();
        newMap[key] = timestampString;
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        newMap[key] = _processDateTimeValues(value);
      }
    });
    return newMap;
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
