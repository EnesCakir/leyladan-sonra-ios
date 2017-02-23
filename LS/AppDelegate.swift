//
//  AppDelegate.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 5/16/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import Alamofire
import Appirater
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarAppearace = UITabBar.appearance()
        tabBarAppearace.tintColor = UIColor.primaryColor()
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.primaryColor()
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)

      /*
       Native Push Notification
        let pushNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(pushNotificationSettings)
        application.registerForRemoteNotifications()
      */
      OneSignal.initWithLaunchOptions(launchOptions,
        appId: "cd3d9e4a-3b20-4d6f-958d-c8d04240094f",
        handleNotificationReceived: { (notification) in
          print("Received Notification - \(notification?.payload.notificationID)")
        },
        handleNotificationAction: { (result) in
          if let r = result {
            let payload = r.notification.payload
            if let additionalData = payload?.additionalData, let childID = additionalData["child-id"] as? String {
              print ("\nChild-id:\(childID)")
//              let childrenVC = UIStoryboard.childrenViewController()
//              childrenVC.showChild(childID: Int(childID)!)
//              self.window?.rootViewController?.presentViewController(importAlert, animated: true, completion: nil)
              if let tabbar : UITabBarController = self.window!.rootViewController as? UITabBarController {
                if let VCs = tabbar.viewControllers {
                  let childrenVC = (VCs[0] as! UINavigationController).viewControllers[0] as! ChildrenViewController
                  childrenVC.showChild(childID: Int(childID)!)
                }
                tabbar.selectedIndex = 0
              }
            }
          }
        
//        alertView.show()
      },
      settings: [kOSSettingsKeyInAppLaunchURL : false])
  
      Appirater.setAppId("1128950691")
      Appirater.setCustomAlertTitle("Uygulamayı Puanla")
      Appirater.setCustomAlertMessage("Eğer uygulamamızı beğendiyseniz bir dakikanızı ayırıp yorumunuzla daha çok gönüllüye ulaşmamız için bizlere destek olmak ister misiniz?")
      Appirater.setCustomAlertRateButtonTitle("Yorum yaz")
      Appirater.setCustomAlertRateLaterButtonTitle("Daha sonra hatırlat")
      Appirater.setCustomAlertCancelButtonTitle("İstemiyorum")
      Appirater.setDaysUntilPrompt(3)
      Appirater.setUsesUntilPrompt(3)
      Appirater.setTimeBeforeReminding(7)
      Appirater.setSignificantEventsUntilPrompt(-1)
      Appirater.setDebug(false)
      Appirater.appLaunched(true)

        return true
    }  

  /*
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var notification_token = deviceToken.description
        notification_token = notification_token.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: "<", with: "")
        print("Notification TOKEN = \(notification_token)")
        
        let parameters = [
            "token": notification_token,
            "platform": "iOS"]
        
        Constants.UserDefaults.set(notification_token, forKey: "token")
        
      Alamofire.request(Constants.URL.API + "/token", method: .post, parameters: parameters).response { response in
            debugPrint(response)
        }

    }
    */
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
      Appirater.appEnteredForeground(true)

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

