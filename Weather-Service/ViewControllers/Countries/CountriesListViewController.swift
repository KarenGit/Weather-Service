//
//  CountriesListViewController.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/2.
//

import UIKit

class CountriesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var countriesListViewModel = CountriesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    
    //MARK: - Private Methods -
    
    private func configureView() {
        self.countriesListViewModel.getCountries()
        self.countriesListViewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate -

extension CountriesListViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.countriesListViewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.countriesListViewModel.countries[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherViewController = WeatherViewController()
        weatherViewController.cityName = CountryList.getCountries()[self.countriesListViewModel.countries[indexPath.row]]
        self.navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
