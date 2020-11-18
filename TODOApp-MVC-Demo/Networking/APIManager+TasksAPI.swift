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
                       completion: @escaping(Result<ToDoEvent,Error>) -> Void) {
        
        APIManager.request(APIRouter.addTask(description)) { (response) in
            completion(response)
        }
        
        
    }
    
    // MARK:- GetAllTask
  class func getTask(completion: @escaping (Result<getTasks, Error>)-> ()){
         request(APIRouter.getTodos){ (response) in
             completion(response)
        
    }
    
    }
    
    
    // MARK:- DeleteTask
    class func deleteTask(id: String,
                          completion: @escaping(Result<ToDoEvent,Error>) -> Void) {
        APIManager.request(APIRouter.deleteTask(id)) { (response) in
        
            completion(response)
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
        let URLphoto = URLs.getPhoto + id + URLs.avater
        AF.request(URLphoto , method: HTTPMethod.get, parameters: nil,
                   encoding: JSONEncoding.default, headers: nil).response { response in
                    
                    guard response.error == nil else {
                        print(response.error!)
                        
                        return
                    }
                    guard let data = response.data else{
                        print("didn't get any data from API")
                        return
                    }
                    let uiimage: UIImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "WHITE")
                    completion(nil,uiimage)
        }
    }
    
    
}
