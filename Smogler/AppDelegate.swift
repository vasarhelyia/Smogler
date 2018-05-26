//
//  AppDelegate.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        session?.delegate = self
        session?.activate()

        UIApplication.shared.setMinimumBackgroundFetchInterval(60 * 30)

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        APIService.sharedInstance.fetchAQI()
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        APIService.sharedInstance.fetchAQI()
        // TODO: completionHandler(.newData)?
    }
}

