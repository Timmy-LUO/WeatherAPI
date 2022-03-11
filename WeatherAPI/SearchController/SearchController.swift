//
//  SearchController.swift
//  WeatherAPI
//
//  Created by 羅承志 on 2022/3/9.
//

import UIKit

class SearchController: UIViewController {
    
    //MARK: - Properties
    private let searchView = SearchView()
    
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCityTableViewDelegate()
        setupNavigationItem()
        
    }
    
    //MARK: - Methods
    private func searchCityTableViewDelegate() {
        searchView.searchCityTableView.dataSource = self
        searchView.searchCityTableView.delegate = self
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Search City"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let backButton = UIBarButtonItem(image: UIImage(named: "backButtonImage"), style: .plain, target: self, action: #selector(backButton))
        backButton.tintColor = .green
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButton() {
        dismiss(animated: true, completion: nil)
    }

    
}

//MARK: - TableViewDataSource
extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        
        
        
        return cell
    }
}

//MARK: - TableViewDelegate
extension SearchController: UITableViewDelegate {
    
}
