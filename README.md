# mini-app-engines

在`react native`中调用`flutter`和[`webf`](https://github.com/openwebf/webf)做小程序容器

## Getting started

`$ npm install mini-app-engines --save`

### 进入`node_modules/mini-app-engines` 去行下 `npm run build` 打包flutter(`3.0.5`)资源

## 手动配置

### ios

`ios/Podfile`添加
```
require_relative '../node_modules/react-native/scripts/react_native_pods'
require_relative '../node_modules/@react-native-community/cli-platform-ios/native_modules'
require_relative '../node_modules/mini-app-engines/ios-rn/pods' # 添加这个

platform :ios, '12.0'
install! 'cocoapods', :deterministic_uuids => false

target 'apps' do
  config = use_native_modules!

  # Flags change depending on the env values.
  flags = get_default_flags()
  
  use_react_native!(
    :path => config[:reactNativePath],
    # to enable hermes on iOS, change `false` to `true` and then install pods
    :hermes_enabled => flags[:hermes_enabled],
    :fabric_enabled => flags[:fabric_enabled],
    # An absolute path to your application root.
    :app_path => "#{Pod::Config.instance.installation_root}/.."
  )

  target 'appsTests' do
    inherit! :complete
    # Pods for testing
  end

  # Enables Flipper.
  #
  # Note that if you have use_frameworks! enabled, Flipper will not work and
  # you should disable the next line.
  use_flipper!()
 
  use_mini_app_engines!() # 添加这个

  post_install do |installer|
    react_native_post_install(installer)
    __apply_Xcode_12_5_M1_post_install_workaround(installer)
  end
end


```

再动行`pod install`


### android

`android/build.gradle`添加
```
 repositories {
    // 添加这个
    maven {
        url "$rootDir/../node_modules/mini-app-engines/build/host/outputs/repo"
    } 
    // 添加这个
    maven {
        url "https://storage.googleapis.com/download.flutter.io"
    }
    maven {
        // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
        url("$rootDir/../node_modules/react-native/android")
    }
    maven {
        // Android JSC is installed from npm
        url("$rootDir/../node_modules/jsc-android/dist")
    }
    mavenCentral {
        // We don't want to fetch react-native from Maven Central as there are
        // older versions over there.
        content {
            excludeGroup "com.facebook.react"
        }
    }
    google()
    maven { url 'https://www.jitpack.io' }
}
```

## 使用

```javascript
import MiniAppEngines from 'mini-app-engines';

// 初始化（最好打开时就调用）
MiniAppEngines.initialize(console.log);
// 打开小程序
MiniAppEngines.openApplet(
  'http://https://andycall.oss-cn-beijing.aliyuncs.com/demo/guide-styles.js',
  (text: string) => {
    console.log(text);
  },
);

```

## 注意暂时只支持 `Flutter 3.0.5`、
 
  >  [webf](https://github.com/openwebf/webf) 支持 flutter 3.0
## 视频演示 

> [B站演示](https://www.bilibili.com/video/BV1eg41117YR/)
## demo react
![alt react](./docs/images/react.jpeg)
## demo vue
![alt vue](./docs/images/vue.jpeg)
## demo vue
![alt rax](./docs/images/rax.jpeg)