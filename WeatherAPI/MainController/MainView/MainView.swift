//
//  MainView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    //MARK: - UIs
    lazy var changeFahrenheitCelsiusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fahrenheitLabel, middleLabel, celsiusLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let fahrenheitLabel: UILabel = {
        let label = UILabel()
        label.text = "°F"
        label.textColor = .blue
        return label
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = " / "
        label.textColor = .red
        return label
    }()
    
    let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.textColor = .yellow
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "searchButtonImage"), for: .normal)
        return button
    }()
    
    let weatherListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        tableView.register(MainViewListTableViewCell.self, forCellReuseIdentifier: MainViewListTableViewCell.identifier)
        return tableView
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
    private func setupUI() {
        addSubview(weatherListTableView)
        weatherListTableView.snp.makeConstraints { make in
            make.top.equalTo(50).inset(-10)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        addSubview(changeFahrenheitCelsiusStackView)
        changeFahrenheitCelsiusStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(20)
        }
        
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.trailing.equalTo(-30)
        }
        
        
        
    }
}
