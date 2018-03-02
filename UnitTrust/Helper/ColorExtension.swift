//
//  ColorExtension.swift
//  Knapshot
//
//  Created by Jeff Lim on 26/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    static var navigationBarColor: UIColor {
        return UIColor(r: 255, g: 110, b: 0)
    }
    
    static var tableDefaultColor: UIColor {
        return UIColor(r: 247, g: 247, b: 247)
    }
    
    static var tableSeparatorColor: UIColor {
        return UIColor(r: 227, g: 227, b: 227)
    }
    
}
