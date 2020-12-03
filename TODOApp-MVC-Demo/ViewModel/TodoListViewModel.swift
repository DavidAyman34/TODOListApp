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
protocol TodoListViewModelProtocols {
    func viewDidLoad()
    func deleteTaskId(id:String)
   
}
class TodoListViewModel{
    
    weak var view: TodoListProtocols!
    var TodoList = [ToDoEvent] ()
    var delegte: sendObj!
    
    // MARK:- Initialization Methods
    init(view: TodoListProtocols) {
        self.view = view
    }
    
    // MARK:- Methods
    private func retrieve(){
        self.view.showLoader()
        APIManager.getTask{ (response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                
                self.TodoList = result.data
                self.view.eventArr(arrOfTodo: self.TodoList)
                self.view.reload()
                
            }
            self.view.hideLoader()
        }
    }
}
extension TodoListViewModel: TodoListViewModelProtocols{
    func viewDidLoad(){
        retrieve()
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
