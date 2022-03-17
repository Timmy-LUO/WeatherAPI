//
//  LoadingView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/17.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    //MARK: UIs
    let loadingactivityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.color = .loadingactivityColor
        activityView.startAnimating()
        
        return activityView
    }()
    
    let loadingBackgroundView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.backgroundColor = .loadingColor
        
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    func setupUI() {
        addSubview(loadingBackgroundView)
        loadingBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(loadingactivityView)
        loadingactivityView.snp.makeConstraints { make in
            make.centerX.equalTo(loadingBackgroundView.snp.centerX)
            make.centerY.equalTo(loadingBackgroundView.snp.centerY)
        }
    }
}
