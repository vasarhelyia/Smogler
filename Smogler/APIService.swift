//
//  APIService.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import Foundation

let token = "YOUR_TOKEN"
let baseURLString = "https://api.waqi.info/feed"

protocol AQIDelegate: class {
  func didUpdateAQILevel(aqiInfo: AQIInfo)
  func didFailWithError(err: String)
}

class APIService: NSObject, URLSessionDataDelegate {
  static var sharedInstance = APIService()
  private var locationManager = LocationManager()

  #if os(watchOS)
    weak var watchDelegate: AQIDelegate?
  #else
    weak var delegate: AQIDelegate?
  #endif

  override init() {
    super.init()
    self.locationManager.delegate = self
  }

  // Compose request

  private var geoLocURLRequest: URLRequest? {
    let location = self.locationManager.geoLoc()
    let latitude = location?.coordinate.latitude
    let longitude = location?.coordinate.longitude
		
    if let lat = latitude, let lng = longitude {
      let urlString = "\(baseURLString)/geo:\(lat);\(lng)/?token=\(token)"

      guard let url = URL(string: urlString) else {
        #if os(watchOS)
          watchDelegate?.didFailWithError(err: "could not create URL from string \(urlString)")
        #else
          delegate?.didFailWithError(err: "could not create URL from string \(urlString)")
        #endif
        return nil
      }
      return URLRequest(url: url)
    } else {
    #if os(watchOS)
      watchDelegate?.didFailWithError(err: "could not compose URL request, no location")
    #else
      delegate?.didFailWithError(err: "could not compose URL request, no location")
    #endif
    return nil
    }
  }
	
  func fetchAQI() {
    guard let request = geoLocURLRequest else {
      return
    }

    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.urlCache = nil
    URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil).dataTask(with: request).resume()
  }

  // Parse results

  private func parseResults(json: AnyObject) -> AQIInfo? {
    guard let dict = json as? [String:Any],
      let data = dict["data"] as? [String:Any],
      let aqi = data["aqi"] as? Int,
      let cityDict = data["city"] as? [String: Any],
      let city = cityDict["name"] as? String else {
        print("Error parsing JSON. Make sure you are using a valid API token. You can acquire it here: https://aqicn.org/data-platform/token/")
        return nil
    }

    return AQIInfo(aqiLevel: AQILevel(level: aqi), city: city)
  }

  private func refreshWithAQIInfo(aqiInfo: AQIInfo?) {
    guard let aqi = aqiInfo else {
      return
    }

    DispatchQueue.main.async {
      #if os(watchOS)
        self.watchDelegate?.didUpdateAQILevel(aqiInfo: aqi)
      #else
        self.delegate?.didUpdateAQILevel(aqiInfo: aqi)
      #endif
    }
  }
	
  // MARK: URLSessionDataTaskDelegate

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    let json = try? JSONSerialization.jsonObject(with: data, options: [])
    self.refreshWithAQIInfo(aqiInfo: self.parseResults(json: json as AnyObject))
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if let e = error {
      print("URL session completed with error: \(e.localizedDescription)")
    }
  }
}

// MARK: LocationManagerDelegate

extension APIService: LocationManagerDelegate {
  func didChangeLocation() {
    self.fetchAQI()
  }
}
