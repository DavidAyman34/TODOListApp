//
//  ProfileView.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var proflieImg: UILabel!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    func setup(){
        setupLabel(label: editLabel, text: "Edit")
        setupLabel(label: nameLabel, text: "Name")
        setupLabel(label: emailLabel, text: "Email")
        setupLabel(label: ageLabel, text: "Age")
        setupLabel(label: logoutLabel, text: "Log Out")
        setupImg()
    }
    private func setupLabel(label:UILabel,text: String?){
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.backgroundColor = .clear
    }
    private func setupImg(){
        let tabGesture = UITapGestureRecognizer()
        proflieImg.layer.cornerRadius = proflieImg.frame.height/2
        proflieImg.layer.borderWidth = 1
        proflieImg.layer.borderColor = #colorLiteral(red: 0.9051990799, green: 0.9051990799, blue: 0.9051990799, alpha: 1)
        proflieImg.clipsToBounds = true
        proflieImg.contentMode = .scaleAspectFit
        proflieImg.isUserInteractionEnabled = true
        proflieImg.addGestureRecognizer(tabGesture)
    }
    
}
