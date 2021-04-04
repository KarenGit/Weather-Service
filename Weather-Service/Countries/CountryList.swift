//
//  CountryList.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/3.
//

import Foundation

public enum CountryList {
    public static func getCountries() -> [String : String] {
        var countreis = [String: String]()
        
        if let fileUrl = Bundle.main.url(forResource: "Countries", withExtension: "json")
        {
            do {
                let data = try Data(contentsOf: fileUrl)
                let model = try JSONDecoder().decode([String: String].self, from: data)
                countreis = model
            } catch {
                fatalError("Failed to decode from Countries.json file")
            }
        } else {
            fatalError("Failed to load Countries.json file from bundle.")
        }
        return countreis
    }
}
