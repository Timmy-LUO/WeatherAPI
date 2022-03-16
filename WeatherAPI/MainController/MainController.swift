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
    private let headerView = MainHeaderView()
    var weatherData = [WeatherData]()
    var cityDatas = [City]()
    var searchResult = [String]()
    var tempMode: tempTransform = .C

    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherListTableViewDelegate()
        setupNavigationItem()
        setupCurrentWeather(city: "Taipei")
        tapGestureRecognizer()
        headerView.searchButton.addTarget(self, action: #selector(searchButton), for: .touchUpInside)
    }
    
    //MARK: - Methods
    private func weatherListTableViewDelegate() {
        mainView.weatherListTableView.dataSource = self
        mainView.weatherListTableView.delegate = self
    }
    
    //MARK: SetupNaviItem
    private func setupNavigationItem() {
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always        
    }
    
    //MARK: SearchButton
    @objc
    func searchButton() {
        let vc = SearchController()
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: true, completion: nil)
    }
    
    //MARK: URL Selected
    private func urlSelected(city: String) -> URL {
        let address = "https://api.openweathermap.org/data/2.5/weather?"
        let modeSelect = Int(city)
        let urlResult: URL

        if city.contains(",") {
            let cityCoord = city.components(separatedBy: ",")
            urlResult = URL(string: address + "lat=\(cityCoord[1].urlEncoded())" + "&lon=\(cityCoord[0].urlEncoded())" + "&appid=\(APIKeys.weatherAPIKey)")!
        } else {
            if modeSelect != nil {
                urlResult = URL(string: address + "id=\(city.urlEncoded())" + "&appid=\(APIKeys.weatherAPIKey)")!
            } else {
                urlResult = URL(string: address + "q=\(city.urlEncoded())" + "&appid=\(APIKeys.weatherAPIKey)")!
            }
        }
        print(urlResult)
        return urlResult
    }
    
    //MARK: Setup Current Weather
    private func setupCurrentWeather(city: String) {
        let url = urlSelected(city: city)
        let request = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse, let data = data {
                    print("Status Code: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    
                    if let weatherData = try? decoder.decode(WeatherData.self, from: data) {
                        self.weatherData.append(weatherData)
                        self.mainView.weatherListTableView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    //MARK: - SetupCitySearch
    func setupCitySearch() {
        let headers = ["Authorization": APIKeys.cityAPIKey, "Accept": "application/json"]

        var request = URLRequest(url: URL(string: "https://www.universal-tutorial.com/api/countries/")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse,let data = data {
                print(httpResponse.statusCode)
                let decoder = JSONDecoder()
                if let cityData = try? decoder.decode(CityAPI.self, from: data) {
                    self.cityDatas = cityData
                }
            }
        })
        dataTask.resume()
    }
    
    
    //MARK: - UITapGestureRecognizer
    func tapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        headerView.changeFahrenheitCelsiusStackView.addGestureRecognizer(tap)
    }
    
    @objc
    func touch() {
        let leftLabel = headerView.fahrenheitLabel
        let rightLabel = headerView.celsiusLabel
        if leftLabel.textColor == .stackViewColorF {
            leftLabel.textColor = .stackViewColorC
            rightLabel.textColor = .stackViewColorF
            tempMode = .C
        } else if leftLabel.textColor == .stackViewColorC {
            leftLabel.textColor = .stackViewColorF
            rightLabel.textColor = .stackViewColorC
            tempMode = .F
        }
        mainView.weatherListTableView.reloadData()
    }
}


//MARK: - TableViewDataSource
extension MainController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewListTableViewCell.identifier, for: indexPath) as! MainViewListTableViewCell
        let weatherDataIndex = weatherData[indexPath.row]
            let url = URL(string: "https://openweathermap.org/img/wn/\(weatherDataIndex.weather[0].icon)@2x.png")
            let data = try? Data(contentsOf: url!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.iconImageView.image = image!
            }
            cell.cityLabel.text = weatherDataIndex.name
            cell.timeLabel.text = weatherDataIndex.dt.timetransform()
            DispatchQueue.main.async {
                switch self.tempMode {
                case .F:
                    cell.tempLabel.text = String(((weatherDataIndex.main.temp - 273.15) * 9 / 5 + 32).numberTransform) + "°"
                case .C:
                    cell.tempLabel.text = String((weatherDataIndex.main.temp - 273.15).numberTransform) + "°"
                }
            }
        return cell
    }
}

//MARK: - TableViewDelegate
extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = weatherData[indexPath.row]
        let vc = WeatherController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        weatherData.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}


extension MainController: SearchResult {
    func searchResult(city: String) {
        setupCurrentWeather(city: city)
        mainView.weatherListTableView.reloadData()
    }
}
