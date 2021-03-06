//
//  ValidationData.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/28/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
class validator {
    
    private static let sharedInstance = validator()
    
    class func shared() -> validator {
        return validator.sharedInstance
    }

    func isValidEmail(email: String?) -> Bool {
        guard email != nil else { return false }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        if  pred.evaluate(with: email){
            return true
        }
            
        else {
            return false
            
        }
        
    }
    
    func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }
      
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if  passwordTest.evaluate(with: testStr){
            return true
        }
        else {
            return false
        }
    }
    
}
