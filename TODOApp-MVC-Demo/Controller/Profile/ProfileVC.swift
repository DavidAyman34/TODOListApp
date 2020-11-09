//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        getUserData()
        updateUI()
       
        // Do any additional setup after loading the view.
    }
    func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddPhotos", style: .done, target: self, action: #selector(addPhoto))
        
        navigationItem.title = "Profile"
    }
    func selectPhoto() {
        imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    func getUserProfile(id:String){
        APIManager.getPhoto(id: id) { (error, photo) in
            if let error = error {
                print(error.localizedDescription)
            } else if let photo = photo {
                self.userProfile.image = photo
                print("done")
                
                
                
                //self.tableView.reloadData()
                
            }
        }
        
    }
    func getUserData(){
        self.view.showLoader()
        APIManager.getUser { (error, user) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                self.userD = user
                self.getUserProfile(id: self.userD?.id ?? "")
                print(self.userD)
                let firstCharcters = self.getCharacters(name: self.userD!.name)
                if self.userProfile == nil{
                    
                    self.imageLabel.isHidden = false
                    self.imageLabel.text = firstCharcters
                }
                self.emailLabel.text = self.userD?.email
                guard ((self.namelabl?.text = user.name) != nil)   else  {return}
                
                guard ((self.ageLabel?.text = String(user.age)) != nil)   else  {return}
                self.view.hideLoader()
                self.tableView.reloadData()
                
            }
        }
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
            APIManager.updateUser(age: Int(ageTF.text!)!) { (err, success) in
                self.getUserData()
                
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil )
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
  
    
    @objc func addPhoto() {
        selectPhoto()
        
    }
    
    func go(){
        let signIn = SignInVC.create()
        
        
        let navigationController = UINavigationController(rootViewController: signIn)
        UserDefaultsManager.shared().token = nil
        AppDelegate.shared().window?.rootViewController = navigationController
    }
    
    func getCharacters(name: String) -> String{
        let chars = name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
        return chars
    }
    func updateUI(){
          navSetup()
          imagePicker.delegate = self
         imagePicker.delegate = self
         userProfile.layer.borderWidth = 1
         userProfile.layer.borderColor = #colorLiteral(red: 0.9051990799, green: 0.9051990799, blue: 0.9051990799, alpha: 1)
         userProfile.clipsToBounds = true
         userProfile.layer.cornerRadius = self.userProfile.frame.size.width / 2
         let tabGesture = UITapGestureRecognizer()
         userProfile.isUserInteractionEnabled = true
         userProfile.addGestureRecognizer(tabGesture)
      
      
     }
    
    
    func logOut(){
        APIManager.logOut {
            self.go()
        }
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
        
    }
    
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profile: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.Profile)
        return profile
    }
}

