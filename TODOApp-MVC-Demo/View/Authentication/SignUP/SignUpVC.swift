//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol SignUpProtocols: class{
    func showLoader()
    func hideLoader()
    func presentError(massage: String)
    func switchToMainState()
    func Empty()
    func check() -> Bool
}

class SignUpVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet var signUpView: SignUpView!
    
    // MARK: - Properties
    var viewModel: SignUpViewModel!
    weak var delegate: AuthNavigationDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        signUpView.setup()
    }
    
    // MARK:- Button Methods
    @IBAction func signUpBtn(_ sender: Any) {
        viewModel.tryToSaveUser(name: userNameTextField.text!, email: emailTextField.text!, password: passTextField.text!, age: ageTextField.text!)
        
    }
    @IBAction func signInBtn(_ sender: Any) {
        let signIn =  SignInVC.create()
        self.navigationController?.pushViewController(signIn, animated: true)
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication,identifier: ViewControllers.signUpVC)
        signUpVC.viewModel = SignUpViewModel(view: signUpVC)
        return signUpVC
    }
}

// MARK: - Implement Protocols
extension SignUpVC: SignUpProtocols{
    
    func showLoader() {
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
            let signIn =  SignInVC.create()
            present(signIn, animated: true, completion: nil)
            
        }
    }
}
