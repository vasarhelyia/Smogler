//
//  LocationManager.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 03. 06..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
  func didChangeLocation()
}

class LocationManager: NSObject {
  private let locManager = CLLocationManager()
  private var location: CLLocation?
  weak var delegate: LocationManagerDelegate?

  override init() {
    super.init()
    self.locManager.delegate = self
    self.locManager.requestWhenInUseAuthorization()
    #if os(iOS)
      self.locManager.allowsBackgroundLocationUpdates = true
    #endif
  }

  func geoLoc() -> CLLocation? {
    switch CLLocationManager.authorizationStatus() {
    case .authorizedAlways, .authorizedWhenInUse, .restricted:
      if let newLoc = self.locManager.location {
        self.location = newLoc
        return newLoc
      } else {
        print("Could not get location update, assuming previous location is still close by the same air quality station.")
        return self.location
      }
    default:
        print("Not authorized to get location update.")
    }

    return nil
  }
}

// MARK: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse, .restricted:
      self.delegate?.didChangeLocation()
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.delegate?.didChangeLocation()
  }
}
