//
//  WeatherViewModel.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/3.
//

import Foundation

class WeatherViewModelm {
    var weatherModel: WeatherModel!
    
    
    // MARK: - Closures -
    
    var didUpdateDateClosure: (() -> Void)? = nil
    
    
    // MARK: - Fetching functions -
    
    func fetchWeatherData(_ city: String) {
        WeatherService.shared.fetchWeatherData(city: city, completionHandler: { (data) in
            self.weatherModel = data
            self.didUpdateDateClosure?()
        })
    }
}
