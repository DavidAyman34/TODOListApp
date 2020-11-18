//
//  Profile+Tableview.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/5/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//


import UIKit
extension ProfileVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            updateUser()
        }
        else if indexPath.row == 4 {
            self.presenter.logOut()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 5
        
          
       }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 100
      }
}
