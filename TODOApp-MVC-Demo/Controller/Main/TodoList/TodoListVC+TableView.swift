//
//  TodoListVC+TableView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/29/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit
extension TodoListVC: UITableViewDelegate, UITableViewDataSource {

      func setupTableView(){
           tableView.delegate = self
               tableView.dataSource = self
           let tableNib = UINib(nibName: TableViewNib.tableNibIdentifier, bundle: nil)
           tableView.register(tableNib, forCellReuseIdentifier: Cells.cellIdentifier)
               tableView.tableFooterView = UIView()
               tableView.backgroundView = UIImageView(image: UIImage(named: "background 2"))

       }
    
    // MARK:- TableView Methods
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTodo.count
           
       }
       func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {

           return .delete
       }
       func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if  editingStyle == .delete {
               tableView.beginUpdates()
               let toDo =  eventTodo.remove(at: indexPath.row)
            self.presenter.deleteTaskId(id: toDo.id!)
               tableView.deleteRows(at: [indexPath], with: .fade)
              

               tableView.endUpdates()
           }
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
       let cell = tableView.dequeueReusableCell(withIdentifier: Cells.cellIdentifier , for: indexPath)  as! TableViewCell
        cell.delegate = self

        cell.configureCell(event: eventTodo[indexPath.row])
        cell.backgroundColor = .clear
        return cell
       }
    
}
