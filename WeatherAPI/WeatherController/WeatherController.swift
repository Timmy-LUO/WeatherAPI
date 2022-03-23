//
//  WeatherController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/8.
//

import UIKit

class WeatherController: UIViewController {
    
    //MARK: - Properties
    private let weatherView = WeatherView()
    private var data: WeatherData
    
    //MARK: - Init
    init(data: WeatherData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = weatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setContent()
    }
    
    //MARK: - Methods
    private func setupNavigationItem() {
        navigationItem.title = data.name
        self.navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setContent() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(data.weather[0].icon)@2x.png")
        let image = try? Data(contentsOf: url!)
        if let dataImage = image {
            let image = UIImage(data: dataImage)
            weatherView.iconImageView.image = image
        }
        
        weatherView.tempLabel.text =
        String((data.main.temp - 273.15).numberTransform) + "°C"
        
        weatherView.tempHumanFeelDetailLabel.text =
        String((data.main.feels_like - 273.15).numberTransform) + "°C"
        
        weatherView.tempMaxDetailLabel.text =
        String((data.main.temp_max - 273.15).numberTransform) + "°C"
        
        weatherView.tempMinDetailLabel.text =
        String((data.main.temp_min - 273.15).numberTransform) + "°C"
        
        weatherView.sunriseDetailLabel.text =
        String(data.sys.sunrise.timetransform())
        
        weatherView.sunsetDetailLabel.text =
        String(data.sys.sunset.timetransform())
        
        weatherView.windSpeedDetailLabel.text =
        String(data.wind.speed)
    }
}
