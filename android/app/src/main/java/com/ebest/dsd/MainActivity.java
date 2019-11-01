package com.ebest.dsd;

import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "com.ebest.dsd.bluetooth/sendAddress";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("sendAddress")) {
                  String address = call.argument("address");
                  Log.e("MainActivity","address = " + address);
                  String path = "";
                    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.FROYO) {
                      path = MainActivity.this.getExternalFilesDir("img").getPath();
                    }
                  Log.e("MainActivity","path = " + path);
                  new PrinterExecutorByZebraBitmap(address,path).execute();
                } else {
                  result.notImplemented();
                }
              }
            });

  }
}
