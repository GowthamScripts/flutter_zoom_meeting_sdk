# flutter_zoom_meeting_sdk_example

Demonstrates how to use the flutter_zoom_meeting_sdk plugin.

## Getting Started

1. Replace `YOUR_JWT_TOKEN_HERE` in `lib/main.dart` with your actual Zoom JWT token
2. For starting meetings, also replace `YOUR_ZAK_TOKEN_HERE` with your ZAK token
3. Run `flutter pub get`
4. Run `flutter run`

## Android Setup

Ensure your app's `android/app/build.gradle` has:
- `minSdkVersion 21`
- `targetSdkVersion 35`
- `compileSdkVersion 35`

## iOS Setup

Add to your `Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required for video meetings</string>
<key>NSMicrophoneUsageDescription</key>
<string>Microphone access is required for audio in meetings</string>
```

