//
//  SearchView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

class SearchView: UIView {
    //MARK: - UIs
    var uiSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController
          .hidesNavigationBarDuringPresentation = true
        searchController
          .obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    let searchCityTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
//        tableView.backgroundColor = .systemGray2
        return tableView
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
        addSubview(searchCityTableView)
        searchCityTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.trailing.bottom.equalTo(0)
        }
    }
}
