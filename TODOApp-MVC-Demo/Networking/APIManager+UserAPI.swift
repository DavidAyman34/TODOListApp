//
//  APIManager.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    // MARK:- SignUpAPI
    class func signUp(name: String, email: String, password: String, age: Int,
                      completion: @escaping(_ error: Error?, _ signData: signUpResponse?)-> Void){
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: password, ParameterKeys.name: name, ParameterKeys.age: age]
        
        AF.request(URLs.addUser, method: HTTPMethod.post, parameters: params,
                   encoding: JSONEncoding.default, headers: headers).response { response in
                    
                    
                    guard response.error == nil else {
                        print(response.error!)
                        completion(response.error, nil)
                        return
                    }
                    
                    
        }
    }
    
    // MARK:- LoginAPI
    class func login(with email: String, password: String,
                     completion: @escaping (_ error: Error?, _ loginData: LoginResponse?) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json"]
        let params: [String: Any] = [ParameterKeys.email: email,
                                     ParameterKeys.password: password]
        
        AF.request(URLs.login, method: HTTPMethod.post, parameters: params,
                   encoding: JSONEncoding.default, headers: headers).response {
                    response in
                    guard response.error == nil else {
                        print(response.error!)
                        completion(response.error, nil)
                        return
                    }
                    
                    guard let data = response.data else {
                        print("didn't get any data from API")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let loginData = try decoder.decode(LoginResponse.self, from: data)
                        completion(nil, loginData)
                    } catch let error {
                        print(error)
                    }
        }
    }
    // MARK:- GetUserAPT
    class func getUser(
        completion: @escaping(_ error: Error?, _ userData: UserData?) -> Void) {
        
        let token = UserDefaultsManager.shared().token!
        let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(token)"]
        
        AF.request(URLs.getUser, method: HTTPMethod.get, parameters: nil,
                   encoding: JSONEncoding.default, headers: headers).response { response in
                    
                    guard response.error == nil else {
                        print(response.error!)
                        completion(response.error, nil)
                        return
                    }
                    
                    guard let data = response.data else {
                        print("didn't get any data from API")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let userData = try decoder.decode(UserData.self, from: data)
                        completion(nil, userData)
                    } catch let error {
                        print(error)
                    }
        }
    }
    
    // MARK:- UpdateUser
      class func updateUser(age: Int,completion: @escaping (_ error: Error?, _ success:Bool) -> Void) {
        
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json", HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token ?? "")"]
        let params: [String: Any] = [ParameterKeys.age: age]
        print(age)
        AF.request(URLs.updateUser, method: HTTPMethod.put, parameters: params, encoding: JSONEncoding.default, headers: headers).response {
            response in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, false)
                return
            }
            guard let data = response.data else {
                print("didn't get any data from API")
                return
            }
            completion(nil, true)
        }
    }
    
    // MARK:- logOut
     class func logOut(completion: @escaping () -> Void) {
         let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token ?? "")"]
         
         AF.request(URLs.logout, method: HTTPMethod.post, parameters: nil, encoding: JSONEncoding.default, headers: headers).response {
             response in
             guard response.error == nil else {
                 print(response.error!)
                 completion()
                 return
             }
             
             guard response.data != nil else {
                 print("didn't get any data from API")
                 return
             }
             completion()
             
         }
     }
}
