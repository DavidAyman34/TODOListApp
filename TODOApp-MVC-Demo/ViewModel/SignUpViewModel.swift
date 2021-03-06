//
//  SignUpPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

protocol SignUpViewModelProtocols {
     func tryToSaveUser(name: String, email: String, password: String,age: String)
}
    
class SignUpViewModel {
    
    weak var view: SignUpProtocols!
    
    // MARK:- Initialization Methods
    init(view: SignUpProtocols) {
        self.view = view
    }
    
    // MARK:- Private Methods
    private func validteFields(email: String?, password: String?) -> Bool{
        if !validator.shared().isValidEmail(email: email){
            self.view.presentError(massage: "Plase Enter an Email")
            return false
        }
        if !validator.shared().isValidPassword(testStr: password){
            self.view.presentError(massage: "Password Must be at least 8 Characters")
            return false
            
        }
        return true
    }
    


    private func saveUser(name: String, email: String, password: String,age: String){
        self.view.showLoader()
        APIManager.signUp(name: name, email: email, password: password, age: Int(age)!){ (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                self.view.switchToMainState()
            }
            self.view.hideLoader()
        }
    }
}
extension SignUpViewModel: SignUpViewModelProtocols{
    func tryToSaveUser(name: String, email: String, password: String,age: String){
        if self.view.check() == true{
            if validteFields(email: email, password: password){
                saveUser(name: name, email: email, password: password, age: age)
            }
        }
        else{
            self.view.Empty()
        }
    }
}
