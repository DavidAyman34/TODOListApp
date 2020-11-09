//
//  todo.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/29/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct toDO: Codable {
    
    var description: String
    var id : String
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        
        case id = "_id"
        
    }
}
