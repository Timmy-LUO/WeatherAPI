//
//  LoadingView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/17.
//

import UIKit
import SnapKit
import Lottie

class LoadingView: UIView {
    //MARK: - Properties
    let loadingView = AnimationView(name: "loadingView")
    
    
    //MARK: - UIs
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        return button
    }()
        
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingView.center = self.center
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    func setupUI() {
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(loadingView.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(165)
        }
    }
}
