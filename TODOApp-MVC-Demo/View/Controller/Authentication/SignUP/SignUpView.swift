//
//  SignUpView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    func setup(){
        setupTextField(userNameTextField, placeHolder: "UserName")
        setupTextField(emailTextField, placeHolder: "Email")
        setupTextField(passTextField, placeHolder: "Password",isSceure: true)
        setupTextField(emailTextField, placeHolder: "Age")
        setupSignInBtn()
        setupSignUpBtn()
        setupImg(named: "background 2")
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String, isSceure: Bool = false, isPhone: Bool = false){
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.placeholder = placeHolder
        textField.isSecureTextEntry = isSceure
        
        if isPhone {
            textField.keyboardType = .asciiCapableNumberPad
        }
    }
    
    private func setupSignUpBtn(){
        signUpBtn.layer.borderColor = #colorLiteral(red: 0.3843137255, green: 0.1215686275, blue: 0.4862745098, alpha: 1)
        signUpBtn.titleLabel?.textColor = .white
        signUpBtn.layer.cornerRadius = signUpBtn.frame.height/2
        signUpBtn.setTitle("Sign Up", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize: 20)
    }
    private func setupSignInBtn(){
        signInBtn.titleLabel?.textColor = .white
        signInBtn.layer.cornerRadius = signInBtn.frame.height/2
        signInBtn.setTitle("Sign In", for: .normal)
        signInBtn.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private func setupImg(named: String){
        backImg.image = UIImage(named: named)
        backImg.contentMode = .scaleAspectFit
        
    }
    
    
}
