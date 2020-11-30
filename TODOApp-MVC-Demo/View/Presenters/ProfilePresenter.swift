//
//  ProfilePresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
protocol sendUser {
    func getData(user: UserData)
}
protocol ProfileViewModelProtocols {
    func updateAge(age: String)
    func logOut()
    func getUserData()
}
import Foundation

class ProfileViewModel{
    weak var view: ProfileViewProtocols!
    var userData : UserData?
    var delegate: sendUser!
    
    init(view: ProfileViewProtocols) {
        self.view = view
    }
    
    
    private func getCharacters(name: String) -> String{
        let chars = name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        return chars
    }
    
    private func getUserProfile(id:String){
        APIManager.getPhoto(id: id) { (error, photo) in
            if let error = error {
                print(error.localizedDescription)
            } else if let photo = photo {
                
                self.view.image(img: photo)
                print("done")
                
                
            }
        }
        
    }
    
    
}
extension ProfileViewModel: ProfileViewModelProtocols{
    
    func updateAge(age: String){
        APIManager.updateUser(age: Int(age)!) { (response) in
            switch response{
                
            case .success(_):
                print("done")
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            self.getUserData()
        }
    }
    
    func logOut(){
        APIManager.logOut{_ in
            self.view.go()
        }
    }
    
    func getUserData(){
        self.view.showLoader()
        APIManager.getUser { (response) in
            switch response{
            case .failure(let error) :
                print(error.localizedDescription)
                
            case .success(let user) :
                self.userData = user
                self.getUserProfile(id: self.userData?.id ?? "")
                print(self.userData ?? "s")
                let firstCharcters = self.getCharacters(name: self.userData!.name)
                self.view.getUser(user: user!)
                self.view.imageEmpty(charcters: firstCharcters)
                
                self.view.hideLoader()
                self.view.reload()
            }
        }
    }
}
