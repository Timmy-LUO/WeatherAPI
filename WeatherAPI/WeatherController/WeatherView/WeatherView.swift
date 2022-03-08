//
//  WeatherView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/8.
//

import UIKit
import SnapKit

class WeatherView: UIView {
    
    //MARK: - Properties
    
    
    
    //MARK: - UIs
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - SetupUI
    private func setupUI() {
        
        addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
