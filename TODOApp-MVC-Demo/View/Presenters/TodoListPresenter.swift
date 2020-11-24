//
//  TodoListPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/18/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol sendObj{
    func eventArr(arrOfTodo:[ToDoEvent])
}
class TodoListPresenter{
    
    weak var view: TodoListVC!
    var TodoList = [ToDoEvent] ()
    var delegte: sendObj!
    
    // MARK:- Initialization Methods
    init(view: TodoListVC) {
        self.view = view
    }
    
    // MARK:- Methods
    func viewDidLoad(){
        self.view.setupTableView()
        self.view.navSetup()
        retrieve()
        
    }
    

    func retrieve(){
        self.view.showLoader()
        APIManager.getTask{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                
                self.TodoList = result.data
                self.delegte.eventArr(arrOfTodo: self.TodoList)
                self.view.reload()
                
            }
            self.view.hideLoader()
        }
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
