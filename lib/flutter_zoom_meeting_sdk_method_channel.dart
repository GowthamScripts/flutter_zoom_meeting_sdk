import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk_options.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk_platform_interface.dart';

class MethodChannelZoom extends ZoomPlatform {
  final MethodChannel channel =
      const MethodChannel('plugins.flutter_zoom_meeting_sdk/zoom_channel');

  final EventChannel eventChannel =
      const EventChannel('plugins.flutter_zoom_meeting_sdk/zoom_event_stream');

  @override
  Future<List> initZoom(ZoomOptions options) async {
    var optionMap = <String, String>{};
    if (options.appKey != null) {
      optionMap['appKey'] = options.appKey!;
    }
    if (options.appSecret != null) {
      optionMap['appSecret'] = options.appSecret!;
    }
    if (options.jwtToken != null) {
      optionMap['jwtToken'] = options.jwtToken!;
    }
    optionMap['domain'] = options.domain;
    return channel
        .invokeMethod<List>('init', optionMap)
        .then<List>((List? value) => value ?? []);
  }

  @override
  Future<bool> startMeeting(ZoomMeetingOptions options) async {
    assert(options.zoomAccessToken != null);
    assert(options.displayName != null);
    var optionMap = <String, String>{};
    optionMap['userId'] = options.userId;
    optionMap['displayName'] = options.displayName!;
    optionMap['meetingId'] = options.meetingId;
    optionMap['meetingPassword'] = options.meetingPassword;
    optionMap['zoomAccessToken'] = options.zoomAccessToken!;
    optionMap['disableDialIn'] = options.disableDialIn;
    optionMap['disableDrive'] = options.disableDrive;
    optionMap['disableInvite'] = options.disableInvite;
    optionMap['disableShare'] = options.disableShare;
    optionMap['noDisconnectAudio'] = options.noDisconnectAudio;
    optionMap['noAudio'] = options.noAudio;
    if (options.meetingViewOptions != null) {
      optionMap['meetingViewOptions'] = options.meetingViewOptions!.toString();
    }

    return channel
        .invokeMethod<bool>('start', optionMap)
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<bool> joinMeeting(ZoomMeetingOptions options) async {
    var optionMap = <String, String>{};
    optionMap['userId'] = options.userId;
    optionMap['meetingId'] = options.meetingId;
    optionMap['meetingPassword'] = options.meetingPassword;
    optionMap['disableDialIn'] = options.disableDialIn;
    optionMap['disableDrive'] = options.disableDrive;
    optionMap['disableInvite'] = options.disableInvite;
    optionMap['disableShare'] = options.disableShare;
    optionMap['noDisconnectAudio'] = options.noDisconnectAudio;
    optionMap['noAudio'] = options.noAudio;
    if (options.meetingViewOptions != null) {
      optionMap['meetingViewOptions'] = options.meetingViewOptions!.toString();
    }

    return channel
        .invokeMethod<bool>('join', optionMap)
        .then<bool>((bool? value) => value ?? false);
  }

  @override
  Future<List> meetingStatus(String meetingId) async {
    var optionMap = <String, String>{};
    optionMap['meetingId'] = meetingId;

    return channel
        .invokeMethod<List>('meeting_status', optionMap)
        .then<List>((List? value) => value ?? []);
  }

  @override
  Stream<dynamic> onMeetingStatus() {
    return eventChannel.receiveBroadcastStream();
  }

  @override
  Future<String?> getPlatformVersion() {
    return channel.invokeMethod<String>('getPlatformVersion');
  }
}

