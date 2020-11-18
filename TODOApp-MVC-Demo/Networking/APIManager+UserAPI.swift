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
                      completion: @escaping (Result<signUpResponse, Error>)-> ()){
        
        APIManager.request(APIRouter.signUp(name, email, password, age)) { (response) in
             completion(response)
        }
    }
    
    // MARK:- LoginAPI
    class func  login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        APIManager.request(APIRouter.login(email, password)){ (response) in
            completion(response)
        }
    }
    
    // MARK:- GetUserAPT
    class func getUser(
        completion: @escaping(Result<UserData?, Error>) -> Void) {
        APIManager.request(APIRouter.getUser) { (response) in
            completion(response)
        }
        
    }
    
    // MARK:- UpdateUser
    class func updateUser(age: Int,completion: @escaping(Result<Bool, Error>) -> Void) {
        
        APIManager.request(APIRouter.updateUser(age: age)) { (response) in
            completion(response)
        }
    }
    
    // MARK:- logOut
    class func logOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        APIManager.request(APIRouter.logOut) { (response) in
            completion(response)
        }
    }
}

extension APIManager{
    // MARK:- The request function to get results in a closure
    static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
}
