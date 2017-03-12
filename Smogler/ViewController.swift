//
//  ViewController.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AQIDelegate {
	
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var contentView: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.contentView.isHidden = true
		activityIndicator.startAnimating()
		
		APIService.sharedInstance.fetchAQI()
		APIService.sharedInstance.delegate = self
	}

	// AQIDelegate

	func didUpdateAQILevel(aqiInfo: AQIInfo) {
		(UIApplication.shared.delegate as! AppDelegate).sendAQI(aqi: aqiInfo)

		activityIndicator.stopAnimating()
		self.contentView.isHidden = false

		let level = aqiInfo.aqiLevel
		let city = aqiInfo.city
		
		self.cityLabel.text = "\(city) air quality index:"
		self.contentView.backgroundColor = level.color
		self.valueLabel.text = "\(level.value)"
		self.textLabel.text = "\(level.text) \(level.emoji)"
	}
	
	func didFailWithError(err: String) {
		activityIndicator.stopAnimating()
		self.textLabel.text = err
	}

}
