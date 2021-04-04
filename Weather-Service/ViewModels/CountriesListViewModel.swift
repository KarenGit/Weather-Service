//
//  CountriesListViewModel.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/4.
//

import Foundation

class CountriesListViewModel {
    var countries: [String] = [String]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    

    // MARK: - Closures -
    
    var reloadTableViewClosure: (() -> Void)? = nil
    
    func getCountries() {
        let countryList = CountryList.getCountries()
        var countriesArr: [String] = []
        countriesArr.append(contentsOf: countryList.map({$0.key}))
        self.countries = countriesArr
    }

}
