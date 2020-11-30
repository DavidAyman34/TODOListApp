//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol TodoListProtocols: class{
    func showLoader()
    func hideLoader()
    func reload()
    func event(eventInfo: ToDoEvent)
    func eventArr(arrOfTodo: [ToDoEvent])
}

class TodoListVC: UIViewController, sendEvent, RempveTodo,sendObj {
    
    
    
    // MARK:- OutLet methods
    @IBOutlet var todoListView: TodoListView!
    @IBOutlet weak var tableView: UITableView!
    var eventTodo = [ToDoEvent] ()
    var presenter: TodoListViewModelProtocols!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        navSetup()
        todoListView.setup()
        //presenter.delegte = self
        presenter.viewDidLoad()
    }
    
    
    func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "profile", style: .done, target: self, action: #selector(proflie))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(addPost))
        navigationItem.title = "New Tesk"
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
    
    
    
    // MARK:- Public Methods
    class func create() -> TodoListVC {
        let todoListVC: TodoListVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.todoListVC)
        todoListVC.presenter = TodoListViewModel(view: todoListVC)
        
        return todoListVC
    }
}
extension TodoListVC: TodoListProtocols{
    func eventArr(arrOfTodo: [ToDoEvent]) {
        eventTodo = arrOfTodo
    }
    
    func event(eventInfo: ToDoEvent) {
        eventTodo.append(eventInfo)
        tableView.reloadData()
    }
    
    func reload(){
        self.tableView.reloadData()
    }
    func showLoader(){
        self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    
}

