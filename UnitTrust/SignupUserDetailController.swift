//
//  SignupUserDetailController.swift
//  Knapshot
//
//  Created by Jeff Lim on 30/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

class SignupUserDetailController: UIViewController {
    
    fileprivate var signupView: SignupProfileView = UIView.fromNib()
    let logoBackground = LogoBackgroundView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        addBackButton(title: "Back")
        title = "Your Details"
        
        let doneBar = UIBarButtonItem(image: #imageLiteral(resourceName: "check_white"), style: .done, target: self, action: #selector(doneHandler))
        navigationItem.rightBarButtonItem = doneBar
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func setupLayout() {
        signupView.profileEditButton.addTarget(self, action: #selector(profileEditHandler), for: .touchUpInside)
        view.addSubview(signupView)
        signupView.translatesAutoresizingMaskIntoConstraints = false
        signupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        signupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        signupView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
        signupView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
    }
    
    // Done button on right navigation item, update user detail
    @objc
    private func doneHandler() {
        showContinue()
    }
    
    private func showContinue() {
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logoBackground)
        logoBackground.translatesAutoresizingMaskIntoConstraints = false
        logoBackground.layoutAttachAll()
        view.addSubview(logoBackground)
        logoBackground.translatesAutoresizingMaskIntoConstraints = false
        logoBackground.layoutAttachAll()
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.text = "Thank you for signing up"
        titleLabel.textAlignment = .center
        logoBackground.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.layoutAttachTop(to: logoBackground.logo, margin: 100)
        titleLabel.layoutAttachLeading()
        titleLabel.layoutAttachTrailing()
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.text = "A verification email has been send to you.\rPlease verify and see you inside."
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = .gray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        logoBackground.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.layoutAttachTop(to: titleLabel, margin: 10)
        messageLabel.layoutAttachLeading(to: logoBackground, margin: 30)
        messageLabel.layoutAttachTrailing(to: logoBackground, margin: 30)
        
        let continueButton = UIButton(frame: CGRect.zero)
        continueButton.backgroundColor = .orange
        continueButton.setTitle("CONTINUE TO KNAPSHOT", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.layer.cornerRadius = 5
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        continueButton.addTarget(self, action: #selector(continueHandler), for: .touchUpInside)
        logoBackground.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.layoutAttachLeading(to: logoBackground, margin: 30)
        continueButton.layoutAttachTrailing(to: logoBackground, margin: 30)
        continueButton.layoutAttachBottom(to: logoBackground, margin: 20)
        continueButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    @objc
    private func profileEditHandler() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc
    private func continueHandler() {
        navigationController?.setViewControllers([LandingViewController(), LoginViewController()], animated: true)
    }
    
}

extension SignupUserDetailController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            signupView.userImage.image = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            signupView.userImage.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
