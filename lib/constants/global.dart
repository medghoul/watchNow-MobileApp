import "dart:io" show Platform;

bool isAndroid = Platform.isAndroid;

// API PROD
// String apiPath = "";

// API STAGING
String apiPath = "https://www.episodate.com/api";


//TODO remove in prod
bool emulator = (apiPath == "http://10.0.2.2:8080/" || apiPath == "http://localhost:8080/") ? isAndroid : false;

bool debugActive = apiPath.contains('https://api.gncbluray.com/');
