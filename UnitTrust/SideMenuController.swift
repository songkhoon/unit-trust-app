//
//  SideMenuController.swift
//  Knapshot
//
//  Created by Jeff Lim on 08/10/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

protocol SideMenuControllerDelegate {
    
    func sideMenuDisappear(disappear: Bool)
    func showPersonProfile()
    func showCompanyProfile()
    func showAnnouncement()
    func showInvitation()
    func showHelp()
    func showSetting()
    func signout()
    
}

class SideMenuController: UIViewController {
    
    var delegate: SideMenuControllerDelegate?
    let userManager = UserManager.instance
    var bSignout: UIButton!
    
    lazy var bPersonalProfile: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "personal-profile32x32"), title: "Personal Profile")
    }()
    
    lazy var bCompanyProfile: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "company-profile32x32"), title: "Company Profile")
    }()
    
    lazy var bAnnouncement: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "announcement32x32"), title: "Announcement")
    }()
    
    lazy var bInviteFriends: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "invite-friends32x32"), title: "Invite Friends")
    }()
    
    lazy var bHelp: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "help32x32"), title: "Help")
    }()
    
    lazy var bSetting: UIButton = {
        return self.createButton(image: #imageLiteral(resourceName: "setting32x32"), title: "Setting")
    }()
    
    var signoutAlert: UIAlertController {
        let controller = UIAlertController(title: "Alert", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let signout = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
            self.delegate?.signout()
        }
        controller.addAction(cancel)
        controller.addAction(signout)
        return controller
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    let userImage: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .red
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    let userName: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15.0)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "User Name"
        return view
    }()
    
    let userCompany: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 13.0)
        view.textColor = .white
        view.textAlignment = .center
        view.text = "User Compant Name"
        return view
    }()
    
    // MARK:- UIViewController
    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.sideMenuDisappear(disappear: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    // MARK:- Setup Layout
    private func setupLayout() {
        let buttonStack = UIStackView()
        buttonStack.alignment = .leading
        buttonStack.axis = .vertical
        buttonStack.distribution = .fill
        buttonStack.spacing = 10
        bPersonalProfile.addTarget(self, action: #selector(personalProfileHandler), for: .touchUpInside)
        bCompanyProfile.addTarget(self, action: #selector(companyProfileHandler), for: .touchUpInside)
        bAnnouncement.addTarget(self, action: #selector(announcementHandler), for: .touchUpInside)
        bInviteFriends.addTarget(self, action: #selector(invitationHandler), for: .touchUpInside)
        bSetting.addTarget(self, action: #selector(helpHandler), for: .touchUpInside)
        bSetting.addTarget(self, action: #selector(settingHandler), for: .touchUpInside)
        buttonStack.addArrangedSubview(bPersonalProfile)
        buttonStack.addArrangedSubview(bCompanyProfile)
        buttonStack.addArrangedSubview(bAnnouncement)
        buttonStack.addArrangedSubview(bInviteFriends)
        buttonStack.addArrangedSubview(bHelp)
        buttonStack.addArrangedSubview(bSetting)
        view.addSubview(buttonStack)
        let leftPadding: CGFloat = 80.0
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bSignout = createButton(image: #imageLiteral(resourceName: "sign-out32x32"), title: "Sign Out")
        bSignout.addTarget(self, action: #selector(signoutHandler), for: .touchUpInside)
        view.addSubview(bSignout)
        bSignout.translatesAutoresizingMaskIntoConstraints = false
        bSignout.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftPadding).isActive = true
        bSignout.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bSignout.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    func createButton(image: UIImage, title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        let img = UIImageView(image: image)
        img.contentMode = .scaleAspectFit
        button.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: button.titleLabel!.leadingAnchor, constant: -20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }
    
    // MARK:- Handlers
    @objc
    private func signoutHandler() {
        present(signoutAlert, animated: true, completion: nil)
    }
    
    @objc
    private func personalProfileHandler() {
        delegate?.showPersonProfile()
    }
    
    @objc
    private func companyProfileHandler() {
        delegate?.showCompanyProfile()
    }
    
    @objc
    private func announcementHandler() {
        delegate?.showAnnouncement()
    }
    
    @objc
    private func invitationHandler() {
        delegate?.showInvitation()
    }
    
    @objc
    private func helpHandler() {
        delegate?.showHelp()
    }
    
    @objc
    private func settingHandler() {
        delegate?.showSetting()
    }
    
}

