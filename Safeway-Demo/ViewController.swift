//
//  ViewController.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/14/21.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        AppNetworkService().loadRecipes(for: "onion") { (receipes, error) in
            guard let receipes = receipes else {
                return
            }
            print(receipes.count)
        }
    }


}

