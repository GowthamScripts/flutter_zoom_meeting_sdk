# Flutter Zoom Meeting SDK

A Flutter plugin for Zoom Meeting SDK 6.6.11 with full Android and iOS support.

## Features

- Initialize Zoom SDK with JWT token
- Join meetings as a participant
- Start meetings as a host
- Monitor meeting status changes
- Full webinar support
- Custom UI meeting view options

## Requirements

### Android
- minSdkVersion: 28
- targetSdkVersion: 35
- compileSdkVersion: 35
- Kotlin 2.1.0+
- AGP 8.7.0+
- Jetpack Compose support

### iOS
- iOS 12.0+
- Bitcode disabled
- Swift 5.0+

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_zoom_meeting_sdk:
    git:
      url: https://github.com/GowthamScripts/flutter_zoom_meeting_sdk.git
      ref: main
```

## Download Zoom SDK

Download Zoom Meeting SDK 6.6.11 from [Zoom Marketplace](https://marketplace.zoom.us/docs/sdk/native-sdks/android/getting-started/install-sdk/).

## Android Setup

1. **Add Zoom SDK to your app:**

   Copy `mobilertc.aar` from Zoom SDK to your app's `android/app/libs/` folder.

2. **Update `android/settings.gradle`:**

```gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.7.0" apply false
    id "org.jetbrains.kotlin.android" version "2.1.0" apply false
    id "org.jetbrains.kotlin.plugin.compose" version "2.1.0" apply false
}
```

3. **Update `android/app/build.gradle`:**

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "org.jetbrains.kotlin.plugin.compose"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace "your.app.package"
    compileSdk 35

    defaultConfig {
        minSdkVersion 28
        targetSdk 35
        multiDexEnabled true
    }

    buildFeatures {
        compose true
    }
}

dependencies {
    // Zoom SDK
    implementation fileTree(dir: 'libs', include: ['*.aar'])
    
    // Required dependencies
    implementation 'androidx.multidex:multidex:2.0.1'
    implementation 'androidx.core:core-splashscreen:1.0.1'
    implementation 'androidx.work:work-runtime:2.9.0'
    implementation 'com.google.android.exoplayer:exoplayer:2.19.1'
    implementation platform('androidx.compose:compose-bom:2024.12.01')
    implementation 'androidx.compose.ui:ui'
    implementation 'androidx.compose.foundation:foundation'
    implementation 'androidx.compose.material:material'
    implementation 'androidx.compose.material3:material3'
    implementation 'androidx.compose.runtime:runtime'
    implementation 'androidx.activity:activity-compose:1.9.0'
    implementation 'androidx.webkit:webkit:1.10.0'
}
```

4. **Add permissions to `AndroidManifest.xml`:**

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
```

## iOS Setup

1. **Add Zoom SDK to your app:**

   Copy from Zoom SDK to your app's `ios/` folder:
   - `MobileRTC.xcframework` → `ios/Frameworks/`
   - `MobileRTCResources.bundle` → `ios/Resources/`

2. **Update `ios/Podfile`:**

```ruby
platform :ios, '13.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```

3. **Add to `Info.plist`:**

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required for video meetings</string>
<key>NSMicrophoneUsageDescription</key>
<string>Microphone access is required for audio in meetings</string>
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Bluetooth is used for audio devices</string>
```

## Usage

```dart
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';

final zoom = FlutterZoomMeetingSdk();

// Initialize SDK
final initResult = await zoom.init(ZoomOptions(
  domain: 'zoom.us',
  jwtToken: 'YOUR_JWT_TOKEN',
));

// Check if initialized
if (initResult.isNotEmpty && initResult[0] == 0) {
  print('SDK initialized successfully');
  
  // Listen to meeting status changes (after init)
  zoom.onMeetingStateChanged.listen((status) {
    print('Meeting status: $status');
  });
}

// Join a meeting
await zoom.joinMeeting(ZoomMeetingOptions(
  userId: 'Display Name',
  meetingId: '123456789',
  meetingPassword: 'password',
  disableDialIn: 'false',
  disableDrive: 'false',
  disableInvite: 'false',
  disableShare: 'false',
  noDisconnectAudio: 'false',
  noAudio: 'false',
));

// Start a meeting (as host)
await zoom.startMeeting(ZoomMeetingOptions(
  userId: 'host',
  displayName: 'Host Name',
  meetingId: '123456789',
  meetingPassword: 'password',
  zoomAccessToken: 'YOUR_ZAK_TOKEN',
  disableDialIn: 'false',
  disableDrive: 'false',
  disableInvite: 'false',
  disableShare: 'false',
  noDisconnectAudio: 'false',
  noAudio: 'false',
));
```

## JWT Token Generation

Generate JWT tokens using Zoom SDK credentials from [Zoom Marketplace](https://marketplace.zoom.us/):

```javascript
// Example JWT payload
{
  "sdkKey": "YOUR_SDK_KEY",
  "appKey": "YOUR_SDK_KEY",
  "mn": "MEETING_NUMBER",
  "role": 0,  // 0 = participant, 1 = host
  "iat": ISSUED_AT_TIMESTAMP,
  "exp": EXPIRATION_TIMESTAMP,
  "tokenExp": EXPIRATION_TIMESTAMP
}
```

## Troubleshooting

### Android Build Issues

1. **Compose version mismatch**: Use `compose-bom:2024.12.01` or later
2. **Missing dependencies**: Add all required dependencies listed above
3. **minSdkVersion error**: Set minSdkVersion to 28
4. **mobilertc.aar not found**: Ensure it's in `android/app/libs/`

### iOS Build Issues

1. **MobileRTC not found**: Check framework paths in your project
2. **Bitcode error**: Disable bitcode in build settings
3. **Missing frameworks**: Xcode should auto-link required system frameworks

### Runtime Issues

1. **SDK not initialized**: Always call `init()` before other methods
2. **Invalid meeting ID**: Verify meeting exists and credentials are valid
3. **JWT expired**: Generate a fresh JWT token

## License

MIT License
