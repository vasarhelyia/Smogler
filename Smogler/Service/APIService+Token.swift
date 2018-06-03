//
//  Constants+Token.swift
//  Smogler
//
//  Created by Dominik Bucher on 03/06/2018.
//  Copyright © 2018 vasarhelyia. All rights reserved.
//

import Foundation


var kToken: String? {
    didSet {
        UserDefaults.standard.set(kToken, forKey: Identifiers.tokenUserDefaultsKey)
        APIService.shared.fetchAQI()
    }
}
let kBaseURLString = "https://api.waqi.info/feed"
