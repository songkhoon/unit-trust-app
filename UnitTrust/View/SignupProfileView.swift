//
//  SignupProfileView.swift
//  Knapshot
//
//  Created by Jeff Lim on 30/09/2017.
//  Copyright © 2017 jeff. All rights reserved.
//

import UIKit

class SignupProfileView: UIView {
    
    @IBOutlet weak var firstName: UITextField?
    @IBOutlet weak var lastName: UITextField?
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var profileEditButton: UIButton!
    
    var userImage: UIImageView = UIImageView()
    var textInputs: [UITextField] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.frame = profileView.frame
        userImage.layer.cornerRadius = profileView.frame.width / 2.0
        userImage.layer.masksToBounds = true
        userImage.layer.borderColor = UIColor.orange.cgColor
        userImage.layer.borderWidth = 1.0
        userImage.contentMode = .scaleAspectFill
        userImage.backgroundColor = .clear
        profileView.superview?.insertSubview(userImage, aboveSubview: profileView)
        
        textInputs = []
        textInputs.append(firstName!)
        textInputs.append(lastName!)
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

extension SignupProfileView: UITextFieldDelegate {
    
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
