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
    let weatherListTableView: UITableView = {
        let tableView = UITableView()
//        tableView.backgroundColor = .orange
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
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(0)
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
