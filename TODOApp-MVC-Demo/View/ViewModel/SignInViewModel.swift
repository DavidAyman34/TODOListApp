//
//  presenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/11/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

protocol SignInViewModelProtocols{
    func tryToLogin(email: String, password: String)
}

class SignInViewModel{
    
     weak var view: SignInVCProtocol!
    //var vild : valid!
    
    // MARK:- Initialization Methods
    init(view: SignInVCProtocol) {
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
        self.view.showLoader()
        APIManager.login(email: email, password: password) { (response) in
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
extension SignInViewModel: SignInViewModelProtocols{
    
    func tryToLogin(email: String, password: String){
          if validteFields(email: email, password: password){
              login(email: email, password: password)
          }
      }
}
