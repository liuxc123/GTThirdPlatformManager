Pod::Spec.new do |s|
  s.name             = 'GTThirdPlatformManager'
  s.version          = '0.0.1'
  s.summary          = '对应用中集成的第三方SDK（目前包括QQ,微信,微博,支付宝，钉钉）进行集中管理，按照功能（目前包括第三方登录,分享,支付）开放给各个产品使用。通过接口的方式进行产品集成，方便对第三方SDK进行升级维护。'

  s.homepage         = 'https://github.com/liuxc123/GTThirdPlatformManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/GTThirdPlatformManager.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  
  # 设置默认的模块，如果在pod文件中导入pod项目没有指定子模块，导入的是这里指定的模块
  s.default_subspec = 'Core'
  
  # 定义一个核心模块，用户存放抽象的接口、基类以及一些公用的工具类和头文件
  s.subspec 'Core' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/Classes/**/*'
      # 配置系统Framework
      subspec.frameworks = 'CoreMotion', 'UIKit', 'Foundation'
      subspec.dependency 'SDWebImage'
      # 添加依赖的系统静态库
      subspec.libraries = 'xml2', 'z', 'c++', 'stdc++.6', 'sqlite3.0'
  end
  
  # 支付宝模块
  s.subspec 'AlipayManager' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/AlipayManager/**/*'
      # 添加资源文件
      subspec.resource = 'GTThirdPlatformManager/AlipayManager/**/*.bundle'
      
      # 添加依赖第三方的framework
      subspec.vendored_frameworks = 'GTThirdPlatformManager/AlipayManager/**/*.framework'
      
      # 添加依赖系统的framework
      subspec.frameworks = 'CoreTelephony', 'SystemConfiguration'
      
      # 依赖的核心模块
      subspec.dependency 'GTThirdPlatformManager/Core'
  end
  
  # QQ模块
  s.subspec 'TencentManager' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/TencentManager/**/*'
      # 添加依赖第三方的framework
      subspec.vendored_frameworks = 'GTThirdPlatformManager/TencentManager/**/*.framework'
      # 添加依赖系统的framework
      subspec.frameworks = 'CoreTelephony', 'SystemConfiguration', 'Security', 'CoreGraphics', 'QuartzCore', 'MapKit', 'CoreLocation', 'AssetsLibrary'
      # 添加依赖的系统静态库
      subspec.libraries = 'iconv', 'stdc++'
      # 依赖的核心模块
      subspec.dependency 'GTThirdPlatformManager/Core'
  end
  
  # 微博模块
  s.subspec 'WeiboManager' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/WeiboManager/**/*'
      # 依赖的微博pod库
      subspec.dependency 'WeiboSDK'
      subspec.dependency 'GTThirdPlatformManager/Core'
  end

  # 微信模块
  s.subspec 'WXManager' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/WXManager/**/*'
      # 配置系统Framework
      subspec.frameworks = 'Security', 'CoreTelephony', 'SystemConfiguration'
      # 依赖的微信pod库
      subspec.dependency 'WechatOpenSDK'
      subspec.dependency 'GTThirdPlatformManager/Core'
  end
  
  # 钉钉模块
  s.subspec 'DingTalkManager' do |subspec|
      # 源代码
      subspec.source_files = 'GTThirdPlatformManager/DingTalkManager/**/*'
      # 添加依赖第三方的framework
      subspec.vendored_frameworks = 'GTThirdPlatformManager/DingTalkManager/**/*.framework'
      # 添加依赖系统的framework
      subspec.frameworks = 'SystemConfiguration'
      # 依赖的核心模块
      subspec.dependency 'GTThirdPlatformManager/Core'
  end

end
