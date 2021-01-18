//
//  HomeViewModel.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/16/21.
//

import Foundation

struct HomeViewModel {
    var homeCollection = [HomeModel]()
    
    init() {
        let item1 = HomeModel(title: "Deliver & Pick Up",
                              description: "Schedule grocery delivery or pick up at the nearest store.",
                              externalCta: HomeExternalModel(title: "Get the App",
                                                             urlString: "https://apps.apple.com/us/app/safeway-delivery-pick-up/id687460321"),
                              isImageDisplay: true)
        homeCollection.append(item1)
        
        let item2 = HomeModel(title: "Search New Receipes",
                              ctaString: "Find It")
        
        homeCollection.append(item2)
    }
}
