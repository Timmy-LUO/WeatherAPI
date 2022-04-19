//
//  SearchController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit
import SnapKit

//MARK: - class CityStore
class CityStore {
    
    // 關鍵字
    var keyword: String? {
        didSet {
            valueChange?(cities)
        }
    }
    
    // 原本抓到的 API 資料
    private var _cities = [City]() {
        didSet {
            valueChange?(cities)
        }
    }
    
    var cities: [City] {
        guard let keyword = keyword?.lowercased() else {
            return _cities
        }
        return _cities.filter { $0.countryName.lowercased().contains(keyword) }
    }
    
    var valueChange: (([City]) -> Void)?
    var onError: ((Error) -> Void)?
    
    // MARK: - func loadCities
    func loadCities() {
        let headers = ["Authorization": APIKeys.cityAPIKey, "Accept": "application/json"]
        
        var request = URLRequest(url: URL(string: "https://www.universal-tutorial.com/api/countries/")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.onError?(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("City Status Code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let cityData = try decoder.decode(CityAPI.self, from: data)
                    DispatchQueue.main.async {
                        self._cities = cityData
                    }
                } catch {
                    self.onError?(error)
                }
            }
        }.resume()
    }
}

// MARK: - class SearchController
class SearchController: UIViewController {
    //MARK: - Properties
    private let searchView = SearchView()
    weak var searchCityDelegate: SearchResult?
    var store = CityStore()
    var searchCity = [City]() {
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
        store.valueChange = { _ in
            self.searchView.searchCityTableView.reloadData()
        }
        store.onError = { error in
            self.alert(message: error.localizedDescription, title: "ERROR")
        }
        store.loadCities()
    }
    
    //MARK: - Methods
    private func searchCityTableViewDelegate() {
        searchView.searchCityTableView.dataSource = self
        searchView.searchCityTableView.delegate = self
    }
    
    //MARK: SetUPNaviItem
    private func setupNavigationItem() {
        navigationItem.title = "Search City"
        //leftButton
        let leftButton = UIBarButtonItem(image: UIImage(named: "backButtonImage"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .orange
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SetupSearchController
    private func setupSearchController() {
        navigationItem.searchController = searchView.uiSearchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchView.uiSearchController.searchBar.searchBarStyle = .default
        searchView.uiSearchController.searchResultsUpdater = self
        self.searchView.uiSearchController.searchBar.sizeToFit()
        searchView.uiSearchController.searchBar.delegate = self
    }
    
    func urlSelected(city: String) -> URL {
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
        print("urlResult: \(urlResult)")
        return urlResult
    }
}

//MARK: - SearchBarDelegate
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print(searchBar.text)
        searchCityDelegate?.searchResult(city: searchBar.text!)
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController?.dismiss(animated: true, completion: nil)
        })
    }
}

//MARK: - TableViewDataSource
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = store.cities[indexPath.row].countryName
        return cell
    }
}

//MARK: - TableViewDelegate
extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchView.uiSearchController.isActive {
            let city = store.cities[indexPath.row].countryName
            searchCityDelegate?.searchResult(city: city)
            let presentingViewController = self.presentingViewController
            self.dismiss(animated: false, completion: {
                presentingViewController?.dismiss(animated: true, completion: nil)
            })
        } else {
            let city = store.cities[indexPath.row].countryName
            searchCityDelegate?.searchResult(city: city)
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        store.keyword = searchController.searchBar.text
    }
}

//MARK: - UIAlert
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
