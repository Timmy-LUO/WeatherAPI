//
//  SearchView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit

class SearchView: UIView {
    
    //MARK: - UIs
    let SearchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "test"
        textField.font = .boldSystemFont(ofSize: 30)
        textField.backgroundColor = .red
        return textField
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
        addSubview(SearchTextField)
        SearchTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
        }
        

    }
}
