//
//  ViewControllerExtension.swift
//  Knapshot
//
//  Created by jeff on 26/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addBackButton(title: String) {
        if let nav = navigationController {
            if let item = nav.navigationBar.topItem {
                item.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(self.backButtonHandler))
            } else if let _ = nav.navigationBar.backItem {
                nav.navigationBar.backItem?.title = title
            }
            nav.navigationBar.tintColor = .white
        }
    }
    
    @objc func backButtonHandler() {
        dismiss(animated: true, completion: nil)
    }
    
    func showLoading(title: String) -> UIView {
        let loadingView = LoadingView(frame: CGRect.zero, labelText: title)
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.layoutAttachAll()
        return loadingView
    }
    
    func createCardPanel() -> UIView {
        return view.createCardPanel()
    }
    
}

extension UINavigationController {
    
    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping () -> Void)
    {
        pushViewController(viewController, animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
    
}
