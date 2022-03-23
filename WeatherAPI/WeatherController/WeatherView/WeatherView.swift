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
    private let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 8.0
        view.layer.borderColor = UIColor.secondaryLabel.cgColor
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "test"
        return label
    }()
    
    let tempHumanFeelTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Temp Human Feel"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let tempHumanFeelDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
        
    let sunriseTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Sunrise"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    let sunriseDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    let sunsetTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Sunset"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    let sunsetDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    let tempMaxTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Temp Max"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let tempMaxDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let tempMinTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Temp Min"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let tempMinDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    
    let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "Wind Speed"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    let windSpeedDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = "test"
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    //MARK: - Stack Views
    lazy var iconAndTempStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, tempLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var tempHumanFeelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempHumanFeelTitleLabel, tempHumanFeelDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var sunriseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunriseTitleLabel, sunriseDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var sunsetStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sunsetTitleLabel, sunsetDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var tempMaxStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempMaxTitleLabel, tempMaxDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var tempMinStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tempMinTitleLabel, tempMinDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var windSpeedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windSpeedTitleLabel, windSpeedDetailLabel])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
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
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.9)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        addSubview(iconAndTempStackView)
        iconAndTempStackView.snp.makeConstraints { make in
            make.center.equalTo(backgroundView)
        }
        
        addSubview(tempHumanFeelStackView)
        tempHumanFeelStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(60)
            make.leading.equalTo(20)
        }
        
        addSubview(sunriseStackView)
        sunriseStackView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(60)
            make.trailing.equalTo(-20)
        }
        
        addSubview(sunsetStackView)
        sunsetStackView.snp.makeConstraints { make in
            make.top.equalTo(sunriseStackView.snp.bottom).offset(60)
            make.trailing.equalTo(-20)
        }
        
        addSubview(tempMaxStackView)
        tempMaxStackView.snp.makeConstraints { make in
            make.top.equalTo(tempHumanFeelStackView.snp.bottom).offset(60)
            make.leading.equalTo(20)
        }
        
        addSubview(tempMinStackView)
        tempMinStackView.snp.makeConstraints { make in
            make.top.equalTo(tempMaxStackView.snp.bottom).offset(60)
            make.leading.equalTo(20)
        }
        
        addSubview(windSpeedStackView)
        windSpeedStackView.snp.makeConstraints { make in
            make.top.equalTo(sunsetStackView.snp.bottom).offset(60)
            make.trailing.equalTo(-20)
        }
    }
}
