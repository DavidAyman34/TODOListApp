//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

// MARK:- Protocol Methods
protocol TodoListProtocols: class{
    func showLoader()
    func hideLoader()
    func reload()
    func newTodo(eventInfo: ToDoEvent)
    func eventArr(arrOfTodo: [ToDoEvent])
}

class TodoListVC: UIViewController, sendNewEvent, RempveTodo,sendObj {
    
    // MARK:- OutLet
    @IBOutlet var todoListView: TodoListView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var ArrOfTodo = [ToDoEvent] ()
    var viewModel: TodoListViewModelProtocols!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        checkConnection()
        setupTableView()
        navSetup()
        todoListView.setup()
        viewModel.viewDidLoad()
    }
    
    // MARK:-  Methods
    func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "profile", style: .done, target: self, action: #selector(proflie))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(addPost))
    }
    
    func checkConnection(){
        if #available(iOS 12.0, *) {
            if NetworkManagaer.shared().isConnected == true{
                 navigationItem.title = "New Tesk"
            }else{
                ActivityIndicator.shared.animateActivity(title:   "Waiting for network", view: self.view, navigationItem: navigationItem)
            }
        } else {
            // Fallback on earlier versions
        }

    }
    
    @objc func proflie() {
        let profile =  ProfileVC.create()
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    @objc func addPost() {
        let pop =  PopViewVC.create()
        pop.delegate = self
        present(pop, animated: true, completion: nil)
    }
    
    func didTapRemoveTodo(id: IndexPath) {
        let  alert = UIAlertController(title: "Sorry" , message: "Are You Sure You Want To Delete This TODO?" , preferredStyle: .alert)
        let okAction = UIAlertAction(title:"Yes", style: .default){ (action) in
            let toDo = self.ArrOfTodo.remove(at: id.row)
            self.viewModel.deleteTaskId(id: toDo.id!)
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
        todoListVC.viewModel = TodoListViewModel(view: todoListVC)
        
        return todoListVC
    }
}

// MARK: - Implement Protocols
extension TodoListVC: TodoListProtocols{
    func eventArr(arrOfTodo: [ToDoEvent]) {
        ArrOfTodo = arrOfTodo
    }
    
    func newTodo(eventInfo: ToDoEvent) {
        ArrOfTodo.append(eventInfo)
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

