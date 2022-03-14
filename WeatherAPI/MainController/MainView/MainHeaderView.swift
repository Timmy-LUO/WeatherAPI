//
//  MainHeaderView.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/11.
//

import UIKit
import SnapKit

class MainHeaderView: UIView {

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
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .stackViewColorC
        return label
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = "  |  "
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .stackViewColorF
        return label
    }()
    
    let celsiusLabel: UILabel = {
        let label = UILabel()
        label.text = "°C"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .stackViewColorF
        return label
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "searchButtonImage"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        return button
    }()
    
    let headerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupUI
    private func setupUI() {
        addSubview(headerBackgroundView)
        headerBackgroundView.snp.makeConstraints { make in
            make.top.bottom.left.right.edges.equalTo(self)
        }
        
        addSubview(changeFahrenheitCelsiusStackView)
        changeFahrenheitCelsiusStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(15)
        }
        
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.trailing.equalTo(self).offset(-10)
        }
    }
}
