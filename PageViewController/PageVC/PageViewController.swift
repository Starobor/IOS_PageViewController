//
//  PageViewController.swift
//  PageViewController
//
//  Created by Citizen on 11.09.2018.
//  Copyright © 2018 Citizen. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var cars = [CarsHelper]()
    let chevrolet = UIImage(named: "chevrolet")
    let toyota = UIImage(named: "toyota")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cars"
        
        self.dataSource = self
        self.delegate = self
        
        let firstCar = CarsHelper(name: "Car - chevrolet", image: chevrolet!)
        let secondCar = CarsHelper(name: "Car - toyota", image: toyota!)
        
        cars.append(firstCar)
        cars.append(secondCar)
        
        
    }
    
    lazy var arrayCarViewControllers: [CarViewController] = {
        var carsVC = [CarViewController]()
        for car in cars {
            carsVC.append(CarViewController(carWith: car))
        }
        return carsVC
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.green
        setViewControllers([arrayCarViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewControllers.index(of: viewController) {
            if index > 0 {
                return arrayCarViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewControllers.index(of: viewController) {
            if index < cars.count - 1{
                return arrayCarViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}


