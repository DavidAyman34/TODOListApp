//
//  presenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire


class SignInPresenter{
    
    private weak var view: SignInVC!
    //var vild : valid!
    
    // MARK:- Initialization Methods
    init(view: SignInVC) {
        self.view = view
    }
    
    // MARK:- private methods
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
    
    private func login(email: String, password: String){
        self.view.showLaoder()
        APIManager.login(email: email, password: password) { (response) in
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
    
    // MARK:- public methods
    func tryToLogin(email: String, password: String){
        if validteFields(email: email, password: password){
            login(email: email, password: password)
        }
    }
    
    
}
