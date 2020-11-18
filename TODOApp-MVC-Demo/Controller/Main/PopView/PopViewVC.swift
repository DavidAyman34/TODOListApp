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
    
    // MARK:- OutLet methods
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var descriptionTextField: UITextField!
    var delegate : sendEvent!
    var event : ToDoEvent!
    var presenter: PopViewPresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = popView.frame.height/4
        
        // Do any additional setup after loading the view.
    }
    
    
    func showLoader(){
        self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
     func dismissPop(){
        let newEvent = ToDoEvent(description: descriptionTextField.text!)
        delegate?.event(eventInfo: newEvent)
        dismiss(animated: true, completion: nil)
    }
    func check() -> Bool {
        guard  let description = descriptionTextField.text,
            !description.isEmpty
            
            else {return false}
        return true
    }
    
    func presentError(massage: String){
        AlertManager.alert(title: "Error", massage: massage, present: self, titleBtn: "OK")
    }
    @IBAction func saveBtn(_ sender: UIButton) {
        presenter.tryToSaveTask(desc: descriptionTextField.text!)
    }
    // MARK:- Public Methods
    class func create() -> PopViewVC {
        let popViewVC: PopViewVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.popView)
        popViewVC.presenter = PopViewPresenter(view: popViewVC)
        return popViewVC
    }
    
    
}
