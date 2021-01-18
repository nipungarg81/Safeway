//
//  HomeModel.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/16/21.
//

import Foundation

struct HomeModel {
    let title: String
    var description: String? = nil
    var ctaString: String? = nil
    var externalCta: HomeExternalModel? = nil
    var isImageDisplay: Bool = false
    
}

struct HomeExternalModel {
    let title: String?
    let urlString: String?
}
