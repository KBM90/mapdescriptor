## 1.0.0

- Initial version.

## 1.0.1

-Fixing the convertTimeStampToStr(Map<String, dynamic> myMap) to be able to convert TimeStamp values in nested Map
-You don't need to provide the fields keys you want to convert to TimeStamp inside convertStrToTimeStamp(Map<String, dynamic> myMap) function .

## 1.0.2

 -Adding containsTimeStamp() method to check if a map contains any TimeStamp value
 -Adding containsISO8601String() method to check if a map contains any ISO 8601 String value

## 1.0.3
 -Fixing issue in containsTimeStamp() & containsISO8601String() where sometimes don't gives the correct boolean value.
 
## 1.0.4

 - Fixing some bugs.
 - Addinf the deepCopy method to get a deep copy of a Map object to prevent affecting the original one.

## 1.0.5

 -Fixing the deepCopy bugs when the map is fetched from firestore.

## 1.0.6

 -Adding isEqual() method to prevent the problem comming from the fact that in Firestore, timestamps are stored as Timestamp objects which are not directly comparable to other data types . 
 
 # 1.0.7 
    
 -fix collection package version issue.

  # 1.0.8

  - Adding the convertTimeStampToDateTime(Map<String, dynamic> map) method which convert all timestamp values inside nested maps to DateTime format , which is needed to to upload into Firestore