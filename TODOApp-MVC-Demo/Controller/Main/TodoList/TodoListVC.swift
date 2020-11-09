//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController, sendEvent, RempveTodo {
    func event(eventInfo: ToDoEvent) {
           eventTodo.append(eventInfo)
            tableView.reloadData()
    }
    
    
    // MARK:- Lifecycle methods
    @IBOutlet weak var tableView: UITableView!
    var eventTodo = [ToDoEvent] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      navSetup()
        setupTableView()
        retrieve()
    }
    func deleteTaskId(id:String){
        APIManager.deleteTask(id: id) { (error, todo) in
            if let error = error{
                print(error.localizedDescription)
            } else if let todo = todo{
                print(todo.id ?? "d")
            }
        }
    }
    func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "profile", style: .done, target: self, action: #selector(proflie))
              navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
                  #selector(addPost))
              navigationItem.title = "New Tesk"
    }
    func retrieve(){
        self.view.showLoader()
        APIManager.getTask { (error, todoEvent) in
            if let error = error {
                print(error.localizedDescription)
            } else if let todoEvent = todoEvent {
                self.eventTodo = todoEvent
                print(todoEvent)
                self.view.hideLoader()
                self.tableView.reloadData()
               
                
            }
        }
    }

    @objc func proflie() {
        let pro =  ProfileVC.create()
            
                       self.navigationController?.pushViewController(pro, animated: true)
    }
    

    
    
    
   @objc func addPost() {
        let pop =  PopViewVC.create()
        pop.delegate = self
                present(pop, animated: true, completion: nil)
    }
    
     func didTapRemoveTodo(id: IndexPath) {
         
         let  alert = UIAlertController(title: "Sorry" , message: "Are You Sure You Want To Delete This TODO?" , preferredStyle: .alert)
         let okAction = UIAlertAction(title:"Yes", style: .default){ (action) in
            let toDo = self.eventTodo.remove(at: id.row)
            self.deleteTaskId(id: toDo.id!)
             self.tableView.deleteRows(at: [id], with: .fade)
           
            self.tableView.reloadData()
         }
         alert.addAction(okAction)
         alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
         self.present(alert, animated: true, completion: nil)
       
             }
    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        return todoListVC
    }
}

