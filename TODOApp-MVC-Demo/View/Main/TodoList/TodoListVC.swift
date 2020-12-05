//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
import Reachability
// MARK:- Protocol Methods
protocol TodoListProtocols: class{
    func showLoader()
    func hideLoader()
    func reload()
    func newTodo(eventInfo: ToDoEvent)
    func eventArr(arrOfTodo: [ToDoEvent])
    func startIndicator(title: String)
    func stopIndicator()
    func presentNetError()
}

class TodoListVC: UIViewController, sendNewEvent, RempveTodo,sendObj {
    
    // MARK:- OutLet
    @IBOutlet var todoListView: TodoListView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Properties
    var ArrOfTodo = [ToDoEvent] ()
    var viewModel: TodoListViewModelProtocols!
    let reachability = try! Reachability()
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkConnection()
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
        self.navigationItem.title = "New Tesk"
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
    
    func setupNetAlert(){
        let alert = UIAlertController(title: "Not Connected",
                                             message: "Please Turn on Network ",
                                             preferredStyle: .alert)
        
               alert.addAction(UIAlertAction(title: "Open Settings",
                                             style: UIAlertAction.Style.default,
                                             handler: openSettings))
               alert.addAction(UIAlertAction(title: "Cancel",
                                             style: UIAlertAction.Style.default,
                                             handler: nil))
               self.present(alert, animated: true)
    }
    
   private func openSettings(alert: UIAlertAction!) {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
    func startIndicator(title: String) {
        ActivityIndicator.shared.animateActivity(title:title, view: self.view, navigationItem:  self.navigationItem)
    }
    
    func stopIndicator() {
        ActivityIndicator.shared.stopAnimating(navigationItem: self.navigationItem)
    }
    
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
    func presentNetError(){
       setupNetAlert()
        
    }
    
}

