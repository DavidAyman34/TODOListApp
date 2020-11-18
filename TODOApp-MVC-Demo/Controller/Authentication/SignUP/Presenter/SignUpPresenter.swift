//
//  SignUpPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class SignUpPresenter {
    
    weak var view: SignUpVC!
    
    // MARK:- Initialization Methods
    init(view: SignUpVC) {
        self.view = view
    }
    
    // MARK:- Private Methods
    private func validteFields(email: String?, password: String?) -> Bool{
        if !valid.isValidEmail(email: email){
            self.view.presentError(massage: "Plase Enter an Email")
            return false
        }
        if !valid.isValidPassword(testStr: password){
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
                self.view.go()
            }
            self.view.hideLoader()
        }
    }
    // MARK:- Public Methods
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
