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
    private let searchView = SearchView()
    weak var searchCityDelegate: SearchResult?
    var searchData = [City]()
    var searchArr: [City] = [] {
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
        setupCitySearch()
//        searchView.searchCityTableView.reloadData()
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
        
        //leftButton
        let leftButton = UIBarButtonItem(image: UIImage(named: "backButtonImage"),
                                         style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .green
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - setupSearchController
    private func setupSearchController() {
        navigationItem.searchController = searchView.uiSearchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchView.uiSearchController.searchBar.searchBarStyle = .prominent
        searchView.uiSearchController.searchResultsUpdater = self
        self.searchView.uiSearchController.searchBar.sizeToFit()
    }
    
    //MARK: - SetupCitySearch
    func setupCitySearch() {
        let headers = ["Authorization": APIKeys.cityAPIKey, "Accept": "application/json"]

        var request = URLRequest(url: URL(string: "https://www.universal-tutorial.com/api/countries/")!,
                                 cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let error = error {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse,let data = data {
                print("City Status Code: \(httpResponse.statusCode)")
                let decoder = JSONDecoder()
                if let cityData = try? decoder.decode(CityAPI.self, from: data) {
                    self.searchData = cityData
//                    print("searchData: \(self.searchData.count)")
                }
            }
        })
        dataTask.resume()
    }
}

//MARK: - TableViewDataSource
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchView.uiSearchController.isActive) {
//            print("isActive")
            return searchArr.count
        } else {
//            print("searchData")
            return searchData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        if (searchView.uiSearchController.isActive) {
            cell.textLabel?.text = searchArr[indexPath.row].countryName
        } else {
            cell.textLabel?.text = searchData[indexPath.row].countryName
        }
        
        return cell
    }
}

//MARK: - TableViewDelegate
extension SearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchArr[indexPath.row].countryName
        if (searchView.uiSearchController.isActive) {
            searchCityDelegate?.searchResult(city: city)
            print("關鍵字 \(city)")
            dismiss(animated: true, completion: nil)
        } else {
            searchCityDelegate?.searchResult(city: city)
            print("列表 \(city)")
            dismiss(animated: true, completion: nil)
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
        
        searchArr = searchData.filter { city -> Bool in
            city.countryName.lowercased()
                .contains(searchText.lowercased())
//            return city.contains(searchText)
        }
    }
}
