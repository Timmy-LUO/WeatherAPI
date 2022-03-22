//
//  LoadingController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/17.
//

import UIKit
import Lottie

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
//        loadingView.loadingActivityView.center = view.center
        loadingView.cancelButton.addTarget(self, action: #selector(cancelLoadingButton), for: .touchUpInside)
        loadingView.loadingView.animationSpeed = 2
        loadingView.contentMode = .scaleAspectFill
        loadingView.loadingView.loopMode = .autoReverse
        loadingView.loadingView.play()
        let timeBack = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(cancelLoadingButton), userInfo: nil, repeats: false)
    }
    
    @objc func cancelLoadingButton(_sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
