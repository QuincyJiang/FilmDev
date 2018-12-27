package com.jiangxq.filmdev;

import android.content.Intent;
import android.os.Bundle;

import com.tencent.bugly.beta.Beta;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static com.jiangxq.filmdev.Constants.CHANNEL;
import static com.jiangxq.filmdev.Constants.SHARE_CONTENT;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
      // MethodChannel 可以供Flutter端调用
      new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
              (MethodCall methodCall, MethodChannel.Result result) -> {
                    switch (methodCall.method){
                        case "checkUpdate":
                            checkUpdate();
                            break;
                        case "shareApp":
                            shareApp();
                            break;
                            default:
                    }
              }
      );
  }
  public void checkUpdate(){
    Beta.checkUpgrade();
  }

  public void shareApp(){
    Intent intent  = new Intent();
    intent.setAction(Intent.ACTION_SEND);
    intent.putExtra(Intent.EXTRA_TEXT, SHARE_CONTENT);
    intent.setType("text/plain");
    startActivity(Intent.createChooser(intent, "分享此应用"));
  }
}
