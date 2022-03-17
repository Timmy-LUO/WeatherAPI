//
//  LoadingController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/17.
//

import UIKit

class LoadingController: UIViewController {
    //MARK: - Properties
    private let loadingView = LoadingView()
    
    
    
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = loadingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.loadingactivityView.center = view.center
        
    }
    

    

}
