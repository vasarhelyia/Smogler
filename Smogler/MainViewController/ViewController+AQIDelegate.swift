//
//  ViewController+AQIDelegate.swift
//  Smogler
//
//  Created by Dominik Bucher on 26/05/2018.
//  Copyright © 2018 vasarhelyia. All rights reserved.
//

import Foundation
import UIKit
extension ViewController: AQIDelegate {
    
    func didUpdateAQILevel(aqiInfo: AQIInfo) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return }
        delegate.sendAQI(aqi: aqiInfo)
        setup(with: aqiInfo)
    }

    func didFailWithError(err: String) {
        fail(with: err)
    }
}
