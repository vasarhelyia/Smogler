//
//  ViewController.swift
//  Smogler
//
//  Created by Vasarhelyi Agnes on 2017. 02. 19..
//  Copyright © 2017. vasarhelyia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AQIDelegate {
	
	private var cityLabel = UILabel()
	private var valueLabel = UILabel()
    private var descriptionLabel = UILabel()
	private var activityIndicator = UIActivityIndicatorView()
	private var contentView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
        
    // Config UI
    self.view.addSubview(activityIndicator)
    self.view.addSubview(contentView)
  
    cityLabel.font = UIFont.systemFont(ofSize: 30)
    cityLabel.textAlignment = .center
    cityLabel.numberOfLines = 0
    contentView.addSubview(cityLabel)
  
    valueLabel.font = UIFont.boldSystemFont(ofSize: 70)
    valueLabel.numberOfLines = 1
    contentView.addSubview(valueLabel)
  
    descriptionLabel.font = UIFont.systemFont(ofSize: 30)
    descriptionLabel.numberOfLines = 1
    contentView.addSubview(descriptionLabel)
  
    // Setup constraints
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    cityLabel.translatesAutoresizingMaskIntoConstraints = false
    valueLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      // Activity indicator
      activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      
      // Content view
      contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      
      // City
      cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
      cityLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: 100),
      cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
      cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

      // Value
      valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      valueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

      // Description
      descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 100),
      descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
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
		self.descriptionLabel.text = "\(level.text) \(level.emoji)"
	}
	
	func didFailWithError(err: String) {
		activityIndicator.stopAnimating()
		self.descriptionLabel.text = err
	}

}
