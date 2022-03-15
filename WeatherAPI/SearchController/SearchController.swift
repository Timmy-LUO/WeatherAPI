//
//  SearchController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

class SearchController: UIViewController {
    //MARK: - Properties
    weak var searchCityDelegate: SearchResult?
    var searchWeatherData = [WeatherData]()
    var searchResult = [String]()
    private let searchView = SearchView()
    var cities = [
        "Keelung", "Taipei", "New Taipei", "Taoyuan", "Hsinchu", "Hsinchu County", "Miaoli", "Miaoli County", "Taichung", "Changhua", "Changhua County", "Nantou County", "Nantou", "Yunlin County", "Chiayi County", "Chiayi", "Tainan", "Kaohsiung", "Pingtung County", "Pingtung", "Yilan County", "Yilan", "Hualien County", "Hualien", "Taitung County", "Taitung", "Penghu County",]
    
    var searchArr: [String] = [String]() {
        didSet {
            self.searchView.searchCityTableView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityTableViewDelegate()
        setupNavigationItem()
        setupSearchController()
//        searchView.searchTextField.addTarget(self, action: #selector(enterSearchCity), for: .editingDidEndOnExit)
    }
    
    //MARK: - Methods
    private func searchCityTableViewDelegate() {
        searchView.searchCityTableView.dataSource = self
        searchView.searchCityTableView.delegate = self
    }
    
//    @objc
//    func enterSearchCity() {
//
//    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Search City"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
        let backButton = UIBarButtonItem(image: UIImage(named: "backButtonImage"), style: .plain, target: self, action: #selector(backButton))
        backButton.tintColor = .green
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchView.uiSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchView.uiSearchController.searchBar.searchBarStyle =
          .prominent
        searchView.uiSearchController.searchResultsUpdater = self
        self.searchView.uiSearchController.searchBar.sizeToFit()
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
                        self.searchWeatherData.append(weatherData)
//                        mainView.weatherListTableView.reloadData()
                    }
                }
            }
        }.resume()
    }
}




//MARK: - TableViewDataSource
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchView.uiSearchController.isActive) {
            return searchArr.count
        } else {
            return cities.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        if (searchView.uiSearchController.isActive) {
            cell.textLabel?.text = searchArr[indexPath.row]
            return cell
        } else {
            cell.textLabel?.text = cities[indexPath.row]
            return cell
        }
    }
}

//MARK: - TableViewDelegate
extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (searchView.uiSearchController.isActive) {
            print("關鍵字 \(searchArr[indexPath.row])")
            
            
        } else {
            print("列表 \(cities[indexPath.row])")
            
            
        }
//        let city = cities[indexPath.row]
//        cities.insert(city, at: 0)
//        searchCityDelegate?.searchResult(city: city, searchResult: searchResult)
//        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        searchArr = cities.filter { city -> Bool in
            return city.contains(searchText)
        }
    }
}
