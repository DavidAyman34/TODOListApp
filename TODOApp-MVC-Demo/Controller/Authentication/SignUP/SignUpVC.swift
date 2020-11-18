//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    // MARK:- OutLet methods
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    
    var presenter: SignUpPresenter!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Methods
    func showLoader(){
         self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    func presentError(massage: String){
        AlertManager.alert(title: "Error", massage: massage, present: self, titleBtn: "OK")
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

   
    
  // MARK:- Button methods
    @IBAction func signUpBtn(_ sender: Any) {
        presenter.tryToSaveUser(name: userNameTextField.text!, email: emailTextField.text!, password: passTextField.text!, age: ageTextField.text!)
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        let su =  SignInVC.create()
        self.navigationController?.pushViewController(su, animated: true)
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication,
                                                         identifier: ViewControllers.signUpVC)
        signUpVC.presenter = SignUpPresenter(view: signUpVC)
        return signUpVC
    }
}
