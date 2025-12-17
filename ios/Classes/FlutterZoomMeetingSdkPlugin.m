#import "FlutterZoomMeetingSdkPlugin.h"
#if __has_include(<flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk-Swift.h>)
#import <flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk-Swift.h>
#else
#import "flutter_zoom_meeting_sdk-Swift.h"
#endif

@implementation FlutterZoomMeetingSdkPluginObjC
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterZoomMeetingSdkPlugin registerWithRegistrar:registrar];
}
@end

