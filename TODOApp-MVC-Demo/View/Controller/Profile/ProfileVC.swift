//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    // MARK:- OutLet methods
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var namelabl: UILabel!
    @IBOutlet weak var logOutlabl: UILabel!
    @IBOutlet weak var editProfilelabl: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!

    var userD : UserData?
    let imagePicker = UIImagePickerController()
    var name: UITextField?
    var age: UITextField?
    var presenter: ProfilePresenter!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       // profileView.setup()
        presenter.getUserData()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    // MARK:- PrivateFunction methods
    private func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddPhotos", style: .done, target: self, action: #selector(addPhoto))
        
        navigationItem.title = "Profile"
    }
    private func selectPhoto() {
        imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
   

   func showLoader(){
         self.view.showLoader()
     }
     
     func hideLoader(){
         self.view.hideLoader()
     }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userProfile.image = image
            APIManager.createPhoto(avatar: userProfile.image!) {
                print("postSuccess")
            }
            print(image.pngData())
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    func updateUser(){
        let alertController = UIAlertController(title: "Edit Your Age", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter New Age"
            textField.keyboardType = .numberPad
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            
            let ageTF = alertController.textFields![0] as UITextField
            self.presenter.updateAge(age: ageTF.text!)
        
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    @objc func addPhoto() {
        selectPhoto()
        
    }
    
    
  
    func updateUI(){
         let tabGesture = UITapGestureRecognizer()
        navSetup()
        imagePicker.delegate = self
        imagePicker.delegate = self
       
           userProfile.layer.cornerRadius = userProfile.frame.height/2
           userProfile.layer.borderWidth = 1
           userProfile.layer.borderColor = #colorLiteral(red: 0.9051990799, green: 0.9051990799, blue: 0.9051990799, alpha: 1)
           userProfile.clipsToBounds = true
           userProfile.contentMode = .scaleAspectFit
           userProfile.isUserInteractionEnabled = true
           userProfile.addGestureRecognizer(tabGesture)
    }
    
    func go(){
        let signIn = SignInVC.create()
               let navigationController = UINavigationController(rootViewController: signIn)
               UserDefaultsManager.shared().token = nil
               AppDelegate.shared().window?.rootViewController = navigationController
    }
  
  
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profile: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.Profile)
        profile.presenter = ProfilePresenter(view: profile)
        return profile
    }
}

