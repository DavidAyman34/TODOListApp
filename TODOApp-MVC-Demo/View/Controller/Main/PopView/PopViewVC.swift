//
//  popView.swift
//  ToDo
//
//  Created by Divo Ayman on 6/18/20.
//  Copyright © 2020 Divo Ayman. All rights reserved.
//

import UIKit

protocol sendNewEvent {
    func newTodo(eventInfo: ToDoEvent)
    
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
    
    // MARK:-  Properties
    var delegate : sendNewEvent!
    var event : ToDoEvent!
    var viewModel: PopViewViewModelProtocols!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.setup()
        
    }
    
    // MARK:- Button
    @IBAction func saveBtn(_ sender: UIButton) {
        viewModel.checkToSaveTasks(desc: descriptionTextField.text!)
    }
    
    // MARK:- Public Methods
    class func create() -> PopViewVC {
        let popViewVC: PopViewVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.popView)
        popViewVC.viewModel = PopViewViewModel(view: popViewVC)
        return popViewVC
    }
}
// MARK: - Implement Protocols
extension PopViewVC:PopViewProtocols{
    func check() -> Bool {
        guard  let description = descriptionTextField.text,
            !description.isEmpty
            
            else {return false}
        return true
    }
    
    func dismissPop(){
        let newEvent = ToDoEvent(description: descriptionTextField.text!)
        delegate?.newTodo(eventInfo: newEvent)
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
