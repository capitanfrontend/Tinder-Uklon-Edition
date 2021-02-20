//
//  ListAssessmentsItem.swift
//  ARCoreLocationExample
//
//  Created by Skyler Smith on 2019-01-02.
//  Copyright (c) 2019 Freshworks Studio Inc.. All rights reserved.
//

import UIKit

class ListLandmarksItem: UIView {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        backgroundColor = UIColor.white.withAlphaComponent(0.85)
    }
    
    func set(address: String, amount: String) {
        addressLabel.text = address
        amountLabel.text = amount
        layoutIfNeeded()
    }
}

extension ListLandmarksItem {
    class func fromNib(named: String? = nil) -> Self {
            let name = named ?? "\(Self.self)"
            guard
                let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
                else { fatalError("missing expected nib named: \(name)") }
            guard
                /// we're using `first` here because compact map chokes compiler on
                /// optimized release, so you can't use two views in one nib if you wanted to
                /// and are now looking at this
                let view = nib.first as? Self
                else { fatalError("view of type \(Self.self) not found in \(nib)") }
            return view
        }
}
