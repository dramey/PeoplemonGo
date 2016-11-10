//
//  UserProfileViewController.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/8/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    
    
    
    
    
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    
    
    var profileUser = ProfileUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameText.text = profileUser.fullName
        oldPassword.text = profileUser.oldPassword
        newPassword.text = profileUser.newPassword
        
        // Do any additional setup after loading the view.
        
        //if already has image we want to show it--if not we want to hide it
        if let image = profileUser.image{
            imageView.image = image
            addGestureRecognizer()
            
        }else {
            imageView.isHidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func addGestureRecognizer(){
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    func viewImage(){
        if let image = imageView.image{
            UserStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
        
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        profileUser.image = imageView.image
    }
    
    
    //MARK: - IBACtions
    
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a Picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action) in self.showPicker(.camera)}))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action) in self.showPicker(.photoLibrary)}))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveUser(_ sender: AnyObject) {
    }
    
    
    
    
}
extension UserProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //implemented for us--no code--just include it--gives us the right to make functions to pull up picture or take camera pic
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            //take original image and scale it down 512 x 512 pixels
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height:newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width:maxSize, height:newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            imageView.image = resizedImage
            
            imageView.isHidden = false
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}

