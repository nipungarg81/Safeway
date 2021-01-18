//
//  ServiceViewController.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/14/21.
//

import UIKit

class ServiceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var mapViewModel: MapViewModel?
    let homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        mapViewModel = MapViewModel(screenSize: UIScreen.main.bounds)
        mapViewModel?.getNearestAddress(of: "Safeway", with: { location in
            DispatchQueue.main.async {
                self.addressLabel.text = location
            }
        })
        let tap = UITapGestureRecognizer(target: self, action: #selector(ServiceViewController.tapFunction))
        addressLabel.isUserInteractionEnabled = true
        addressLabel.addGestureRecognizer(tap)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let mapViewModel = mapViewModel else {
            return
        }
        if !mapViewModel.isLocationServiceEnabled() {
            if let BUNDLE_IDENTIFIER = Bundle.main.bundleIdentifier,
                let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(BUNDLE_IDENTIFIER)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

//MARK: Cell Click Delegare
extension ServiceViewController: CellDelegate {
    func didClickOnCellAtIndex(at index: IndexPath) {
        let homeItem = homeViewModel.homeCollection[index.row]
        if let externalURL =  homeItem.externalCta {
            if let urlString = externalURL.urlString, let url = URL(string: urlString) {                    UIApplication.shared.open(url)
            }
        }
        if homeItem.ctaString != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchRecipeViewController")
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
}

//MARK: UITableViewDatasource
extension ServiceViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.homeCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellIdentifier", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cell.indexPath = indexPath
        cell.delegate = self
        cell.backgroundColor = .clear
        let homeItem = homeViewModel.homeCollection[indexPath.row]
        cell.titleLabel.text = homeItem.title
        cell.cellImageView.isHidden = !homeItem.isImageDisplay
        
        if let ctaString = homeItem.ctaString {
            cell.ctaButton.isHidden = false
            cell.ctaButton.setTitle(ctaString, for: .normal) 
        }
        
        if let externalCta = homeItem.externalCta {
            cell.externalButton.isHidden = false
            cell.externalButton.setTitle(externalCta.title, for: .normal)
        }
        
        if let description = homeItem.description {
            cell.descriptionLabel.isHidden = false
            cell.descriptionLabel.text = description
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
   
}

//MARK: UITableViewDelegate
extension ServiceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let heasderView = Bundle.main.loadNibNamed("HomeHeaderView", owner: self, options: nil)?.first as? UIView
        return heasderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
}

//MARK: Private
extension ServiceViewController {
    
    private func setupTableView() {
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "HomeCellIdentifier")
    }
}
