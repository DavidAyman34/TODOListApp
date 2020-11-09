//
//  SignUp.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/28/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct signUpResponse: Codable {
    
    let token: String
    let user: UserData
    
    enum CodingKeys: String, CodingKey {
           case token, user
       }
    
}
