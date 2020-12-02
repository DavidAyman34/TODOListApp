//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol ProfileViewProtocols: class{
    func showLoader()
    func hideLoader()
    func go()
    func showImage(img: UIImage)
    func reload()
    func getUser(user: UserData)
    func imageEmpty(charcters: String)
    
}
class ProfileVC: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // MARK:- OutLet methods
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var namelabl: UILabel!
    @IBOutlet weak var logOutlabl: UILabel!
    @IBOutlet weak var editProfilelabl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    // MARK:- Properties
    var userInfo : UserData?
    let imagePicker = UIImagePickerController()
    var name: UITextField?
    var age: UITextField?
    var viewModel: ProfileViewModelProtocols!
    
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserData()
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK:- Private Methods
    private func navSetup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "AddPhotos", style: .done, target: self, action: #selector(addPhoto))
        
        navigationItem.title = "Profile"
    }
    private func selectPhoto() {
        imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = false
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage.image = image
            APIManager.createPhoto(avatar: userImage.image!) {
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
            self.viewModel.updateAge(age: ageTF.text!)
            
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
        
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = #colorLiteral(red: 0.9051990799, green: 0.9051990799, blue: 0.9051990799, alpha: 1)
        userImage.clipsToBounds = true
        userImage.contentMode = .scaleAspectFit
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tabGesture)
    }
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profile: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.Profile)
        profile.viewModel = ProfileViewModel(view: profile) 
        return profile
    }
}

 // MARK: - Implement Protocols
extension ProfileVC: ProfileViewProtocols{
    
    func imageEmpty(charcters: String){
        if self.userImage == nil{
            self.imageLabel.isHidden = false
            self.imageLabel.text = charcters
        }
        self.reload()
    }
    func getUser(user: UserData) {
        self.emailLabel.text = user.email
        guard ((self.namelabl?.text = user.name) != nil)   else  {return}
        guard ((self.ageLabel?.text = String(user.age)) != nil)   else  {return}
    }
    func showImage(img: UIImage) {
        userImage.image = img
        self.tableView.reloadData()
    }
    
    func showLoader(){
        self.view.showLoader()
    }
    
    func hideLoader(){
        self.view.hideLoader()
    }
    
    func reload(){
        self.tableView.reloadData()
    }
    
    func go(){
        let signIn = SignInVC.create()
        let navigationController = UINavigationController(rootViewController: signIn)
        UserDefaultsManager.shared().token = nil
        AppDelegate.shared().window?.rootViewController = navigationController
    }
}

