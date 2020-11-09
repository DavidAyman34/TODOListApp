//
//  APIManager+TasksAPI.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/7/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire
extension APIManager {
    
    // MARK:- AddTaskAPI
    class func addTask(description: String,
                       completion: @escaping(_ error: Error?, _ todoData: ToDoEvent?) -> Void) {
        
        let token = UserDefaultsManager.shared().token!
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                    HeaderKeys.authorization: "Bearer \(token)"]
        
        let params: [String: Any] = [ParameterKeys.description: description]
        
        AF.request(URLs.addTask, method: HTTPMethod.post, parameters: params,
                   encoding: JSONEncoding.default, headers: headers).response { response in
                    
                    switch response.result {
                    case .success:
                        print(response)
                        print(token)
                        break
                    case .failure(let error):
                        
                        print(error)
                    }        }
        
        
    }
    
    // MARK:- GetAllTask
    class func getTask(
        completion: @escaping(_ error: Error?, _ todoData: [ToDoEvent]?) -> Void) {
        
        let token = UserDefaultsManager.shared().token!
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                    HeaderKeys.authorization: "Bearer \(UserDefaultsManager.shared().token!)"]
        
        
        AF.request(URLs.getTask, method: HTTPMethod.get, parameters: nil,
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
                        let todoData = try decoder.decode(getTasks.self, from: data).data
                        completion(nil, todoData)
                    } catch let error {
                        print(error)
                    }
        }
    }
    
    // MARK:- DeleteTask
    class func deleteTask(id: String,
                          completion: @escaping(_ error: Error?, _ todoData: ToDoEvent?) -> Void) {
        
        let token = UserDefaultsManager.shared().token!
        let headers: HTTPHeaders = [HeaderKeys.contentType: "application/json",
                                    HeaderKeys.authorization: "Bearer \(token)"]
        
        AF.request(URLs.addTask + "/\(id)", method: HTTPMethod.delete, parameters: nil,
                   encoding: JSONEncoding.default, headers: headers).response { response in
                    
                    switch response.result {
                    case .success:
                        print(response)
                        print(token)
                        break
                    case .failure(let error):
                        
                        print(error)
                    }
        }
    }
    // MARK:- Addphoto
    class func createPhoto(avatar: UIImage, completion: @escaping () -> Void){
        
        let token = UserDefaultsManager.shared().token!
        let headers: HTTPHeaders = [HeaderKeys.authorization:"Bearer \(UserDefaultsManager.shared().token!)"]
        AF.upload(multipartFormData: { (form: MultipartFormData) in
            
            if let data = avatar.jpegData(compressionQuality: 0.75) {
                form.append(data, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            }
        }, to: URLs.addPhoto, usingThreshold: MultipartFormData.encodingMemoryThreshold,
           method: .post, headers: headers).response {
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
    
    // MARK:- Getphoto
    class func getPhoto(id: String,
                        completion: @escaping(_ error: Error?, _ userProfile: UIImage?) -> Void) {
        
        AF.request("https://api-nodejs-todolist.herokuapp.com/user/5f99e3dcedd4e1001715547c/avatar", method: HTTPMethod.get, parameters: nil,
                   encoding: JSONEncoding.default, headers: nil).response { response in
                    
                    guard response.error == nil else {
                        print(response.error!)
                        
                        return
                    }
                    guard let data = response.data else{
                        print("didn't get any data from API")
                        return
                    }
                    let uiimage: UIImage = UIImage(data: data)!
                    completion(nil,uiimage)
        }
    }
    
    
}
