import 'package:flutter/foundation.dart';
import 'environment_util_stub.dart'
    if (dart.library.io) 'environment_util_io.dart';

/// Returns true if the code is currently being execute by unit tests
bool get isInTest => !kReleaseMode && runInTest;

/// Returns true if the current code is executing in release mode
const bool isInRelease = kReleaseMode;

/// Returns true if the current code is executing in debug mode
const bool isInDebug = kDebugMode;

/// Returns true if the current code is executing in profile mode
const bool isInProfile = kProfileMode;
