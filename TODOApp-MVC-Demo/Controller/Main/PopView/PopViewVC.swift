//
//  popView.swift
//  ToDo
//
//  Created by Divo Ayman on 6/18/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit
protocol sendEvent {
    func event (eventInfo: ToDoEvent)
    
}
class PopViewVC: UIViewController {
    
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    var delegate : sendEvent!
    var event : ToDoEvent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         popView.layer.cornerRadius = popView.frame.height/4
        
        // Do any additional setup after loading the view.
    }
    
    
    func saveTask(desc: String){
        APIManager.addTask(description: desc) { (error, todoEvent) in
            if let error = error {
                print(error.localizedDescription)
            } else if let todoEvent = todoEvent {
                print(todoEvent.description)
                
            }
        }
    } 
    
    
    
    func dismissPop(){
        
        let newEvent = ToDoEvent(description: descriptionTextField.text!)
        delegate?.event(eventInfo: newEvent)
        saveTask(desc: descriptionTextField.text!)
        dismiss(animated: true, completion: nil)
        
    }
    func check() -> Bool {
           guard  let description = descriptionTextField.text,
               !description.isEmpty
            
               else {return false}
           return true
       }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
        if check() == true{
            dismissPop()
            
        }
        else {
            AlertManager.alert(title: "Description", massage: "please write some to remind your event", present: self, titleBtn: "Ok")
                             return
            
        
    }
    }
    // MARK:- Public Methods
    class func create() -> PopViewVC {
        let popViewVC: PopViewVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.popView)
        return popViewVC
    }
    
    
}
