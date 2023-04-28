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
