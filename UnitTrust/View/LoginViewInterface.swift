//
//  LoginView.swift
//  Knapshot
//
//  Created by Jeff Lim on 30/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

class LoginViewInterface: UIView {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var inputStack: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    var textInputs: [UITextField] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textInputs.append(emailField)
        textInputs.append(passwordField)
        setupTextInput()
    }
    
    private func setupTextInput() {
        for input in textInputs {
            input.delegate = self
            input.spellCheckingType = .no
            input.autocorrectionType = .no
            if input == textInputs.last {
                input.returnKeyType = .done
            } else {
                input.returnKeyType = .next
            }
        }
    }
    
}

extension LoginViewInterface: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }
        if textField == textInputs.last {
            textField.resignFirstResponder()
            return true
        } else {
            if let index = textInputs.index(of: textField) {
                textInputs[index + 1].becomeFirstResponder()
            }
        }
        return false
    }
    
}
