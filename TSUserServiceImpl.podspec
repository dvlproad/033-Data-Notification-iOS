Pod::Spec.new do |s|
  #验证方法： pod lib lint TSUserServiceImpl.podspec --allow-warnings --use-libraries --verbose
  #提交方法： pod trunk push TSUserServiceImpl.podspec --allow-warnings --use-libraries --verbose
  s.name         = "TSUserServiceImpl"
  s.version      = "0.0.1"
  s.summary      = "模块化的实现层"
  s.homepage     = "https://github.com/dvlproad/033-Data-Notification-iOS.git"
  s.license      = "MIT"
  s.author             = { "dvlproad" => "studyroad@qq.com" }
  # s.social_media_url   = "http://twitter.com/dvlproad"
  s.description  = <<-DESC
                  - TSUserServiceImpl：模块化的实现层

                   A longer description of TSUserServiceImpl in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/033-Data-Notification-iOS.git", :tag => "TSUserServiceImpl_0.0.1" }
  # s.source_files  = "TSUserServiceImpl/*.{h,m}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.source_files = "TSUserServiceImpl/**/*.{h,m}"
  s.dependency 'TSModulePublic/CJUserServicePublic'
  s.dependency 'CJProtocolCenter'
  #s.dependency 'CJBaseHelper/UIViewControllerCJHelper'  # 为了获取 topVC
  
end
