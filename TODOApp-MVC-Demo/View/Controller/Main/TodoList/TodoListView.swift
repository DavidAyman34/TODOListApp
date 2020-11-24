//
//  TodoListView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoListView: UIView {
    
    @IBOutlet weak var backImg: UIImageView!
    
    func setup(){
        
        setupImg(named: "background 2")
    }
    private func setupImg(named: String){
        backImg.image = UIImage(named: named)
        backImg.contentMode = .scaleAspectFit
        
    }
}
