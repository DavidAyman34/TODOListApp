//
//  PopViewPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation

class PopViewPresenter{
    weak var view: PopViewVC!
    
    // MARK:- Initialization Methods
    init(view: PopViewVC) {
        self.view = view
    }
    // MARK:- Private Methods
    private func saveTask(desc: String){
        self.view.showLoader()
        APIManager.addTask(description: desc) { (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let user):
                print(user.description)
                 self.view.hideLoader()
            }
           
        }
        
    }
    
    // MARK:- Public Methods
    func tryToSaveTask(desc: String){
        if self.view.check() == true{
            saveTask(desc: desc)
            self.view.dismissPop()
               }
        else{
            view.presentError(massage: "please write some to remind your event")
        }
    }
}
