# MapDescriptor

A powerful Dart package for seamless manipulation of nested maps containing timestamp data. MapDescriptor simplifies the conversion between `Timestamp` objects, ISO 8601 strings, and `DateTime` objects, making it an essential tool for Flutter developers working with Firestore and other timestamp-based data sources.

[![pub package](https://img.shields.io/pub/v/mapdescriptor.svg)](https://pub.dev/packages/mapdescriptor)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## 🎯 Overview

[![Watch Demo](https://img.youtube.com/vi/KPi-bnmLl_w/maxresdefault.jpg)](https://youtu.be/ulOihWI3Jbs)

MapDescriptor provides a comprehensive solution for handling timestamp conversions in nested map structures. Whether you're working with Firestore documents, API responses, or any data structure containing timestamps, this package offers intuitive methods to convert, detect, compare, and manipulate timestamp data at any nesting level.

## ✨ Key Features

- **🔄 Bidirectional Timestamp Conversion**: Convert between `Timestamp` objects and ISO 8601 strings seamlessly
- **📅 DateTime Support**: Transform timestamps to native Dart `DateTime` objects
- **🔍 Smart Detection**: Automatically detect timestamp formats (Timestamp objects or ISO 8601 strings) in nested maps
- **🌳 Deep Nesting Support**: Handle timestamps at any depth in nested map structures
- **⚖️ Deep Equality Comparison**: Compare maps containing timestamps accurately
- **📋 Deep Copy**: Create independent copies of maps without reference issues
- **🔥 Firestore Optimized**: Designed specifically for Firestore data structures
- **🎯 Type-Safe**: Full type safety with Dart's strong typing system

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  mapdescriptor: ^1.0.9
```

Then run:

```bash
dart pub get
```

Or for Flutter projects:

```bash
flutter pub get
```

## 🚀 Quick Start

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

void main() {
  final mapDescriptor = MapDescriptor();
  
  // Create a map with timestamps
  final data = {
    'name': 'John Doe',
    'createdAt': Timestamp.now(),
  };
  
  // Convert to ISO 8601 strings
  final stringData = mapDescriptor.convertTimeStampToStr(data);
  print(stringData['createdAt']); // "2024-01-09T18:30:00.000Z"
  
  // Convert back to timestamps
  final timestampData = mapDescriptor.convertStrToTimeStamp(stringData);
  print(timestampData['createdAt']); // Timestamp(seconds=..., nanoseconds=...)
}
```

## 📚 Core API Reference

### MapDescriptor Class

#### `convertTimeStampToStr(Map<String, dynamic> map)`
Converts all `Timestamp` objects in a map (including nested maps) to ISO 8601 string format.

**Parameters:**
- `map`: The map containing timestamp values

**Returns:** A new map with timestamps converted to ISO 8601 strings

**Example:**
```dart
final data = {
  'user': 'Alice',
  'timestamp': Timestamp(1560523991, 286000000),
  'metadata': {
    'lastLogin': Timestamp(1560523991, 286000000),
  }
};

final converted = MapDescriptor().convertTimeStampToStr(data);
// All Timestamp objects are now ISO 8601 strings
```

---

#### `convertStrToTimeStamp(Map<String, dynamic> map)`
Converts all ISO 8601 strings in a map (including nested maps) to `Timestamp` objects.

**Parameters:**
- `map`: The map containing ISO 8601 string values

**Returns:** A new map with ISO 8601 strings converted to Timestamp objects

**Example:**
```dart
final data = {
  'event': 'Conference',
  'startDate': '2024-01-15T09:00:00.000Z',
  'sessions': {
    'keynote': {
      'time': '2024-01-15T10:00:00.000Z',
    }
  }
};

final converted = MapDescriptor().convertStrToTimeStamp(data);
// All ISO 8601 strings are now Timestamp objects
```

---

#### `convertTimeStampToDateTime(Map<String, dynamic> map)`
Converts all `Timestamp` objects in a map to Dart `DateTime` objects.

**Parameters:**
- `map`: The map containing timestamp values

**Returns:** A new map with timestamps converted to DateTime objects

**Example:**
```dart
final data = {
  'appointment': 'Doctor Visit',
  'scheduledAt': Timestamp.now(),
};

final converted = MapDescriptor().convertTimeStampToDateTime(data);
print(converted['scheduledAt'].runtimeType); // DateTime
```

---

#### `containsTimeStamp(Map<String, dynamic> map)`
Checks if a map contains any `Timestamp` objects at any nesting level.

**Parameters:**
- `map`: The map to check

**Returns:** `true` if the map contains at least one Timestamp object, `false` otherwise

**Properties:**
- Access `timeStampKeys` getter to retrieve the list of keys containing timestamps

**Example:**
```dart
final data1 = {'name': 'Bob', 'age': 30};
final data2 = {'name': 'Alice', 'joinedAt': Timestamp.now()};

print(MapDescriptor().containsTimeStamp(data1)); // false
print(MapDescriptor().containsTimeStamp(data2)); // true
```

---

#### `containsISO8601Str(Map<String, dynamic> map)`
Checks if a map contains any ISO 8601 formatted strings at any nesting level.

**Parameters:**
- `map`: The map to check

**Returns:** `true` if the map contains at least one ISO 8601 string, `false` otherwise

**Properties:**
- Access `iso8601Keys` getter to retrieve the list of keys containing ISO 8601 strings

**Example:**
```dart
final data1 = {'name': 'Charlie', 'age': 25};
final data2 = {'name': 'Diana', 'registeredAt': '2024-01-09T12:00:00.000Z'};

print(MapDescriptor().containsISO8601Str(data1)); // false
print(MapDescriptor().containsISO8601Str(data2)); // true
```

---

#### `isEqual(Map<String, dynamic> map1, Map<String, dynamic> map2)`
Performs deep equality comparison between two maps, properly handling `Timestamp` objects.

**Why is this needed?** In Firestore, timestamps are stored as `Timestamp` objects. Standard equality checks may fail even when maps contain identical data because `Timestamp` objects aren't directly comparable. This method converts timestamps to strings before comparison.

**Parameters:**
- `map1`: First map to compare
- `map2`: Second map to compare

**Returns:** `true` if maps are deeply equal, `false` otherwise

**Example:**
```dart
final map1 = {
  'user': 'Eve',
  'createdAt': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
  'profile': {'city': 'New York'}
};

final map2 = {
  'user': 'Eve',
  'createdAt': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
  'profile': {'city': 'New York'}
};

print(MapDescriptor().isEqual(map1, map2)); // true
```

---

#### `deepCopy(Map<String, dynamic> original)`
Creates a deep copy of a map, ensuring nested maps are also copied (not referenced).

**Parameters:**
- `original`: The map to copy

**Returns:** A new independent copy of the map

**Example:**
```dart
final original = {
  'name': 'Frank',
  'settings': {'theme': 'dark', 'notifications': true}
};

final copy = MapDescriptor().deepCopy(original);
copy['settings']['theme'] = 'light';

print(original['settings']['theme']); // 'dark' (unchanged)
print(copy['settings']['theme']); // 'light'
```

---

### Timestamp Class

A custom implementation of Firestore's Timestamp class for standalone use.

#### Constructors

```dart
// Create from seconds and nanoseconds
Timestamp(int seconds, int nanoseconds)

// Create from milliseconds since epoch
Timestamp.fromMillisecondsSinceEpoch(int milliseconds)

// Create from microseconds since epoch
Timestamp.fromMicrosecondsSinceEpoch(int microseconds)

// Create from DateTime object
Timestamp.fromDate(DateTime date)

// Create with current time
Timestamp.now()
```

#### Methods & Properties

```dart
// Convert to DateTime
DateTime toDate()

// Get milliseconds since epoch
int get millisecondsSinceEpoch

// Get microseconds since epoch
int get microsecondsSinceEpoch

// String representation
String toString() // Returns "Timestamp(seconds=..., nanoseconds=...)"
```

## 🎯 Use Cases & Examples

### 1. Firestore Document Processing

**Scenario:** Fetching and processing Firestore documents with timestamps

```dart
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:mapdescriptor/mapdescriptor.dart';

Future<void> processFirestoreDocument() async {
  // Fetch document from Firestore
  final doc = await firestore.FirebaseFirestore.instance
      .collection('users')
      .doc('user123')
      .get();
  
  Map<String, dynamic> userData = doc.data()!;
  // userData might look like:
  // {
  //   'name': 'John Doe',
  //   'email': 'john@example.com',
  //   'createdAt': Timestamp(seconds=1560523991, nanoseconds=286000000),
  //   'lastLogin': Timestamp(seconds=1678557939, nanoseconds=503000000)
  // }
  
  // Convert timestamps to strings for JSON serialization or API responses
  final mapDescriptor = MapDescriptor();
  final jsonFriendlyData = mapDescriptor.convertTimeStampToStr(userData);
  
  print(jsonFriendlyData);
  // {
  //   'name': 'John Doe',
  //   'email': 'john@example.com',
  //   'createdAt': '2019-06-14T14:19:51.286Z',
  //   'lastLogin': '2023-03-11T18:32:19.503Z'
  // }
}
```

### 2. API Response Serialization

**Scenario:** Converting Firestore data to JSON for REST API responses

```dart
import 'dart:convert';
import 'package:mapdescriptor/mapdescriptor.dart';

class UserAPI {
  final MapDescriptor _mapDescriptor = MapDescriptor();
  
  Future<String> getUserProfile(String userId) async {
    // Fetch from Firestore
    final userData = await fetchUserFromFirestore(userId);
    
    // Convert timestamps to ISO 8601 strings
    final apiResponse = _mapDescriptor.convertTimeStampToStr(userData);
    
    // Now safe to convert to JSON
    return jsonEncode(apiResponse);
  }
  
  Future<Map<String, dynamic>> fetchUserFromFirestore(String userId) async {
    // Simulated Firestore data
    return {
      'id': userId,
      'name': 'Alice Johnson',
      'profile': {
        'bio': 'Software Developer',
        'joinedAt': Timestamp.fromDate(DateTime(2022, 1, 15)),
        'lastActive': Timestamp.now(),
      },
      'posts': [
        {
          'title': 'My First Post',
          'publishedAt': Timestamp.fromDate(DateTime(2022, 2, 1)),
        }
      ]
    };
  }
}
```

### 3. Data Migration & Import

**Scenario:** Importing data from JSON/CSV with ISO 8601 dates into Firestore

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

Future<void> importUserData(List<Map<String, dynamic>> jsonData) async {
  final mapDescriptor = MapDescriptor();
  
  for (var userData in jsonData) {
    // userData from JSON:
    // {
    //   'name': 'Bob Smith',
    //   'registeredAt': '2023-05-20T10:30:00.000Z',
    //   'subscription': {
    //     'startDate': '2023-05-20T10:30:00.000Z',
    //     'renewalDate': '2024-05-20T10:30:00.000Z'
    //   }
    // }
    
    // Convert ISO 8601 strings to Timestamp objects for Firestore
    final firestoreData = mapDescriptor.convertStrToTimeStamp(userData);
    
    // Now safe to upload to Firestore
    await uploadToFirestore(firestoreData);
  }
}

Future<void> uploadToFirestore(Map<String, dynamic> data) async {
  // Upload logic here
  print('Uploading: $data');
}
```

### 4. Complex Nested Data Structures

**Scenario:** E-commerce order with multiple nested timestamps

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

void processOrder() {
  final order = {
    'orderId': 'ORD-12345',
    'customer': {
      'name': 'Charlie Brown',
      'accountCreated': Timestamp.fromDate(DateTime(2020, 3, 15)),
    },
    'items': [
      {
        'product': 'Laptop',
        'addedToCart': Timestamp.fromDate(DateTime(2024, 1, 5, 14, 30)),
      },
      {
        'product': 'Mouse',
        'addedToCart': Timestamp.fromDate(DateTime(2024, 1, 5, 14, 35)),
      }
    ],
    'timeline': {
      'ordered': Timestamp.fromDate(DateTime(2024, 1, 5, 15, 0)),
      'shipped': Timestamp.fromDate(DateTime(2024, 1, 6, 10, 0)),
      'delivered': Timestamp.fromDate(DateTime(2024, 1, 8, 16, 30)),
    },
    'payment': {
      'method': 'Credit Card',
      'processedAt': Timestamp.fromDate(DateTime(2024, 1, 5, 15, 1)),
    }
  };
  
  final mapDescriptor = MapDescriptor();
  
  // Convert all timestamps to strings for logging/display
  final orderLog = mapDescriptor.convertTimeStampToStr(order);
  print('Order Timeline:');
  print('Ordered: ${orderLog['timeline']['ordered']}');
  print('Shipped: ${orderLog['timeline']['shipped']}');
  print('Delivered: ${orderLog['timeline']['delivered']}');
}
```

### 5. Data Validation & Detection

**Scenario:** Validating data format before processing

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

class DataValidator {
  final MapDescriptor _mapDescriptor = MapDescriptor();
  
  bool validateFirestoreData(Map<String, dynamic> data) {
    // Check if data contains Timestamp objects (expected from Firestore)
    if (_mapDescriptor.containsTimeStamp(data)) {
      print('✓ Valid Firestore data detected');
      print('Timestamp fields: ${_mapDescriptor.timeStampKeys}');
      return true;
    }
    
    print('✗ No Timestamp objects found');
    return false;
  }
  
  bool validateAPIData(Map<String, dynamic> data) {
    // Check if data contains ISO 8601 strings (expected from API)
    if (_mapDescriptor.containsISO8601Str(data)) {
      print('✓ Valid API data detected');
      print('Date fields: ${_mapDescriptor.iso8601Keys}');
      return true;
    }
    
    print('✗ No ISO 8601 date strings found');
    return false;
  }
  
  void processData(Map<String, dynamic> data) {
    if (validateFirestoreData(data)) {
      // Process as Firestore data
      final stringData = _mapDescriptor.convertTimeStampToStr(data);
      handleProcessedData(stringData);
    } else if (validateAPIData(data)) {
      // Process as API data
      final timestampData = _mapDescriptor.convertStrToTimeStamp(data);
      handleProcessedData(timestampData);
    } else {
      print('Unknown data format');
    }
  }
  
  void handleProcessedData(Map<String, dynamic> data) {
    print('Processing: $data');
  }
}
```

### 6. Caching & Comparison

**Scenario:** Detecting changes in cached Firestore documents

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

class CacheManager {
  final MapDescriptor _mapDescriptor = MapDescriptor();
  final Map<String, Map<String, dynamic>> _cache = {};
  
  Future<bool> hasDocumentChanged(String docId, Map<String, dynamic> newData) async {
    final cachedData = _cache[docId];
    
    if (cachedData == null) {
      // No cached version, store and return true
      _cache[docId] = _mapDescriptor.deepCopy(newData);
      return true;
    }
    
    // Compare using isEqual to handle Timestamp objects correctly
    final hasChanged = !_mapDescriptor.isEqual(cachedData, newData);
    
    if (hasChanged) {
      print('Document $docId has changed');
      _cache[docId] = _mapDescriptor.deepCopy(newData);
    } else {
      print('Document $docId unchanged');
    }
    
    return hasChanged;
  }
  
  void clearCache() {
    _cache.clear();
  }
}

// Usage
void main() async {
  final cacheManager = CacheManager();
  
  final doc1 = {
    'title': 'Article',
    'updatedAt': Timestamp.fromMillisecondsSinceEpoch(1650000000000),
  };
  
  await cacheManager.hasDocumentChanged('doc1', doc1); // true (first time)
  await cacheManager.hasDocumentChanged('doc1', doc1); // false (no change)
  
  final doc1Updated = {
    'title': 'Article Updated',
    'updatedAt': Timestamp.fromMillisecondsSinceEpoch(1650000001000),
  };
  
  await cacheManager.hasDocumentChanged('doc1', doc1Updated); // true (changed)
}
```

### 7. DateTime Conversion for UI Display

**Scenario:** Converting timestamps to DateTime for Flutter widgets

```dart
import 'package:flutter/material.dart';
import 'package:mapdescriptor/mapdescriptor.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> eventData;
  
  const EventCard({Key? key, required this.eventData}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final mapDescriptor = MapDescriptor();
    
    // Convert Timestamp to DateTime for formatting
    final dateTimeData = mapDescriptor.convertTimeStampToDateTime(eventData);
    
    final DateTime eventDate = dateTimeData['startDate'];
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(eventDate);
    
    return Card(
      child: ListTile(
        title: Text(eventData['title']),
        subtitle: Text('Starts: $formattedDate'),
        trailing: Icon(Icons.event),
      ),
    );
  }
}

// Usage
void main() {
  final event = {
    'title': 'Flutter Conference 2024',
    'startDate': Timestamp.fromDate(DateTime(2024, 6, 15, 9, 0)),
    'location': 'San Francisco',
  };
  
  // Use in Flutter app
  runApp(MaterialApp(
    home: Scaffold(
      body: EventCard(eventData: event),
    ),
  ));
}
```

### 8. Batch Processing & Analytics

**Scenario:** Processing multiple documents for analytics

```dart
import 'package:mapdescriptor/mapdescriptor.dart';

class AnalyticsProcessor {
  final MapDescriptor _mapDescriptor = MapDescriptor();
  
  Future<Map<String, dynamic>> generateUserActivityReport(
    List<Map<String, dynamic>> userActivities
  ) async {
    final processedActivities = <Map<String, dynamic>>[];
    
    for (var activity in userActivities) {
      // Convert to DateTime for date calculations
      final dateTimeActivity = _mapDescriptor.convertTimeStampToDateTime(activity);
      processedActivities.add(dateTimeActivity);
    }
    
    // Perform analytics
    final report = {
      'totalActivities': processedActivities.length,
      'dateRange': _calculateDateRange(processedActivities),
      'activities': processedActivities.map((a) {
        // Convert back to strings for JSON export
        return _mapDescriptor.convertTimeStampToStr(a);
      }).toList(),
    };
    
    return report;
  }
  
  Map<String, String> _calculateDateRange(List<Map<String, dynamic>> activities) {
    if (activities.isEmpty) return {'start': 'N/A', 'end': 'N/A'};
    
    final dates = activities
        .map((a) => a['timestamp'] as DateTime)
        .toList()
      ..sort();
    
    return {
      'start': dates.first.toIso8601String(),
      'end': dates.last.toIso8601String(),
    };
  }
}
```

## 🔧 Advanced Usage

### Working with Lists of Maps

```dart
final data = {
  'users': [
    {'name': 'User 1', 'joinedAt': Timestamp.now()},
    {'name': 'User 2', 'joinedAt': Timestamp.now()},
  ]
};

// Note: The package handles nested maps, but not lists directly
// Process each map in the list individually
final mapDescriptor = MapDescriptor();
final processedUsers = (data['users'] as List).map((user) {
  return mapDescriptor.convertTimeStampToStr(user as Map<String, dynamic>);
}).toList();
```

### Error Handling

```dart
final mapDescriptor = MapDescriptor();

try {
  final emptyMap = <String, dynamic>{};
  mapDescriptor.convertTimeStampToStr(emptyMap);
} catch (e) {
  print('Error: $e'); // ArgumentError: You provided an empty map: {}
}
```

### Performance Considerations

```dart
// For large datasets, consider processing in batches
Future<List<Map<String, dynamic>>> processBatch(
  List<Map<String, dynamic>> batch
) async {
  final mapDescriptor = MapDescriptor();
  return batch.map((item) => mapDescriptor.convertTimeStampToStr(item)).toList();
}

// Process 1000 documents in batches of 100
final allDocs = await fetchDocuments(); // 1000 documents
final batchSize = 100;
final results = <Map<String, dynamic>>[];

for (var i = 0; i < allDocs.length; i += batchSize) {
  final batch = allDocs.sublist(
    i,
    i + batchSize > allDocs.length ? allDocs.length : i + batchSize
  );
  results.addAll(await processBatch(batch));
}
```

## 🤝 Common Patterns

### Pattern 1: Firestore → JSON API

```dart
// Firestore data → API response
final firestoreDoc = await getFirestoreDocument();
final apiResponse = MapDescriptor().convertTimeStampToStr(firestoreDoc);
return jsonEncode(apiResponse);
```

### Pattern 2: JSON API → Firestore

```dart
// API request → Firestore data
final jsonData = jsonDecode(requestBody);
final firestoreData = MapDescriptor().convertStrToTimeStamp(jsonData);
await saveToFirestore(firestoreData);
```

### Pattern 3: Safe Map Copying

```dart
// Create independent copy before modification
final original = await getDocument();
final copy = MapDescriptor().deepCopy(original);
copy['status'] = 'modified';
// original remains unchanged
```

### Pattern 4: Data Format Detection

```dart
final mapDescriptor = MapDescriptor();

if (mapDescriptor.containsTimeStamp(data)) {
  // Handle Firestore format
} else if (mapDescriptor.containsISO8601Str(data)) {
  // Handle API format
} else {
  // Handle other formats
}
```

## 📖 API Summary

| Method | Input | Output | Purpose |
|--------|-------|--------|---------|
| `convertTimeStampToStr` | Map with Timestamps | Map with ISO 8601 strings | Firestore → JSON |
| `convertStrToTimeStamp` | Map with ISO 8601 strings | Map with Timestamps | JSON → Firestore |
| `convertTimeStampToDateTime` | Map with Timestamps | Map with DateTime objects | Firestore → Dart DateTime |
| `containsTimeStamp` | Any map | boolean | Detect Timestamp objects |
| `containsISO8601Str` | Any map | boolean | Detect ISO 8601 strings |
| `isEqual` | Two maps | boolean | Deep equality with Timestamps |
| `deepCopy` | Any map | Copied map | Independent copy |

## 🐛 Troubleshooting

### Issue: Empty map error
```dart
// ❌ Wrong
MapDescriptor().convertTimeStampToStr({});

// ✓ Correct
if (myMap.isNotEmpty) {
  MapDescriptor().convertTimeStampToStr(myMap);
}
```

### Issue: Timestamp validation error
```dart
// Ensure nanoseconds are in valid range (0 to 999,999,999)
// Ensure seconds are in valid range (-62135596800 to 253402300799)
final timestamp = Timestamp(1650000000, 500000000); // ✓ Valid
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Repository**: [https://github.com/KBM90/mapdescriptor](https://github.com/KBM90/mapdescriptor)
- **Issues**: [https://github.com/KBM90/mapdescriptor/issues](https://github.com/KBM90/mapdescriptor/issues)
- **Pub.dev**: [https://pub.dev/packages/mapdescriptor](https://pub.dev/packages/mapdescriptor)

## 📞 Support

If you have any questions or need help, please:
- Open an issue on [GitHub](https://github.com/KBM90/mapdescriptor/issues)
- Check existing issues for solutions
- Review the examples in the `/example` directory

## 🙏 Acknowledgments

Special thanks to all contributors and users who have helped improve this package!

---

**Made with ❤️ for the Flutter & Dart community**
