//
//  WeatherController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/8.
//

import UIKit

class WeatherController: UIViewController {
    
    //MARK: - Properties
    private let weatherView = WeatherView()
    private var data: WeatherData
    
    
    
    init(data: WeatherData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationItem()
        
    }
    
    //MARK: - Methods
//    func setupNavigationItem() {
//        navigationItem.title = "Data Name"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
//    }
    
    
    
}
