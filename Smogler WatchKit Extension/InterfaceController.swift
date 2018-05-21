//
//  InterfaceController.swift
//  Smogler WatchKit Extension
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation

class AQILevelComplicationInfo {
	
  static var sharedInstance = AQILevelComplicationInfo()

  init() {
    level = AQILevel(level: -1)
  }

  var level: AQILevel {
    didSet {
      for complication in CLKComplicationServer.sharedInstance().activeComplications! {
        CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
      }
    }
  }
}

class InterfaceController: WKInterfaceController, WCSessionDelegate, AQIDelegate {

  let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil

  @IBOutlet weak var cityLabel: WKInterfaceLabel!
  @IBOutlet weak var valueLabel: WKInterfaceLabel!
  @IBOutlet weak var textLabel: WKInterfaceLabel!

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    session?.delegate = self
    session?.activate()

    APIService.sharedInstance.watchDelegate = self
  }

  override func willActivate() {
    APIService.sharedInstance.fetchAQI()
  }

  private func updateAQILevel(aqiInfo: AQIInfo) {
    let level = aqiInfo.aqiLevel

    self.cityLabel.setText("\(aqiInfo.city) air quality index:")
    self.valueLabel.setTextColor(level.color)
    self.valueLabel.setText("\(level.value)")
    self.textLabel.setText("\(level.text) \(level.emoji)")

    AQILevelComplicationInfo.sharedInstance.level = aqiInfo.aqiLevel
  }

  // AQIDelegate

  func didUpdateAQILevel(aqiInfo: AQIInfo) {
    self.updateAQILevel(aqiInfo: aqiInfo)
  }

  func didFailWithError(err: String) {
    print(err)
  }

  // WCSessionDelegate

  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    DispatchQueue.main.async {
      guard let aqi = message["aqi"] as? Int,
      let city = message["city"] as? String else {
        return
    }

    let aqiInfo = AQIInfo(aqiLevel: AQILevel(level: aqi), city: city)
    self.updateAQILevel(aqiInfo: aqiInfo)
    }
  }
}
