//
//  SearchRecipeViewController.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/14/21.
//

import UIKit
import SDWebImage

class SearchRecipeViewController: UIViewController {

    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
    
    @IBOutlet weak var tableView: UITableView!
    
    private let networkService = AppNetworkService()
    private let sc = UISearchController(searchResultsController: nil)
    private var recipies = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchbarController()
        setNavigationItem()
        setupTableView()
    }
}

//MARK: UITableViewDatasource
extension SearchRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceipeCellIdentifier", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = recipies[indexPath.row].title
        cell.ingredientLablel.text = recipies[indexPath.row].ingredients
        cell.thumbnail.sd_setImage(with: URL(string: recipies[indexPath.row].thumbnail ?? ""), placeholderImage: UIImage(systemName: "photo"))
        return cell
    }
}

//MARK: UITableViewDelegate
extension SearchRecipeViewController: UITableViewDelegate {
    
}

//MARK: SearchController
extension SearchRecipeViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.loadData(_:)), object: searchBar)
        perform(#selector(self.loadData(_:)), with: searchBar, afterDelay: 0.75)
    }
}

//MARK: Private
extension SearchRecipeViewController {
    @objc private func loadData(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            networkService.loadRecipes(for: searchText) { (recipies, error) in
                guard let recipies = recipies else { return }
                self.recipies = recipies
                self.tableView.reloadData()
            }
        } else {
//            self.recipies = []
//            self.tableView.reloadData()
        }
    }
    
    private func setNavigationItem() {
        let imageView = UIImageView(image: UIImage(systemName: "cart"))
        imageView.tintColor = .white
        let item = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItem = item
        self.navigationController?.navigationBar.tintColor = .white
    }

    private func setupTableView() {
        let cellNib = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ReceipeCellIdentifier")
    }
    
    private func setupSearchbarController(){
        if #available(iOS 11.0, *) {
            sc.delegate = self
            sc.searchResultsUpdater = self
            let scb = sc.searchBar
            scb.tintColor = .white
            scb.barTintColor = .white

            if let textfield = scb.value(forKey: "searchField") as? UITextField {
                textfield.textColor = .white
                textfield.backgroundColor = .white
                if let backgroundview = textfield.subviews.first {

                    // Background color
                    backgroundview.backgroundColor = .white

                    // Rounded corner
                    backgroundview.layer.cornerRadius = 10;
                    backgroundview.clipsToBounds = true;
                }
            }

            if let navigationbar = self.navigationController?.navigationBar {
                navigationbar.barTintColor = UIColor(named: "Header")
            }
            navigationItem.searchController = sc
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
}
