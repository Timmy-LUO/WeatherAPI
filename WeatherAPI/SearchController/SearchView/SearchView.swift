//
//  SearchView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    //MARK: - properties

    
    
    //MARK: - UIs
//    let searchTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Enter City"
//        textField.font = .boldSystemFont(ofSize: 25)
//        textField.clearButtonMode = .whileEditing
//        textField.becomeFirstResponder()
//        textField.backgroundColor = .systemGray4
//        return textField
//    }()
    
    var uiSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController
          .hidesNavigationBarDuringPresentation = false
        searchController
          .dimsBackgroundDuringPresentation = false
        return searchController
    }()
    
    let searchCityTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.backgroundColor = .systemGray2
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
//        addSubview(searchTextField)
//        searchTextField.snp.makeConstraints { make in
//            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
//            make.leading.equalTo(15)
//            make.trailing.equalTo(-15)
//        }
        
        
        
        addSubview(searchCityTableView)
        searchCityTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.trailing.bottom.equalTo(0)
        }
    }
}
