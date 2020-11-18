//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListVC: UIViewController, sendEvent, RempveTodo,sendObj {
    
    // MARK:- OutLet methods
    @IBOutlet weak var tableView: UITableView!
    var eventTodo = [ToDoEvent] ()
    var presenter: TodoListPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.delegte = self
        presenter.viewDidLoad()
    }
    func showLoader(){
        self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    
    
    func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "profile", style: .done, target: self, action: #selector(proflie))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(addPost))
        navigationItem.title = "New Tesk"
    }
    
    
    func reload(){
        self.tableView.reloadData()
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
            self.presenter.deleteTaskId(id: toDo.id!)
            self.tableView.deleteRows(at: [id], with: .fade)
            
            self.tableView.reloadData()
        }
        alert.addAction(okAction)
        alert.addAction(UIAlertAction.init(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- Protocol Methods
    func eventArr(arrOfTodo: [ToDoEvent]) {
        eventTodo = arrOfTodo
    }
    
    func event(eventInfo: ToDoEvent) {
        eventTodo.append(eventInfo)
        tableView.reloadData()
    }
    
    
    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.presenter = TodoListPresenter(view: todoListVC)
       
        return todoListVC
    }
}

