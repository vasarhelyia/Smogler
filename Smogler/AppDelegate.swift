//
//  AppDelegate.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

	var window: UIWindow?
	private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

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

	// WCSessionDelegate
	
	func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

	func sessionDidBecomeInactive(_ session: WCSession) { }

	func sessionDidDeactivate(_ session: WCSession) {
		session.activate()
	}

	func sendAQI(aqi: AQIInfo) {
		if !((session?.isPaired)! && (session?.isWatchAppInstalled)! && (session?.isReachable)!) {
			return
		}

		session?.sendMessage(["aqi": aqi.aqiLevel.value, "city": aqi.city], replyHandler: { dict in
			print("dict sent to Watch: \(dict)")
		}, errorHandler: { err in
			print("error sending message to Watch: \(err.localizedDescription)")
		})
	}
	
}

