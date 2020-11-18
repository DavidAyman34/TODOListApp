//
//  APIRouter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/10/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case login(_ email: String, _ password: String)
    case signUp(_ name: String,_ email: String,_ password: String,_ age: Int)
    case updateUser(age: Int)
    case logOut
    case addTask(_ description: String)
    case deleteTask(_ id: String)
    case getUser
    case getTodos
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .getTodos:
            return .get
        case .getUser:
            return.get
        case .updateUser:
            return .put
        case .deleteTask:
            return .delete
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
            
        case .signUp(let name, let email, let password, let age):
            return [ParameterKeys.email: email, ParameterKeys.password: password,
                    ParameterKeys.name: name, ParameterKeys.age: age]
        case.updateUser(let age):
            return [ParameterKeys.age: age]
        case.addTask(let description):
            return [ParameterKeys.description: description]
        case .deleteTask(let id):
            return [ParameterKeys.id: id]
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .getTodos:
            return URLs.getTask
        case .signUp:
            return URLs.addUser
        case .getUser:
            return URLs.getUser
        case .updateUser:
            return URLs.updateUser
        case .logOut:
            return URLs.logout
        case .addTask:
            return URLs.addTask
        case.deleteTask(let id):
           return (URLs.addTask + "/\(id)")
        }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getTodos:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
        case .getUser:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        case .updateUser:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        case .logOut:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        case .addTask:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        case .deleteTask:
              urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: HeaderKeys.authorization)
        default:
            break
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
