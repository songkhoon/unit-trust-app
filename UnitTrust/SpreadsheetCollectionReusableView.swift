//
//  SpreadsheetCollectionReusableView.swift
//  UnitTrust
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import UIKit

class SpreadsheetCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var infoLabel: UILabel!
    
}

struct DecorationViewNames {
    static let topLeft = "SpreadsheetTopLeftDecorationView"
    static let topRight = "SpreadsheetTopRightDecorationView"
    static let bottomLeft = "SpreadsheetBottomLeftDecorationView"
    static let bottomRight = "SpreadsheetBottomRightDecorationView"
}

struct SupplementaryViewNames {
    static let left = "SpreadsheetLeftRowView"
    static let right = "SpreadsheetRightRowView"
    static let top = "SpreadsheetTopColumnView"
    static let bottom = "SpreadsheetBottomColumnView"
}
