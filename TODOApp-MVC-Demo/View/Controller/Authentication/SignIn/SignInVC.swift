//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInVC: UIViewController{
    
 // MARK:- OutLet methods
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet var signInView: SignInView!
    var presenter: SignInPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
         
      navigationController?.isNavigationBarHidden = true
        signInView.setUp()
    }
    // MARK:- methods
     func go(){
        let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    func showLaoder(){
         self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    func setupNev(){
          navigationController?.isNavigationBarHidden = true
    }
    func presentError(massage: String){
        AlertManager.alert(title: "Error", massage: massage, present: self, titleBtn: "OK")
    }
    
    // MARK:- Button Methods
    @IBAction func logInBtn(_ sender: Any) {
        presenter.tryToLogin(email: emailTextField.text!, password: PassTextField.text!)
      
}
   
    @IBAction func signUpBtn(_ sender: Any) {
        let su =  SignUpVC.create()
        
        self.navigationController?.pushViewController(su, animated: true)
    }
    
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.presenter = SignInPresenter(view: signInVC)
        return signInVC
    }
    
}
