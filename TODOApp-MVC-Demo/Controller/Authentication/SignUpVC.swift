//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    func check() -> Bool {
        guard  let userName = userNameTextField.text,
            !userName.isEmpty,
            let email = emailTextField.text,!email.isEmpty,
            let password = passTextField.text, !password.isEmpty,
            let age = ageTextField.text, !age.isEmpty
            else {return false}
        return true
    }
    
    
    func Empty() {
        switch  check() {
        case !userNameTextField.text!.isEmpty:
            AlertManager.alert(title: "Name", massage: "Please write your name", present: self, titleBtn: "Ok")
        case !emailTextField.text!.isEmpty:
            AlertManager.alert(title: "Email", massage: "Please write your email", present: self, titleBtn: "Ok")
        case !passTextField.text!.isEmpty:
            AlertManager.alert(title: "Password", massage: "Please write password", present: self, titleBtn: "Ok")
        case !ageTextField.text!.isEmpty:
            AlertManager.alert(title: "Age", massage: "Please write Age", present: self, titleBtn: "Ok")
            
        default:
            
            let s =  SignInVC.create()
            present(s, animated: true, completion: nil)
            
        }
    }
    
    func go(){
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    func saveUser(){
        APIManager.signUp(name: userNameTextField.text!,
                          email: emailTextField.text!,
                          password: passTextField.text!,
                          age: Int(ageTextField.text!)!){ (err, signUpData) in
                            if let err = err {
                                print(err.localizedDescription)
                            }
                            else if let data = signUpData {
                                print(data.user.age )
                            }
        }
    }
    
    func signUpPress(){
        if check() == true{
            if valid.isValidEmail(email: emailTextField.text!){
                if valid.isValidPassword(testStr: passTextField.text!){
                    
                    saveUser()
                    go()
                    
                }else {
                    AlertManager.alert(title: "Password",
                                       massage: "at least one uppercaseat least one digit , at least one lowercase ,8 characters total.",
                                       present: self, titleBtn: "Ok")
                }
            }else{
                AlertManager.alert(title: "Email",
                                   massage: "There’s some text before the @, There’s some text after the @, a There’s at least 2 alpha characters after a .",
                                   present: self, titleBtn: "Ok")
            }
        } else {
            Empty()
        }
    }
    @IBAction func signUpBtn(_ sender: Any) {
        signUpPress()
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        let su =  SignInVC.create()
        self.navigationController?.pushViewController(su, animated: true)
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication,
                                                         identifier: ViewControllers.signUpVC)
        return signUpVC
    }
}
