Pod::Spec.new do |s|
  #验证方法： pod lib lint CQModuleHelper.podspec --allow-warnings --use-libraries --verbose
  #提交方法： pod trunk push CQModuleHelper.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CQModuleHelper"
  s.version      = "0.0.1"
  s.summary      = "数据之通知(多代理模式发送数据)"
  s.homepage     = "https://github.com/dvlproad/033-Data-Notification-iOS.git"
  s.license      = "MIT"
  s.author             = { "dvlproad" => "studyroad@qq.com" }
  # s.social_media_url   = "http://twitter.com/dvlproad"
  s.description  = <<-DESC
                  - CQModuleHelper：数据之通知(多代理模式发送数据)

                   A longer description of CQModuleHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/033-Data-Notification-iOS.git", :tag => "CQModuleHelper_0.0.1" }
  # s.source_files  = "CQModuleHelper/*.{h,m}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.source_files = "CQModuleHelper/**/*.{h,m}"
  s.dependency 'CJProtocolCenter'
  s.dependency 'TSModulePublic/CJUserServicePublic'
  s.dependency 'TSModulePublic/LoginModulePublic'
  s.dependency 'TSModulePublic/OrderModulePublic'

end
