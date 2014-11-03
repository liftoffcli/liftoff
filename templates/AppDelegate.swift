import UIKit
(((CRASHLYTICS_HEADER)))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      (((CRASHLYTICS_APIKEY)))
      
      // Override point for customization after application launch.
      return true
    }
}
