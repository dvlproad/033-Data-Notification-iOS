Pod::Spec.new do |s|
  #验证方法： pod lib lint CJProtocolCenter.podspec --allow-warnings --use-libraries --verbose
  #提交方法： pod trunk push CJProtocolCenter.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJProtocolCenter"
  s.version      = "0.1.0"
  s.summary      = "数据之通知(多代理模式发送数据)"
  s.homepage     = "https://github.com/dvlproad/CJNetwork.git"
  s.license      = "MIT"
  s.author             = { "dvlproad" => "studyroad@qq.com" }
  # s.social_media_url   = "http://twitter.com/dvlproad"
  s.description  = <<-DESC
                  - CJProtocolCenter：数据之通知(多代理模式发送数据)

                   A longer description of CJProtocolCenter in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/CJNetwork.git", :tag => "CJProtocolCenter_0.1.0" }
  # s.source_files  = "CJProtocolCenter/*.{h,m}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.source_files = "CJProtocolCenter/**/*.{h,m}"

end
