
Pod::Spec.new do |s|
  s.name             = 'PTTestKit'
  s.version          = '0.1.0'
  s.summary          = 'Wow PTTestKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    # 长的描述信息
  s.description      = <<-DESC
Wow this is a amazing kit,
Enjoy yourself!
                       DESC

    # 提交到git服务区的项目主页，没提交可以指定任意值，但需要保留这一项，否则会报错
    # attributes: Missing required attribute `homepage`.
    s.homepage         = 'https://github.com/flypigrmvb/PTTestKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    # 授权文件
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    # 用户信息
    s.author           = { 'flypigrmvb' => '862709539@qq.com' }
    # 提交到git上的源码路径，没提交可以指定任意值，但需要保留这一项，否则会报错
    # attributes: Missing required attribute `source`.
    s.source           = { :git => 'https://github.com/flypigrmvb/PTTestKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    # 指定最低的ios版本
    s.ios.deployment_target = '8.0'

    # 源文件的路径
    s.source_files = 'PTTestKit/Classes/**/*'

    # 公共的头文件，按需设置
    s.public_header_files = 'PTTestKit/Classes/Public/**/*.h'
    # 私有的头文件，按需设置
    s.private_header_files = 'PTTestKit/Classes/Private/**/*.h'
    # 依赖的系统Framework，按需设置
    # s.frameworks = 'UIKit', 'MapKit'
    # 依赖其他的pod库，按需设置
    # s.dependency 'AFNetworking', '~> 2.3'
end
