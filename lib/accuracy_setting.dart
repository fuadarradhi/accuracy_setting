import 'dart:async';

import 'package:flutter/services.dart';

enum AccuracySettingMode {
  LOCATION_MODE_OFF,
  LOCATION_MODE_SENSORS_ONLY,
  LOCATION_MODE_BATTERY_SAVING,
  LOCATION_MODE_HIGH_ACCURACY,
  NOT_IMPLEMENTED,
}

enum LocationProvider {
  GPS,
  NETWORK,
}

class AccuracySetting {
  static const MethodChannel _channel = const MethodChannel('accuracy_setting');

  static Future<AccuracySettingMode> getAccuracySetting() async {
    final int settingMode = await _channel.invokeMethod('getAccuracySetting');
    return AccuracySettingMode.values[settingMode];
  }

  static Future<bool> getProviderEnabled(
      LocationProvider locationProvider) async {
    bool providerEnabled = false;

    if (locationProvider == LocationProvider.GPS) {
      providerEnabled = await _channel.invokeMethod('getGPSEnabled');
    } else if (locationProvider == LocationProvider.NETWORK) {
      providerEnabled = await _channel.invokeMethod('getNetworkEnabled');
    }
    return providerEnabled;
  }
}
