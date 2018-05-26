//
//  AppDelegate+WCSessionDelegate.swift
//  Smogler
//
//  Created by Dominik Bucher on 26/05/2018.
//  Copyright © 2018 vasarhelyia. All rights reserved.
//

import Foundation
import WatchConnectivity
import UIKit

extension AppDelegate: WCSessionDelegate {

    var session: WCSession? {
        return WCSession.isSupported() ? WCSession.default : nil
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }

    func sendAQI(aqi: AQIInfo) {

        guard let session = session,
              session.isPaired,
              session.isWatchAppInstalled,
              session.isReachable
        else { return }

        session.sendMessage(["aqi": aqi.aqiLevel.value, "city": aqi.city], replyHandler: { dict in
            print("dict sent to Watch: \(dict)")
        }, errorHandler: { err in
            print("error sending message to Watch: \(err.localizedDescription)")
        })
    }
}
