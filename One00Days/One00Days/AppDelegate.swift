//
//  AppDelegate.swift
//  One00Days
//
//  Created by Louis Tur on 2/21/16.
//  Copyright © 2016 SRLabs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//    let rootVC: One00DaysViewController = One00DaysViewController()
//    let rootVC: Day2ViewController = Day2ViewController()
//    let rootVC: Day3ViewController = Day3ViewController()
//    let rootVC: Day4ViewController = Day4ViewController()
//    let rootVC: Day6ViewController = Day6ViewController()
//    let rootVC: Day7ViewController = Day7ViewController()
//    let rootVC: Day8ViewController = Day8ViewController()
//    let rootVC: Day9ViewController = Day9ViewController()
//    let rootVC: Day10ViewController = Day10ViewController()
//    let rootVC: Day13ViewController = Day13ViewController()
//    let rootVC: Day14ViewController = Day14ViewController()
//    let rootVC: Day15ViewController = Day15ViewController()
//    let rootVC: Day16ViewController = Day16ViewController()
//    let rootVC: Day17ViewController = Day17ViewController()
//    let rootVC: Day18ViewController = Day18ViewController()
//    let rootVC: Day19ViewController = Day19ViewController()
//    let rootVC: Day20ViewController = Day20ViewController()
//    let rootVC: Day21ViewController = Day21ViewController()
//    let rootVC: Day22ViewController = Day22ViewController()
//    let rootVC: Day23ViewController = Day23ViewController()
//    let rootVC: Day24ViewController = Day24ViewController()
//    let rootVC: Day25ViewController = Day25ViewController()
//    let rootVC: Day26ViewController = Day26ViewController()
//    let rootVC: Day27ViewController = Day27ViewController()
//    let rootVC: Day29ViewController = Day29ViewController()
//    let rootVC: Day30ViewController = Day30ViewController()
//    let rootVC: Day31ViewController = Day31ViewController()
    let rootVC: Day32ViewController = Day32ViewController()
    
//    let rootVC: StackTestViewController = StackTestViewController()
    self.window?.rootViewController = rootVC
    self.window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

