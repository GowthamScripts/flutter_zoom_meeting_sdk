# Flutter Zoom Meeting SDK

A Flutter plugin for Zoom Meeting SDK 6.6.11 with full Android 15+ 16KB page size support.

## Features

- Initialize Zoom SDK with JWT token or App Key/Secret
- Join meetings as a participant
- Start meetings as a host
- Monitor meeting status changes
- Full webinar support
- Custom UI meeting view options

## Requirements

### Android
- minSdkVersion: 21
- targetSdkVersion: 35
- compileSdkVersion: 35
- Zoom Meeting SDK 6.6.11

### iOS
- iOS 12.0+
- Zoom Meeting SDK 6.6.11
- Bitcode disabled

## Installation

1. Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_zoom_meeting_sdk:
    git:
      url: https://github.com/GowthamScripts/flutter_zoom_meeting_sdk.git
      ref: main
```

2. **Download Zoom SDK 6.6.11:**

   Download the Zoom Meeting SDK 6.6.11 from [Zoom Marketplace](https://marketplace.zoom.us/docs/sdk/native-sdks/android/getting-started/install-sdk/).

3. **Android Setup:**

   Copy `mobilertc.aar` from Zoom SDK to your project's `android/app/libs/` folder. Create the `libs` folder if it doesn't exist.

   Add to your app's `android/app/build.gradle`:
   ```gradle
   dependencies {
       implementation fileTree(dir: 'libs', include: ['*.aar'])
   }
   ```

4. **iOS Setup:**

   Copy the MobileRTC.xcframework from Zoom SDK to your project's `ios/` folder. Then add it to your Xcode project:
   
   - Open `ios/Runner.xcworkspace` in Xcode
   - Drag `MobileRTC.xcframework` into Frameworks, Libraries, and Embedded Content
   - Set "Embed & Sign" for the framework

   Add to your app's `Info.plist`:
   ```xml
   <key>NSCameraUsageDescription</key>
   <string>Camera access is required for video meetings</string>
   <key>NSMicrophoneUsageDescription</key>
   <string>Microphone access is required for audio in meetings</string>
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

// Join a meeting
await zoom.joinMeeting(ZoomMeetingOptions(
  userId: 'User Name',
  meetingId: '123456789',
  meetingPassword: 'password',
  disableDialIn: 'false',
  disableDrive: 'false',
  disableInvite: 'false',
  disableShare: 'false',
  noDisconnectAudio: 'false',
  noAudio: 'false',
));

// Listen to meeting status changes
zoom.onMeetingStateChanged.listen((status) {
  print('Meeting status: $status');
});
```

## Android 15+ 16KB Page Size Support

This plugin is configured for Google Play's Android 15+ 16KB page size requirement:

- `useLegacyPackaging = false` for proper JNI library alignment
- Target SDK 35
- NDK r27+ compatibility

### Important Notes

1. **Zoom SDK Compliance**: Zoom Meeting SDK claims 16KB support in versions ≥ 6.3.0, but some `.so` files may still be 4KB aligned (especially 32-bit slices). Manually verify alignment before uploading to Play Store.

2. **Verify `.so` alignment**: Use this command to check your APK:
   ```bash
   unzip -p your-app.apk lib/arm64-v8a/*.so | file -
   ```

3. **NDK Build Flags**: For custom native code, use NDK r28+ and add:
   ```gradle
   android {
       defaultConfig {
           externalNativeBuild {
               cmake {
                   arguments "-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON"
               }
           }
       }
   }
   ```

For more details, see [Android 16KB page size documentation](https://developer.android.com/guide/practices/page-sizes).

## License

MIT License

