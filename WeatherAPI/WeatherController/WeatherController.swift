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
    
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
