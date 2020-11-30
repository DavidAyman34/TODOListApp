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
protocol PopViewProtocols: class {
     func dismissPop()
     func showLoader()
     func hideLoader()
     func presentError(massage: String)
     func check() -> Bool
}
class PopViewVC: UIViewController {
    
    // MARK:- OutLet methods
   
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet var popView: PopView!
    var delegate : sendEvent!
    var event : ToDoEvent!
    var presenter: PopViewViewModelProtocols!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.setup()
        
        // Do any additional setup after loading the view.
    }
 
    @IBAction func saveBtn(_ sender: UIButton) {
        presenter.checkToSaveTasks(desc: descriptionTextField.text!)
    }
    // MARK:- Public Methods
    class func create() -> PopViewVC {
        let popViewVC: PopViewVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.popView)
        popViewVC.presenter = PopViewViewModel(view: popViewVC)
        return popViewVC
    }
}

extension PopViewVC:PopViewProtocols{
    func check() -> Bool {
           guard  let description = descriptionTextField.text,
               !description.isEmpty
               
               else {return false}
           return true
       }
    
    func dismissPop(){
           let newEvent = ToDoEvent(description: descriptionTextField.text!)
           delegate?.event(eventInfo: newEvent)
           dismiss(animated: true, completion: nil)
       }
    
    func presentError(massage: String){
        AlertManager.alert(title: "Error", massage: massage, present: self, titleBtn: "OK")
    }
    
    func showLoader(){
          self.view.showLoader()
      }
      
      func hideLoader(){
          self.view.hideLoader()
      }
}
