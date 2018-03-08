//
//  LogoBackgroundView.swift
//  Knapshot
//
//  Created by Jeff Lim on 01/10/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

class LogoBackgroundView: UIView {

    let logo = UIImageView(image: #imageLiteral(resourceName: "logo-black"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    private func setupLayout() {
        let background = UIImageView(image: #imageLiteral(resourceName: "loading-background"))
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.layoutAttachAll()
        
//        logo.contentMode = .scaleAspectFit
//        addSubview(logo)
//        logo.translatesAutoresizingMaskIntoConstraints = false
//        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        logo.topAnchor.constraint(equalTo: topAnchor, constant: 120.0).isActive = true
    }
    
}
