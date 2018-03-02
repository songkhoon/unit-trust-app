//
//  LoginViewController.swift
//  Knapshot
//
//  Created by jeff on 17/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import Foundation
import UIKit
import IHKeyboardAvoiding

class LoginViewController: UIViewController {
    
    let loginView: LoginViewInterface = UIView.fromNib()
    var loadingView: UIView?
    private let userManager = UserManager.instance
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        addBackButton(title: "Back")
        title = "Sign In With Email"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        setupLayout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupLayout() {
        loginView.forgotPasswordButton.addTarget(self, action: #selector(resetPasswordHandler), for: .touchUpInside)
        loginView.signInButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loginView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        KeyboardAvoiding.avoidingView = loginView.inputStack
        KeyboardAvoiding.paddingForCurrentAvoidingView = 10
    }
    
    @objc
    private func loginHandler() {
        view.endEditing(true)
        loadingView = showLoading(title: "Signing in...")
        if userManager.debugMode {
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerHandler), userInfo: nil, repeats: false)
        } else {
            if let email = loginView.emailField.text, let password = loginView.passwordField.text {
            }
        }
    }
    
    @objc
    private func timerHandler() {
        navigationController?.navigationBar.isHidden = false
        loadingView?.removeFromSuperview()
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func resetPasswordHandler() {
        let controller = ForgotPasswordController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc
    private func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                // keyboard hide
                loginView.logo.isHidden = false
            } else {
                // keyboard show
                loginView.logo.isHidden = true
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
}
