//
//  todoList.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/29/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct getTasks: Codable {
    
    let count: Int
    let data: [ToDoEvent]

    enum CodingKeys: String, CodingKey {
        case count
        case data = "data"
    }
}
