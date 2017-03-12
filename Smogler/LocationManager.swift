//
//  LocationManager.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 03. 06..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import CoreLocation

class LocationManager {
	private let locManager = CLLocationManager()
	private var location: CLLocation?
	
	init() {
		self.locManager.requestAlwaysAuthorization()
		#if os(iOS)
			self.locManager.allowsBackgroundLocationUpdates = true
		#endif
	}

	var geoLoc: CLLocation? {
		if (CLLocationManager.authorizationStatus() == .authorizedAlways ||
			CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
			if let newLoc = self.locManager.location {
				self.location = newLoc
				return newLoc
			} else {
				print("Could not get location update, assuming previous location is still close by the same air quality station.")
				return self.location
			}
		}
		print("Not authorized to get location update.")
		return nil
	}
}
