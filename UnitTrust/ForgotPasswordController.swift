//
//  ForgotPasswordController.swift
//  Knapshot
//
//  Created by Jeff Lim on 17/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordController: UIViewController {

    let forgotPasswordView: ForgotPasswordView = UIView.fromNib()
    var loadingView: UIView?
    
    fileprivate let emailInput: UITextField = {
        let view = UITextField()
        return view
    }()
    
    var resetBarItem: UIBarButtonItem {
        let view = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetPasswordHandler))
        view.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)], for: .normal)
        return view
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Fotget Password"
        addBackButton(title: "Back")
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = resetBarItem

        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(forgotPasswordView)
        forgotPasswordView.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        forgotPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        forgotPasswordView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        forgotPasswordView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    @objc
    private func resetPasswordHandler() {
        view.endEditing(true)
        navigationController?.navigationBar.isHidden = true
        loadingView = showLoading(title: "Signing in...")
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: false)
    }
    
    @objc
    private func timerHandler() {
        navigationController?.navigationBar.isHidden = false
        loadingView?.removeFromSuperview()
        dismiss(animated: true, completion: nil)
    }
    
}
