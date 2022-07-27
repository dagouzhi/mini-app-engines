require 'json'

def use_mini_app_engines! (options={})
  package = JSON.parse(File.read(File.join(__dir__, "../package.json")))
  packageName = package['name']
  prefix = options[:path] ||= "../node_modules/#{packageName}"

  pod 'Flutter', :podspec => "#{prefix}/assets/ios/framework/Release/Flutter.podspec"
  pod 'FlutterModuleFrameworks-Debug',
    :configuration => 'Debug',
    :podspec => "#{prefix}/ios-rn/Podspecs/MiniAppEngines-Debug.podspec"
  # pod 'FlutterModuleFrameworks-Profile',
  #   :configuration => 'Profile',
  #   :podspec => "#{prefix}/ios-rn/Podspecs/MiniAppEngines-Profile.podspec"
  pod 'FlutterModuleFrameworks-Release',
    :configuration => 'Release',
    :podspec => "#{prefix}/ios-rn/Podspecs/MiniAppEngines-Release.podspec"
end