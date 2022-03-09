//
//  MainController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit

class MainController: UIViewController {
    //MARK: - Properties
    private let mainView = MainView()
    
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherListTableViewDelegate()
        setupNavigationItem()
        
    }
    
    //MARK: - Methods
    private func weatherListTableViewDelegate() {
        mainView.weatherListTableView.dataSource = self
        mainView.weatherListTableView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Weather"
    }
    
    func getWeatherData(city: String) {
        let address = "https://api.openweathermap.org/data/2.5/weather?"
        if let url = URL(string: address + "q=\(city)" + "&appid=" + APIKeys.apikey) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else if let response = response as? HTTPURLResponse, let data = data {
                        print("Status code: \(response.statusCode)")
                        
                        let decoder = JSONDecoder()
                        if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                            print(weatherData)
                        }
                    }
                }
            }.resume()
        } else {
            print("Invalid URL.")
        }
    }
    
    
    
    
    
    
    let test = ["1","2","3","4","5"]
}


//MARK: - UITableViewDataSource
extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewListTableViewCell.identifier, for: indexPath) as! MainViewListTableViewCell
        
        return cell
    }
}
//MARK: - UITableViewDelegate

extension MainController: UITableViewDelegate {
    
}
