//
//  ValidationData.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/28/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct valid {
   static func isValidEmail(email: String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if  pred.evaluate(with: email){
            return true
        }
            
        else {
            return false
            
        }
        //        There’s some text before the @
        //        There’s some text after the @
        //        There’s at least 2 alpha characters after a .
    }
    
  static  func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if  passwordTest.evaluate(with: testStr){
            return true
        }
        else {
            return false
        }
    }
    
}
