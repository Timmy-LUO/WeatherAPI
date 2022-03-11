//
//  WeatherListTableViewCell.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

class MainViewListTableViewCell: UITableViewCell {
    
    static let identifier = "weatherListTableViewCell"
    
    //MARK: - UIs
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 1
        return view
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        addSubview(customBackgroundView)
        customBackgroundView.snp.makeConstraints { make in
            make.top.left.equalTo(self).offset(10)
            make.bottom.right.equalTo(self).offset(-10)
        }
        
        addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(customBackgroundView).offset(10)
            make.left.equalTo(customBackgroundView).offset(10)
        }
        
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.right.equalTo(customBackgroundView).offset(-10)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(customBackgroundView)
            make.bottom.equalTo(customBackgroundView)
            make.right.equalTo(tempLabel.snp.left).offset(-10)
        }
    }
}
