class ZoomOptions {
  String domain;
  String? jwtToken;
  String? appKey;
  String? appSecret;

  ZoomOptions({
    required this.domain,
    this.jwtToken,
    this.appKey,
    this.appSecret,
  });
}

class ZoomMeetingOptions {
  static const int noButtonAudio = 2;
  static const int noButtonLeave = 128;
  static const int noButtonMore = 16;
  static const int noButtonParticipants = 8;
  static const int noButtonShare = 4;
  static const int noButtonSwitchAudioSource = 512;
  static const int noButtonSwitchCamera = 256;
  static const int noButtonVideo = 1;
  static const int noTextMeetingId = 32;
  static const int noTextPassword = 64;

  String userId;
  String? displayName;
  String meetingId;
  String meetingPassword;
  String? zoomToken;
  String? zoomAccessToken;
  String disableDialIn;
  String disableDrive;
  String disableInvite;
  String disableShare;
  String noDisconnectAudio;
  String noAudio;
  int? meetingViewOptions;

  ZoomMeetingOptions({
    required this.userId,
    required this.meetingId,
    required this.meetingPassword,
    this.displayName,
    this.zoomToken,
    this.zoomAccessToken,
    required this.disableDialIn,
    required this.disableDrive,
    required this.disableInvite,
    required this.disableShare,
    required this.noDisconnectAudio,
    required this.noAudio,
    this.meetingViewOptions,
  });
}

