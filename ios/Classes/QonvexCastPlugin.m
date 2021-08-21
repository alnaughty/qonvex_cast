#import "QonvexCastPlugin.h"
#if __has_include(<qonvex_cast/qonvex_cast-Swift.h>)
#import <qonvex_cast/qonvex_cast-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qonvex_cast-Swift.h"
#endif

@implementation QonvexCastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQonvexCastPlugin registerWithRegistrar:registrar];
}
@end
