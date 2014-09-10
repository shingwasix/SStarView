Pod::Spec.new do |s|
  s.name         = "SStarView"
  s.version      = "1.0.2"
  s.summary      = "A starView for iOS."
  s.homepage     = "https://github.com/shingwasix/SStarView"
  s.screenshots  = "https://raw.githubusercontent.com/shingwasix/SStarView/master/screenshoot.png"
  s.license      = "MIT"
  s.author       = { "Shingwa Six" => "shingwasix@gmail.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/shingwasix/SStarView.git", :tag => "#{s.version}" }
  s.source_files  = "SStarView.{h,m}"
  s.frameworks = "Foundation", "CoreGraphics", "UIKit"
  s.requires_arc = true
end
