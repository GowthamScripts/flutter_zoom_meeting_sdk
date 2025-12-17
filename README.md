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

   Copy `mobilertc.aar` from Zoom SDK to the **plugin's** `android/libs/` folder:
   ```
   ~/.pub-cache/hosted/pub.dev/flutter_zoom_meeting_sdk-x.x.x/android/libs/mobilertc.aar
   ```
   Or if using git dependency, locate the cached plugin in `.pub-cache/git/`.

4. **iOS Setup:**

   Copy `MobileRTC.xcframework` from Zoom SDK to the **plugin's** `ios/` folder:
   ```
   ~/.pub-cache/hosted/pub.dev/flutter_zoom_meeting_sdk-x.x.x/ios/MobileRTC.xcframework/
   ```

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

This plugin is fully compliant with Google Play's Android 15+ 16KB page size requirement. The `build.gradle` is configured with:

- `useLegacyPackaging = false` for proper JNI library alignment
- Target SDK 35
- NDK r27+ compatibility

## License

MIT License

