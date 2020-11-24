//
//  SignInView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/22/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInView: UIView {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var backImg: UIImageView!
    
    func setUp(){
        setupTextField(emailTextField, placeHolder: "Email")
        setupTextField(PassTextField, placeHolder: "Password",isSceure: true)
        setupLoginBtn()
        setupSignUpBtn()
        setupImg(named: "background 2")
        
    }
    
    private func setupImg(named: String){
        backImg.image = UIImage(named: named)
        backImg.contentMode = .scaleAspectFit
        
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
    //    UIColor(red: 98, green: 31, blue: 124, alpha: 2
    //    )
    private func setupLoginBtn(){
        logInBtn.layer.borderColor = #colorLiteral(red: 0.3843137255, green: 0.1215686275, blue: 0.4862745098, alpha: 1)
        logInBtn.titleLabel?.textColor = .white
        logInBtn.layer.cornerRadius = logInBtn.frame.height/2
        logInBtn.setTitle("Log In", for: .normal)
        logInBtn.titleLabel?.font = .systemFont(ofSize: 20)
    }
    private func setupSignUpBtn(){
        signUpBtn.titleLabel?.textColor = .white
        signUpBtn.layer.cornerRadius = signUpBtn.frame.height/2
        signUpBtn.setTitle("Create Account", for: .normal)
        signUpBtn.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    
}


