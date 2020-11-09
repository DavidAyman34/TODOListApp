//
//  ToDoEvent.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import Foundation
struct ToDoEvent: Codable {
    
    var description: String
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case id = "_id"
        
        
    }
}
