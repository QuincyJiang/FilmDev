package com.jiangxq.filmdev;

import com.tencent.bugly.Bugly;
import com.tencent.bugly.beta.Beta;

import io.flutter.app.FlutterApplication;

/**
 * @Date Created: 2018/12/27
 * @Author: Jiangxq
 * @Description:
 */

public class App extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        initBugly();
    }
    void initBugly(){
        Beta.autoCheckUpgrade = true;
        Beta.upgradeCheckPeriod = 24*60*60 * 1000;
        Beta.smallIconId = R.drawable.app_icon;
        Bugly.init(getApplicationContext(), "9af98f9c4f", false);
    }
}
