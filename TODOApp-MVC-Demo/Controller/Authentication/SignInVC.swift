//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
           navigationController?.isNavigationBarHidden = true
       
    }
    
    func go(){
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        self.view.showLoader()
        APIManager.login(with: emailTextField.text!, password: PassTextField.text!) { (error, loginData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let loginData = loginData {
                self.go()
                self.view.hideLoader()
                print(loginData.token)
                print(loginData.user)
                UserDefaultsManager.shared().token = loginData.token
            }
        }
        
    }
    @IBAction func signUpBtn(_ sender: Any) {
        let su =  SignUpVC.create()
    
        self.navigationController?.pushViewController(su, animated: true)
    }
    
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }
    
}
