package com.jiangxq.filmdev;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import com.tencent.bugly.beta.Beta;

import java.net.URISyntaxException;

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
                        case "donate":
                            donate();
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
  public void donate(){
      String urlCode="FKX07523AFECFXQCU1VMAC";
      Toast.makeText(this,"正在打开支付宝....",Toast.LENGTH_LONG).show();
      try {
          Intent intent=Intent.parseUri("intent://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%3A%2F%2Fqr.alipay.com%2F{urlCode}%3F_s%3Dweb-other&_t=1472443966571#Intent;scheme=alipayqr;package=com.eg.android.AlipayGphone;end".replace("{urlCode}", urlCode),1);
          startActivity(intent);
      } catch (URISyntaxException e) {
          e.printStackTrace();
      }catch (ActivityNotFoundException e){
          Toast.makeText(this,"未找到支付宝",Toast.LENGTH_SHORT).show();
      }
  }
}
