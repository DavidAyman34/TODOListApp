//
//  TableViewCell.swift
//  ToDoMVP
//
//  Created by Divo Ayman on 9/10/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
protocol RempveTodo{
    func didTapRemoveTodo(id:IndexPath)
}

class TableViewCell: UITableViewCell {
  
    var delegate: RempveTodo?
  
    @IBOutlet weak var descriptionLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
      
     
    func configureCell(event: ToDoEvent){
    
           descriptionLabel.text = event.description
           
       }
    
    @IBAction func deleteBtn(_ sender: UIButton) {
     let index = self.indexPath
            
            delegate?.didTapRemoveTodo(id: index!)
           
       }
    
}
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
extension TableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
