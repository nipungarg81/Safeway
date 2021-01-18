//
//  HomeTableViewCell.swift
//  Safeway-Demo
//
//  Created by Nipun Garg on 1/16/21.
//

import UIKit

protocol CellDelegate {
    func didClickOnCellAtIndex(at index:IndexPath)
}

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var externalButton: UIButton!
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var shadowView: ShadowView!
    
    var delegate:CellDelegate!
    var indexPath:IndexPath!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        self.delegate?.didClickOnCellAtIndex(at: indexPath)
    }
}

class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
