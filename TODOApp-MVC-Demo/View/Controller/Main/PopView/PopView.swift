//
//  PopView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class PopView: UIView {
// @IBOutlet weak var popView: UIView!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
   
    func setup(){
        setupTextField(descTextField, placeHolder: "Content")
    setupSaveBtn()
         self.layer.cornerRadius = self.frame.height/4
        
    }
    
    private func setupTextField(_ textField: UITextField, placeHolder: String){
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.placeholder = placeHolder
    
    }
    private func setupSaveBtn(){
           saveBtn.layer.borderColor = #colorLiteral(red: 0.3843137255, green: 0.1215686275, blue: 0.4862745098, alpha: 1)
           saveBtn.layer.cornerRadius = saveBtn.frame.height/2
           saveBtn.setTitle("Save", for: .normal)
           saveBtn.titleLabel?.font = .systemFont(ofSize: 20)
       }

}

