//
//  WeatherViewController.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/2.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var mainTempLabel: UILabel!
    @IBOutlet private weak var weatherMainLabel: UILabel!
    @IBOutlet private weak var weaderIconImageView: UIImageView!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    private var imgUrl = String()
    private var locationManager = CLLocationManager()
    private var latitude: CLLocationDegrees = 40
    private var longitude: CLLocationDegrees = 45
    private var weatherViewModelm = WeatherViewModelm()
    var cityName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.cityName == nil {
            getPlace(location: CLLocation(latitude: self.latitude, longitude: self.longitude)) { [weak self] (placeMark) in
                self?.weatherViewModelm.fetchWeatherData(placeMark?.country ?? String())
            }
        } else {
            self.weatherViewModelm.fetchWeatherData(self.cityName!)
        }
         
        self.weatherViewModelm.didUpdateDateClosure = { [weak self] in
            self?.configueView()
        }
        self.configureLocationManager()
    }
    
    // MARK: - Private Methods -
    
    private func configueView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.nameLabel.text = self.weatherViewModelm.weatherModel.name
            self.mainTempLabel.text = "\(Int(self.weatherViewModelm.weatherModel.main?.temp ?? 0.0))˚C"
            self.weatherMainLabel.text = self.weatherViewModelm.weatherModel.weather[0].main
            self.weatherDescriptionLabel.text = self.weatherViewModelm.weatherModel.weather[0].weatherDescription
            
            let icon = self.weatherViewModelm.weatherModel.weather[0].icon
            self.imgUrl = "https://openweathermap.org/img/wn/\(icon).png"
            self.weaderIconImageView.imageFromServerURL(urlString: self.imgUrl)
        }
    }
    
    private func configureLocationManager() {
        var hasPermission: Bool
        locationManager.requestWhenInUseAuthorization()
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            hasPermission = false
        default:
            hasPermission = true
        }
        
        if hasPermission {
            guard let currentLoc = locationManager.location else { return }
            
            self.latitude = currentLoc.coordinate.latitude
            self.longitude = currentLoc.coordinate.longitude
        }
    }
}
