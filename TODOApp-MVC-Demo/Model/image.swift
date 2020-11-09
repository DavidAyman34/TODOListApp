//
//  image.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/5/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct Photos: Codable {
    let formdata : String
    
    enum CodingKeys: String, CodingKey {
          case formdata = "form"
      }
}
