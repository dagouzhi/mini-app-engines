// MiniAppEnginesModule.java

package com.reactlibrary;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import static com.facebook.react.bridge.UiThreadUtil.runOnUiThread;

import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class MiniAppEnginesModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public FlutterEngine flutterEngine;

    final String ENGINE_ID = "my_engine_flutter";

    public MiniAppEnginesModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "MiniAppEngines";
    }

    @ReactMethod
    public void sampleMethod(String stringArgument, int numberArgument, Callback callback) {
        // TODO: Implement some actually useful functionality
        callback.invoke("Received numberArgument: " + numberArgument + " stringArgument: " + stringArgument);
    }

    @ReactMethod
    public void initialize(Callback callback) {
        try {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    flutterEngine = new FlutterEngine(getReactApplicationContext());
                    // Start executing Dart code to pre-warm the FlutterEngine.
                    flutterEngine.getDartExecutor().executeDartEntrypoint(
                            DartExecutor.DartEntrypoint.createDefault()
                    );
                    FlutterEngineCache
                            .getInstance()
                            .put(ENGINE_ID, flutterEngine);
                    callback.invoke("init ok");
                }
            });

        } catch (Exception e) {
            callback.invoke("init error: "+e.toString());
        }
    }

    @ReactMethod
    public void openApplet(String stringArgument, Callback callback) {
        try {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Activity currentActivity = reactContext.getCurrentActivity();
                    // we can pass arguments to the Intent
                    if (flutterEngine != null) {
                        currentActivity.startActivity(
                                FlutterActivity
                                        .withCachedEngine(ENGINE_ID)
                                        .build(currentActivity)
                        );
                        MethodChannel channel = new MethodChannel(Objects.requireNonNull(FlutterEngineCache.getInstance().get(ENGINE_ID)).getDartExecutor().getBinaryMessenger(), "__native2flutter__");
                        channel.setMethodCallHandler((call, result) -> {

                        });
                        channel.invokeMethod("open_url", stringArgument);
                        callback.invoke("withCachedEngine");
                    } else {
                        currentActivity.startActivity(
                                FlutterActivity.createDefaultIntent(currentActivity)
                        );
                        callback.invoke("withNewEngine");
                    }
                }
            });
        } catch (Exception e) {
            callback.invoke("error: "+e.toString());
        }
    }

    @ReactMethod
    public void closeApplet(String stringArgument, Callback callback) {
        try {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // we can pass arguments to the Intent
                    if (flutterEngine != null) {
                        MethodChannel channel = new MethodChannel(Objects.requireNonNull(FlutterEngineCache.getInstance().get(ENGINE_ID)).getDartExecutor().getBinaryMessenger(), "__native2flutter__");
                        channel.setMethodCallHandler((call, result) -> {

                        });
                        channel.invokeMethod("close_url", stringArgument);
                        callback.invoke("withCachedEngine");
                    } else {
                        callback.invoke("withNewEngine");
                    }
                }
            });
        } catch (Exception e) {
            callback.invoke("error: "+e.toString());
        }
    }

    @ReactMethod
    public void sendCustomEvent(String stringArgument, Callback callback) {
        try {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    // we can pass arguments to the Intent
                    if (flutterEngine != null) {
                        MethodChannel channel = new MethodChannel(Objects.requireNonNull(FlutterEngineCache.getInstance().get(ENGINE_ID)).getDartExecutor().getBinaryMessenger(), "__native2flutter__");
                        channel.setMethodCallHandler((call, result) -> {

                        });
                        channel.invokeMethod("CUSTOM_EVENT", stringArgument);
                        callback.invoke("withCachedEngine");
                    } else {
                        callback.invoke("withNewEngine");
                    }
                }
            });
        } catch (Exception e) {
            callback.invoke("error: "+e.toString());
        }
    }
    
}
