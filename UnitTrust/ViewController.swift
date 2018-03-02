//
//  ViewController.swift
//  UnitTrust
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backgroundViews:[UIViewController] = []
    private var backgroundTimer: Timer?
    
    fileprivate let headTitles = [
        "Welcome to RBS",
        "Welcome to RBS",
        "Welcome to RBS",
        "Welcome to RBS",
        "Welcome to RBS",
        "Welcome to RBS"
    ]
    fileprivate let subTitles = [
        "We specializes in the development and delivery of application to meet the information technology needs of various industries.",
        "We are committed to deliver top quality information systems products and services.",
        "We are committed to deliver top quality information systems products and services.",
        "We are committed to deliver top quality information systems products and services.",
        "We are committed to deliver top quality information systems products and services.",
        "We are committed to deliver top quality information systems products and services."
    ]
    
    let backgroundViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let titleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 28)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    let subTitleView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .gray
        return view
    }()
    
    let buttonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let pagingView: UIView = {
        let view = UIView()
        return view
    }()
    
    let pageController: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.tintColor = .orange
        view.pageIndicatorTintColor = .white
        view.currentPageIndicatorTintColor = .orange
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        automaticallyAdjustsScrollViewInsets = false
        
        navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        setupBackgroundView()
        setupLandingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        backgroundTimer?.invalidate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    private func setupBackgroundView() {
        addChildViewController(backgroundViewController);
        view.addSubview(backgroundViewController.view)
        backgroundViewController.view.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        var backgrounds: [UIImage] = []
        backgrounds.append(#imageLiteral(resourceName: "bg-img-1"))
        backgrounds.append(#imageLiteral(resourceName: "bg-img-2"))
        backgrounds.append(#imageLiteral(resourceName: "bg-img-3"))
        backgrounds.append(#imageLiteral(resourceName: "bg-img-4"))
        backgrounds.append(#imageLiteral(resourceName: "bg-img-5"))
        backgrounds.append(#imageLiteral(resourceName: "bg-img-6"))
        
        for i in 0..<backgrounds.count {
            let vc = UIViewController()
            let img = UIImageView(image: backgrounds[i])
            img.frame = view.frame
            
            vc.view.addSubview(img)
            vc.view.frame.size = view.frame.size
            backgroundViews.append(vc)
        }
        backgroundViewController.dataSource = self
        backgroundViewController.delegate = self
        backgroundViewController.setViewControllers([backgroundViews.first!], direction: .forward, animated: true, completion: nil)
    }
    
    fileprivate func setupTimer() {
        backgroundTimer?.invalidate()
        backgroundTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(backgroundTimerHandler), userInfo: nil, repeats: true)
    }
    
    @objc
    func backgroundTimerHandler() {
        var index = backgroundViews.index(of: backgroundViewController.viewControllers![0])! + 1
        if index == backgroundViews.count {
            index = 0
        }
        backgroundViewController.setViewControllers([backgroundViews[index]], direction: .forward, animated: true, completion: nil)
        pageController.currentPage = index
        updatePageView(index: index)
    }
    
    private func setupLandingView() {
        view.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 25).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleView.text = headTitles[0]
        view.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 35).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        subTitleView.text = subTitles[0]
        view.addSubview(subTitleView)
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        subTitleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subTitleView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        
        let guestButton = createButton(.orange, "USE AS GUEST")
        guestButton.addTarget(self, action: #selector(guestHandler), for: .touchUpInside)
        
        let iconSize: CGFloat = 18.0
        let emailButton = createButton(UIColor(r: 51, g: 51, b: 51), "SIGN IN WITH EMAIL")
        let emailIcon = UIImageView(image: #imageLiteral(resourceName: "email"))
        emailButton.addSubview(emailIcon)
        emailIcon.translatesAutoresizingMaskIntoConstraints = false
        emailIcon.leadingAnchor.constraint(equalTo: emailButton.leadingAnchor, constant: 20).isActive = true
        emailIcon.centerYAnchor.constraint(equalTo: emailButton.centerYAnchor).isActive = true
        emailIcon.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        emailIcon.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        emailButton.addTarget(self, action: #selector(emailHandler), for: .touchUpInside)
        
        let stackView:UIStackView = UIStackView()
        stackView.addArrangedSubview(guestButton)
        stackView.addArrangedSubview(emailButton)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        buttonContainer.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor).isActive = true
        
        // Button Container Constraint
        view.addSubview(buttonContainer);
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -80).isActive = true
        buttonContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        buttonContainer.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        let signupButton:UIButton = UIButton()
        let signupText = "Not a member? Sign Up"
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        signupButton.titleLabel?.attributedText = NSAttributedString(string: signupText, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        signupButton.setTitle(signupText, for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.titleLabel?.textAlignment = .center
        signupButton.addTarget(self, action: #selector(signupHandler), for: .touchUpInside)
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 5).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pageController.numberOfPages = headTitles.count
        view.addSubview(pageController)
        pageController.translatesAutoresizingMaskIntoConstraints = false
        pageController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageController.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 10).isActive = true
        pageController.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        pageController.heightAnchor.constraint(equalToConstant: 10).isActive = true
        updatePageView(index: 0)
    }
    
    private func createButton(_ color: UIColor, _ title: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    @objc
    private func guestHandler() {
        
    }
    
    @objc
    private func linkedInHandler() {
        
    }
    
    @objc
    private func emailHandler() {
        slideFromRight()
        if let navController = navigationController {
            navController.pushViewController(LoginViewController(), animated: true)
        }
    }
    
    @objc
    private func signupHandler() {
        slideFromRight()
    }
    
    private func slideFromRight() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
    }
    
    fileprivate func updatePageView(index: Int) {
        titleView.text = headTitles[index]
        subTitleView.text = subTitles[index]
        if index % 2 == 0 {
            // event page num
            titleView.textColor = .black
            subTitleView.textColor = .gray
        } else {
            // old page num
            titleView.textColor = .white
            subTitleView.textColor = .white
        }
    }

}

extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = backgroundViews.index(of: viewController) else { return nil }
        updatePageView(index: index)
        
        let previousIndex = index - 1
        if previousIndex < 0 {
            return backgroundViews.last
        } else {
            return backgroundViews[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = backgroundViews.index(of: viewController) else { return nil }
        updatePageView(index: index)
        
        let nextIndex = index + 1
        if nextIndex >= backgroundViews.count {
            return backgroundViews.first
        } else {
            return backgroundViews[nextIndex]
        }
    }

}

extension ViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageController.currentPage = backgroundViews.index(of: pageViewController.viewControllers![0])!
        setupTimer()
    }

}
