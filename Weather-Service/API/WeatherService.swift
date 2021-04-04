//
//  WeatherService.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/3.
//

import Foundation

class WeatherService {
    static let shared = WeatherService()
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherData(city: String, completionHandler : @escaping (WeatherModel) -> Void ) {
        enum Keys: String { case q, appid, units }
        let session = URLSession(configuration: .default)
        var dataTask : URLSessionDataTask?
        let apiKey = "a8bdb8adad78c5d9c7d8e7331eaa05b7"
        var items = [URLQueryItem]()
        var url = URLComponents(string: baseURL)
        let param = [Keys.q.rawValue: "\(city)",
                     Keys.appid.rawValue: apiKey,
                     Keys.units.rawValue: "metric"]
        for (key,value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        url?.queryItems = items
        let request =  URLRequest(url: (url?.url)!)
        
        dataTask = session.dataTask(with: request, completionHandler: {data, response, error in
            if let error = error {
                print("error in url session")
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                }
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(WeatherModel.self, from: data)
                completionHandler(user)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        })
        dataTask?.resume()
    }
}
