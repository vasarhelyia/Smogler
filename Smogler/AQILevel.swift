//
//  AQILevel.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import UIKit

struct AQIInfo {
	var aqiLevel: AQILevel
	var city: String
}

struct AQILevel {
	var value: Int
	var color: UIColor
	var text: String
	var emoji: String
	
	init(level: Int) {
		self.value = level
		
		switch self.value {
		case -1:
			self.text = "Unknown"
			self.color = UIColor.white
			self.emoji = "❓"
		case 0..<51:
			self.text = "Good"
			self.color = UIColor(red: 0/255, green: 209/255, blue: 135/255, alpha: 1.0) /* #00d187 */
			self.emoji = "👍"
		case 51..<101:
			self.text = "Moderate"
			self.color = UIColor(red: 247/255, green: 242/255, blue: 140/255, alpha: 1.0) /* #f7f28c */
			self.emoji = "😐"
		case 101..<151:
			self.text = "Unhealthy for sensitive groups"
			self.color = UIColor(red: 255/255, green: 161/255, blue: 94/255, alpha: 1.0) /* #ffa15e */
			self.emoji = "😷"
		case 151..<201:
			self.text = "Unhealthy"
			self.color = UIColor(red: 247/255, green: 66/255, blue: 66/255, alpha: 1.0) /* #f74242 */
			self.emoji = "⚠️"
		case 201..<301:
			self.text = "Very unhealthy"
			self.color = UIColor(red: 189/255, green: 108/255, blue: 247/255, alpha: 1.0) /* #bd6cf7 */
			self.emoji = "🚷"
		default:
			self.text = "Hazardous"
			self.color = UIColor(red: 140/255, green: 74/255, blue: 46/255, alpha: 1.0) /* #8c4a2e */
			self.emoji = "☣️"
		}
		
	}
}


