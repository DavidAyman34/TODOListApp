//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

   // MARK:- Protocols
protocol AuthNavigationDelegate: class {
    func showMainState()
}

protocol SignInVCProtocol: class{
    func showLoader()
    func hideLoader()
    func presentError(massage: String)
    func switchToMainState()
}

class SignInVC: UIViewController{
    
    // MARK:- OutLet methods
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PassTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet var signInView: SignInView!
    
    // MARK: - Properties
    var viewModel: SignInViewModelProtocols!
    weak var delegate: AuthNavigationDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupNev()
        signInView.setUp()
    }
    
    func setupNev(){
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK:- Button Methods
    @IBAction func logInBtn(_ sender: Any) {
        viewModel.tryToLogin(email: emailTextField.text ?? "s", password: PassTextField.text ?? "s")
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let signUp =  SignUpVC.create()
        
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        
        signInVC.viewModel = SignInViewModel(view: signInVC) 
        return signInVC
    }
    
}

 // MARK: - Implement Protocols
extension SignInVC: SignInVCProtocol{
    func showLoader(){
        self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    
    
    func presentError(massage: String){
        AlertManager.alert(title: "Error", massage: massage, present: self, titleBtn: "OK")
    }
    
    func switchToMainState(){
        self.delegate?.showMainState()
    }
    
    
    
}
