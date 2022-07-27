# mini-app-engines.podspec

require "json"
require './ios-rn/Podspecs/common'

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "mini-app-engines"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  mini-app-engines
                   DESC
  s.homepage     = "https://github.com/github_account/mini-app-engines"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/github_account/mini-app-engines.git", :tag => "#{s.version}" }

  s.source_files = "ios-rn/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "Flutter"
  s.dependency "FlutterModuleFrameworks-Debug"
  # s.dependency "FlutterModuleFrameworks-Profile"
  s.dependency "FlutterModuleFrameworks-Release"
  # ...
  # s.dependency "..."
end

