//
//  WeatherPageViewController.swift
//  Weather-Service
//
//  Created by Karen Madoyan on 2021/4/2.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    private let lightGray = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    private let weatherBGColor = UIColor(red: 61/255, green: 119/255, blue: 168/255, alpha: 1.0)
    private var pageControl = UIPageControl()
    private var currentlyShowingIndex = 0
    private lazy var orderedViewControllers: [UIViewController] = {
        let weatherViewController = WeatherViewController()
        let countriesListViewController = CountriesListViewController()
        return [weatherViewController, countriesListViewController]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        self.configureViewControllers()
        self.configureView()
        self.configurePageControl()
    }
    
    
    // MRAK: - Private Methods -
    
    private func configureViewControllers() {
        let weatherViewController = WeatherViewController()
        let countriesListViewController = CountriesListViewController()
        orderedViewControllers = [weatherViewController, countriesListViewController]
    }
    
    private func configureView() {
        let childControllers: [UIViewController] = [orderedViewControllers.first!]
       
        self.setViewControllers(childControllers, direction: .forward, animated: false, completion: nil)
        self.view.backgroundColor = .systemGroupedBackground
        self.view.frame = self.view.bounds
        
        self.dataSource = self
        self.delegate = self
    }
    
    private func configurePageControl() {
        self.pageControl = UIPageControl(frame: CGRect(x: 0,
                                                  y: UIScreen.main.bounds.maxY - 50,
                                                  width: UIScreen.main.bounds.width,
                                                  height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = lightGray // UIColor.gray
        self.pageControl.currentPageIndicatorTintColor = self.weatherBGColor
        self.view.addSubview(pageControl)
    }
}


// MARK: - UIPageViewControllerDelegate & UIPageViewControllerDataSource -

extension WeatherPageViewController: UIPageViewControllerDelegate & UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        currentlyShowingIndex -= 1
       
        return orderedViewControllers[previousIndex]
    }
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else { return nil }
        
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        currentlyShowingIndex += 1
       
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
        switch self.pageControl.currentPage {
        case 0: self.pageControl.currentPageIndicatorTintColor = self.weatherBGColor
        case 1: self.pageControl.currentPageIndicatorTintColor = self.weatherBGColor
        default: self.pageControl.currentPageIndicatorTintColor = lightGray // .gray
        }
    }
}
