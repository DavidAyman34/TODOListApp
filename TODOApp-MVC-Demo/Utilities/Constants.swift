//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
    static let profile = "Profile"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let popView = "PopViewVC"
    static let Profile = "ProfileVC"
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let login =  "/user/login"
    static let logout = "/user/logout"
    static let addUser = "/user/register"
    static let addTask = "/task"
    static let getTask =  "/task"
    static let getUser = "/user/me"
    static let updateUser = "/user/me"
    static let addPhoto = base + "/user/me/avatar"
    static let getPhoto = base + "/user/"
    static let avater = "/avatar"
}

// Header Keys
struct HeaderKeys {
    static let authorization = "Authorization"
    static let contentType = "Content-Type"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let age = "age"
    static let description = "description"
    static let formdata =  "form"
    static let id = "_id"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
}

// TableViewIdentifier
struct TableViewNib {
    static let tableNibIdentifier = "TableViewCell"
}
// CellIdentifier
struct Cells {
    static let cellIdentifier = "TableViewCell"
}
