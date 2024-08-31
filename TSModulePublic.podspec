Pod::Spec.new do |s|
  #验证方法： pod lib lint TSModulePublic.podspec --allow-warnings --use-libraries --verbose
  #提交方法： pod trunk push TSModulePublic.podspec --allow-warnings --use-libraries --verbose
  s.name         = "TSModulePublic"
  s.version      = "0.0.1"
  s.summary      = "模块化的底层公共方法(含模块间通知和模块间跳转）"
  s.homepage     = "https://github.com/dvlproad/033-Data-Notification-iOS.git"
  s.license      = "MIT"
  s.author             = { "dvlproad" => "studyroad@qq.com" }
  # s.social_media_url   = "http://twitter.com/dvlproad"
  s.description  = <<-DESC
                  - TSModulePublic：测试模块化

                   A longer description of TSModulePublic in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/033-Data-Notification-iOS.git", :tag => "TSModulePublic_0.0.1" }
  # s.source_files  = "TSModulePublic/*.{h,m}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  # s.source_files = "TSModulePublic/**/*.{h,m}"


  # 模块间通知的协议
  s.subspec 'CJUserServiceProtocolForModule' do |ss|
    ss.source_files = "TSModulePublic/CJUserServiceProtocolForModule.{h,m}"
  end



  # 模块间跳转的协议
  s.subspec 'LoginModulePublic' do |ss|
    ss.source_files = "TSModulePublic/LoginModulePublic.{h,m}"
  end
  s.subspec 'OrderModulePublic' do |ss|
    ss.source_files = "TSModulePublic/OrderModulePublic.{h,m}"
  end

end
