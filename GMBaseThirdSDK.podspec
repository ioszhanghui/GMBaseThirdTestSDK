#
# Be sure to run `pod lib lint GMBaseThirdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'GMBaseThirdSDK'
s.version          = '0.1.0'
s.summary          = '国美的组建的第三方依赖库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
国美的组建的第三方依赖库 包含微信 QQ 新浪 友盟
DESC

s.homepage         = 'https://github.com/ioszhanghui/GMBaseThirdTestSDK.git'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ioszhanghui@163.com' => 'ioszhanghui@163.com' }
s.source           = { :git => 'https://github.com/ioszhanghui/GMBaseThirdTestSDK.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '9.0'
s.requires_arc = true
#配置组件的BITCODE
#s.xcconfig     = { "ENABLE_BITCODE" => "NO" }
s.frameworks = 'UIKit','Foundation'
s.source_files = 'GMBaseThirdSDK/Classes/**/*'
#微信 QQ 新浪 基础组件
s.subspec 'GMBaseSDK' do |aa|
    aa.source_files = 'GMBaseThirdSDK/Classes/GMBaseSDK/**/*'
    #子组件下添加子组件 不需要添加依赖 直接设置 子组件
    #基础组件下的 QQ
    aa.subspec 'GMTencentOpenApiSDK' do |aaa|
        aaa.ios.vendored_frameworks = 'GMBaseThirdSDK/Classes/GMBaseSDK/GMTencentOpenApiSDK/*.framework'# 引用自己生成的framework
        aaa.frameworks     = 'Security', 'SystemConfiguration', 'CoreGraphics', 'CoreTelephony'
        aaa.libraries      = 'iconv', 'z', 'c++', 'sqlite3'
    end
    #基础组件下的 微信
    aa.subspec 'GMWechatSDK' do |aab|
        aab.source_files = 'GMBaseThirdSDK/Classes/GMBaseSDK/GMWechatSDK/*'
        aab.ios.vendored_libraries = 'GMBaseThirdSDK/Classes/GMBaseSDK/GMWechatSDK/*.a'#静态库文件打包
        aab.frameworks     = 'Security', 'SystemConfiguration', 'CoreGraphics', 'CoreTelephony','CFNetwork','CoreGraphics'
        aab.libraries      = 'iconv', 'z', 'c++', 'sqlite3'
    end
    #基础组件下的 微博
    aa.subspec 'GMWeibo_SDK' do |aac|
        aac.source_files = 'GMBaseThirdSDK/Classes/GMBaseSDK/GMWeibo_SDK/*'
        aac.ios.vendored_libraries = 'GMBaseThirdSDK/Classes/GMBaseSDK/GMWeibo_SDK/*.a'#静态库文件打包
        aac.resource = 'GMBaseThirdSDK/Assets/GMWeibo_SDK/*.bundle' #自己组建需要依赖的文件 包括 .xib .storyboard .png文件.bundle文件
        aac.frameworks     = 'Security', 'SystemConfiguration', 'CoreGraphics', 'CoreTelephony','CFNetwork','CoreGraphics','QuartzCore','ImageIO','CoreText'
        aac.libraries      = 'iconv', 'z', 'c++', 'sqlite3'
    end
end

# 友盟分享 基础组件
s.subspec 'GMUMSDK' do |bb|
bb.source_files = 'GMBaseThirdSDK/Classes/GMUMSDK/**/*'
bb.dependency 'GMBaseThirdSDK/GMBaseSDK'#友盟的分享组件依赖于 三大平台的基础组件
#bb.dependency 'UMCCommon' #友盟的基础控件
#子组件下添加子组件 不需要添加依赖 直接设置 子组件
#基础组件下的Core核心组件
bb.subspec 'Core' do |bba|
bba.ios.vendored_frameworks = 'GMBaseThirdSDK/Classes/GMUMSDK/Core/*.framework'# 引用自己生成的framework
end
#基础组件下的 友盟分享 微信 QQ Sina
bb.subspec 'UMShare' do |bbb|
#基础组件下的 QQ
bbb.subspec 'QQ' do |bbba|
bbba.source_files = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/QQ/*'
bbba.ios.vendored_libraries = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/QQ/*.a'#静态库文件打包
bbba.dependency 'GMBaseThirdSDK/GMBaseSDK/GMTencentOpenApiSDK'#QQ分享依赖于 基础SDK的QQ库
bbba.dependency 'GMBaseThirdSDK/GMUMSDK/Core' #所有的分享 都要依赖于Core组件
bbba.dependency 'UMCCommon' #友盟的基础控件
end

#基础组件下的 Sina
bbb.subspec 'Sina' do |bbbb|
#aac.source_files = 'GMBaseThirdSDK/Classes/**/*'
bbbb.source_files = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/Sina/*'
bbbb.ios.vendored_libraries = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/Sina/*.a'#静态库文件打包
bbbb.dependency 'GMBaseThirdSDK/GMBaseSDK/GMWeibo_SDK'#sina分享依赖于 基础SDK的QQ库
bbbb.dependency 'GMBaseThirdSDK/GMUMSDK/Core' #所有的分享 都要依赖于Core组件
bbbb.dependency 'UMCCommon' #友盟的基础控件
end
#基础组件下的 WeChat
bbb.subspec 'WeChat' do |bbbc|
bbbc.source_files = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/WeChat/*.h'
bbbc.ios.vendored_libraries = 'GMBaseThirdSDK/Classes/GMUMSDK/UMShare/WeChat/*.a'#静态库文件打包
bbbc.dependency 'GMBaseThirdSDK/GMBaseSDK/GMWechatSDK'#微信分享 依赖于 基础SDK的QQ库
bbbc.dependency 'GMBaseThirdSDK/GMUMSDK/Core' #所有的分享 都要依赖于Core组件
bbbc.dependency 'UMCCommon' #友盟的基础控件
end
end
end


end
