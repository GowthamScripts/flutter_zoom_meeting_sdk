Pod::Spec.new do |s|
  s.name             = 'flutter_zoom_meeting_sdk'
  s.version          = '1.0.0'
  s.summary          = 'Flutter plugin for Zoom Meeting SDK 6.6.11'
  s.description      = <<-DESC
Flutter plugin for Zoom Meeting SDK 6.6.11 with full meeting and webinar support.
                       DESC
  s.homepage         = 'https://github.com/example/flutter_zoom_meeting_sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Developer' => 'developer@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '12.0'

  # Bitcode must be disabled for Zoom SDK
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-framework MobileRTC',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64',
    'ENABLE_BITCODE' => 'NO'
  }

  s.user_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO'
  }

  s.swift_version = '5.0'

  s.preserve_paths = 'MobileRTC.xcframework', 'MobileRTCResources.bundle', 'MobileRTCScreenShare.xcframework', 'zoomcml.xcframework'
  s.vendored_frameworks = 'MobileRTC.xcframework'
  s.resource = 'MobileRTCResources.bundle'
end

