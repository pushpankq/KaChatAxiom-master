//
//  SignUpViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import YPImagePicker

protocol signInFill{
    func fillFields(email:String, password:String)
}

class SignUpViewController: UIViewController,UINavigationControllerDelegate {

    @IBOutlet weak var name: textFieldDesign!
    @IBOutlet weak var email: textFieldDesign!
    @IBOutlet weak var password: textFieldDesign!
    @IBOutlet weak var signUpOut: ButtonDesign!
    @IBOutlet weak var imageViewOut: UIImageViewRounded!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var signUpObj:SignUpRequest!
    private final var image = UIImage(named: "userProfile")
    private var img:UIImage!
    var signUpDel:signInFill?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        imageViewOut.isUserInteractionEnabled = true
        imageViewOut.addGestureRecognizer(singleTap)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        self.loader.startAnimating()
        self.signUpOut.isEnabled = false
        if imageViewOut.image == image{
            self.image = nil
        }else{
            self.image = self.imageViewOut.image
        }
        if let email = self.email.text, let password = self.password.text, let name = self.name.text{
            self.signUpObj = SignUpRequest(name: name, email: email, password: password)
            self.signUpObj.signUpRequest(image: self.image,completion: {(error, isLogin) in
                self.loader.stopAnimating()
                self.signUpOut.isEnabled = true
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "Your account has been created successfully.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        if self.signUpDel != nil{
                            self.signUpDel?.fillFields(email: email, password: password)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SignUpViewController{
    
    @objc func tapDetected() {
        self.selectImage()
    }
    
    func selectImage() {
        var config = YPImagePickerConfiguration()
        config.library.mediaType = .photo
        config.onlySquareImagesFromCamera = false
        config.shouldSaveNewPicturesToAlbum = true
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        //config.showsCrop = .rectangle(ratio: 1.0)
        config.wordings.libraryTitle = "Photos"
        config.showsPhotoFilters = false
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let img = items.singlePhoto?.image{
                self.imageViewOut.image = img
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
}
