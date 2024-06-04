import 'package:collection/collection.dart';

class MapDescriptor {
  final List<String> _timeStampKeys = [];
  List<String> get timeStampKeys => _timeStampKeys;
  final List<String> _iso8601Keys = [];
  List<String> get iso8601Keys => _iso8601Keys;

  /// Takes a map which may contains values of type TimeStamp and convert theses values
  /// to string form of date (YYYY-MM-ddTHH:MM:SS.NNNN(Time Zone))
  /// @param : map => Map<String,dynamic>
  /// @return : Map<String,dynamic>

  Map<String, dynamic> convertTimeStampToStr(Map<String, dynamic> map) {
    if (map.isEmpty) {
      throw ArgumentError('You provided an empty map: $map');
    }
    return _converTimeStampValuesToSTring(map);
  }

  /// Takes a map which may contains string forms values of TimeStamp and convert theses values
  /// to TimeStamp form of date TimeStamp(seconds:int,nanoseconds:int)
  /// @param : map => Map<String,dynamic>
  /// @return : Map<String,dynamic>
  Map<String, dynamic> convertStrToTimeStamp(
    Map<String, dynamic> map,
  ) {
    Map<String, dynamic> newMap = {...map};
    RegExp isoStringRegex =
        RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}');
    if (map.isEmpty) {
      throw ArgumentError('You provided an empty map: $map');
    }
    map.forEach((key, value) {
      if (value is String && isoStringRegex.hasMatch(value)) {
        newMap[key] = Timestamp.fromDate(DateTime.parse(value));
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        newMap[key] = convertStrToTimeStamp(value);
      }
    });
    return newMap;
  }

  //Converts all timestamp values inside nested maps to DateTime format
  convertTimeStampToDateTime(Map<String, dynamic> map) =>
      _convertTimeStampValuesToDates(map);

  bool containsTimeStamp(Map<String, dynamic> map) {
    if (map.isEmpty) {
      throw ArgumentError('You provided an empty map: $map');
    }
    map.forEach((key, value) {
      if (value is! int &&
          value is! double &&
          value is! String &&
          value is! bool &&
          value is! List &&
          value is! Map) {
        _timeStampKeys.add(key);
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        containsTimeStamp(value);
      }
    });
    return timeStampKeys.isNotEmpty;
  }

  bool containsISO8601Str(Map<String, dynamic> map) {
    RegExp isoStringRegex =
        RegExp(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}');
    if (map.isEmpty) {
      throw ArgumentError('You provided an empty map: $map');
    }
    map.forEach((key, value) {
      if (value is String && isoStringRegex.hasMatch(value)) {
        _iso8601Keys.add(key);
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        containsISO8601Str(value);
      }
    });
    return _iso8601Keys.isNotEmpty;
  }

  Map<String, dynamic> deepCopy(Map<String, dynamic> original) {
    Map<String, dynamic> copy = {};
    original.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        copy[key] = deepCopy(value);
      } else {
        copy[key] = value;
      }
    });
    return copy;
  }

  ///Compare two Maps Containing TimeStamp Values
  //In Firestore, timestamps are stored as Timestamp objects, which are not directly comparable to other data types.
  //When comparing two maps that contain Timestamp objects,
  //the equals() method may return false even if the maps have the same data,
  //because the Timestamp objects are not considered equal.

  bool isEqual(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    return DeepCollectionEquality().equals(
        MapDescriptor().convertTimeStampToStr(map1),
        MapDescriptor().convertTimeStampToStr(map2));
  }

  Map<String, dynamic> _convertTimeStampValuesToDates(
      Map<String, dynamic> map) {
    Map<String, dynamic> newMap = {...map};
    map.forEach((key, value) {
      if (value is! int &&
          value is! double &&
          value is! String &&
          value is! bool &&
          value is! List &&
          value is! Map && value != null) {
        DateTime timestampString = value.toDate();
        newMap[key] = timestampString;
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        newMap[key] = _convertTimeStampValuesToDates(value);
      }
    });
    return newMap;
  }

  Map<String, dynamic> _converTimeStampValuesToSTring(
      Map<String, dynamic> map) {
    Map<String, dynamic> newMap = {...map};
    map.forEach((key, value) {
      if (value is! int &&
          value is! double &&
          value is! String &&
          value is! bool &&
          value is! List &&
          value is! Map && value != null) {
        String timestampString = value.toDate().toIso8601String();
        newMap[key] = timestampString;
      } else if (value is Map<String, dynamic>) {
        // recursively search for DateTime values in nested maps
        newMap[key] = _converTimeStampValuesToSTring(value);
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
