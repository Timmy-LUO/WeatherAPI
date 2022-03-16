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
//    var cityData = [String]()
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
        
        //leftButton
        let leftButton = UIBarButtonItem(image: UIImage(named: "backButtonImage"), style: .plain, target: self, action: #selector(backButton))
        leftButton.tintColor = .green
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - setupSearchController
    private func setupSearchController() {
        navigationItem.searchController = searchView.uiSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchView.uiSearchController.searchBar.searchBarStyle =
          .prominent
        searchView.uiSearchController.searchResultsUpdater = self
        self.searchView.uiSearchController.searchBar.sizeToFit()
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
//            print("關鍵字 \(searchArr[indexPath.row])")
            let city = searchArr[indexPath.row]
            searchCityDelegate?.searchResult(city: city)
            print("關鍵字 \(city)")
            dismiss(animated: true, completion: nil)
        } else {
//            print("列表 \(cities[indexPath.row])")
            let city = cities[indexPath.row]
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
        
        searchArr = cities.filter { city -> Bool in
            return city.contains(searchText)
        }
    }
}
