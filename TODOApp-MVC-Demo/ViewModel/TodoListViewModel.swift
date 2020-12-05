//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Reachability
protocol sendObj{
    func eventArr(arrOfTodo:[ToDoEvent])
}
protocol TodoListViewModelProtocols {
    func viewDidLoad()
    func deleteTaskId(id:String)
    
}

class TodoListViewModel{
    
    // MARK:- Properties
    weak var view: TodoListProtocols!
    var TodoList = [ToDoEvent] ()
    var delegte: sendObj!
    let reachability = try! Reachability()
    
    // MARK:- Initialization Methods
    init(view: TodoListProtocols) {
        self.view = view
    }
    
    // MARK:- Methods
    private func retrieve(){
        self.view.startIndicator(title: "Connecting...")
        self.view.showLoader()
        APIManager.getTask{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                //self.view.startIndicator(title: "Connecting...")
                self.TodoList = result.data
                self.view.eventArr(arrOfTodo: self.TodoList)
                self.view.reload()
                
            }
            self.view.stopIndicator()
            self.view.hideLoader()
        }
    }
    
    private func checkNetwork(){
        
        reachability.whenReachable = { reachability in
            switch reachability.connection {
            case .wifi:
                print("Reachable via WiFi")
                self.retrieve()
                
            case .cellular:
                print("Reachable via Cellular")
                self.retrieve()
                
            case .unavailable:
                print("Network not reachable")
                self.view.startIndicator(title: "Connecting...")
                
            case .none:
                self.view.startIndicator(title: "Waiting for network")
            }
        }
        reachability.whenUnreachable = { _ in
            self.view.startIndicator(title: "Waiting for network")
            self.view.presentNetError()
            print("Not reachable")
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

extension TodoListViewModel: TodoListViewModelProtocols{
    func viewDidLoad(){
        retrieve()
        checkNetwork()
    }
    
    func deleteTaskId(id:String){
        APIManager.deleteTask(id: id) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let todo):
                print(todo.id)
            }
        }
    }
}
