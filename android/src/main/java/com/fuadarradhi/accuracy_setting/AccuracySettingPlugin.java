package com.fuadarradhi.accuracy_setting;


import android.location.LocationManager;
import android.os.Build;
import android.provider.Settings;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** AccuracySettingPlugin */
public class AccuracySettingPlugin implements MethodCallHandler {
  private MethodChannel channel;
  private Registrar registrar;

  AccuracySettingPlugin(Registrar registrar){
    this.registrar = registrar;
  }
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "accuracy_setting");
    channel.setMethodCallHandler(new AccuracySettingPlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call,Result result) {

    LocationManager locationManager = (LocationManager) registrar.context()
            .getSystemService(registrar.context().LOCATION_SERVICE);

    switch (call.method){
      case "getAccuracySetting":
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT && Build.VERSION.SDK_INT < Build.VERSION_CODES.P) {
          try {
            int mode = Settings.Secure.getInt(registrar.context().getContentResolver(), Settings.Secure.LOCATION_MODE);
            result.success(mode);
          } catch (Settings.SettingNotFoundException e) {
            e.printStackTrace();
          }
        }else{
          result.success(4);
        }
        break;
      case "getGPSEnabled":
        boolean gpsActive = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        result.success(gpsActive);
        break;
      case "getNetworkEnabled":
        boolean networkActive = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
        result.success(networkActive);
        break;
      default:
        result.notImplemented();
        break;
    }
  }
}
