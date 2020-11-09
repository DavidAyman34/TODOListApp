//
//  TableViewCell.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    var user : UserData!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func con(userD: UserData){
       // age.text = "\(userD.age)"
 
    }
   
}
