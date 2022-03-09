//
//  MainController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit

class MainController: UIViewController {
    //MARK: - Properties
    private let mainView = MainView()
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

   

}
