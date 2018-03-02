//
//  LoadingView.swift
//  Knapshot
//
//  Created by Jeff Lim on 01/10/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    let logoBackground = LogoBackgroundView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackground()
    }
    
    init(frame: CGRect, labelText: String) {
        super.init(frame: frame)
        setupBackground()
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .whiteLarge
        loadingIndicator.color = .orange
        addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = labelText
        label.textColor = .orange
        label.textAlignment = .center
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 30).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupBackground() {
        addSubview(logoBackground)
        logoBackground.translatesAutoresizingMaskIntoConstraints = false
        logoBackground.layoutAttachAll()
    }
    
}
