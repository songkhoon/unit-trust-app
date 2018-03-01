//
//  ViewController.swift
//  UnitTrust
//
//  Created by Jeff on 01/03/2018.
//  Copyright © 2018 Jeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
//        navigationController?.pushViewController(LandingViewController(), animated: false)
        present(LandingViewController(), animated: false) {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


