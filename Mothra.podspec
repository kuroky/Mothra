
Pod::Spec.new do |spec|

  spec.name         = "Mothra"
  spec.version      = "1.0.0"
    
  spec.summary      = "基础框架Swift版"

  spec.description  = <<-DESC
                  基础库集合Swift版
                   DESC

  spec.homepage     = "http://www.emucoo.com"

  spec.license      = "MIT"

  spec.author             = { "kurokyfan" => "kuroky@emucoo.com" }
 
  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "ssh://git@192.168.16.172:7999/em/mothra.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes/*.swift"
  #spec.exclude_files = "Classes/Exclude"
  # spec.public_header_files = "Classes/**/*.h"
  swift_versions =  "5.0"
  
  spec.subspec "Image" do |ss|
    ss.source_files = "Classes/Image/*.swift"
    ss.dependency "Kingfisher", "5.13.2"
  end
  
  spec.subspec "HUD" do |ss|
    ss.source_files = "Classes/HUD/*.swift"
    ss.dependency "PKHUD", "5.3.0"
  end
  
  spec.subspec "Cache" do |ss|
    ss.source_files = "Classes/Cache/*.swift"
    ss.dependency "EasyStash", "1.1.4"
  end
  
  spec.subspec "Log" do |ss|
    ss.source_files = "Classes/Log/*.swift"
    ss.dependency "XCGLogger", "7.0.1"
  end

  spec.subspec "Network" do |ss|
    ss.source_files = "Classes/Network/*.swift"
    ss.dependency "Moya", "14.0.0"
  end
        
  spec.dependency "IQKeyboardManagerSwift", "6.5.5" # keyboard
  spec.dependency "SnapKit", "5.0.1" # autolayout
  spec.dependency "Hue", "5.0.0"
  
end
