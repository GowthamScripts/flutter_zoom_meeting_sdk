import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk_method_channel.dart';

void main() {
  MethodChannelZoom platform = MethodChannelZoom();
  const MethodChannel channel = MethodChannel('plugins.flutter_zoom_meeting_sdk/zoom_channel');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getPlatformVersion') {
        return 'Android 15';
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), 'Android 15');
  });
}

