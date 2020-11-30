//
//  PopViewPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol PopViewViewModelProtocols {
    func checkToSaveTasks(desc: String)
}
class PopViewViewModel{
    weak var view: PopViewProtocols!
    
    // MARK:- Initialization Methods
    init(view: PopViewProtocols) {
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
}
extension PopViewViewModel: PopViewViewModelProtocols{
    // MARK:- Public Methods
    func checkToSaveTasks(desc: String){
        if self.view.check() == true{
            saveTask(desc: desc)
            self.view.dismissPop()
        }
        else{
            view.presentError(massage: "please write some to remind your event")
        }
    }
}

