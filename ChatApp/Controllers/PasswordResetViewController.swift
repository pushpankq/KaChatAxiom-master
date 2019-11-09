//
//  PasswordResetViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 8/3/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var email: textFieldDesign!
    @IBOutlet weak var submitBtnOut: ButtonDesign!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        self.loader.startAnimating()
        self.submitBtnOut.isEnabled = false
        if let email = self.email.text{
            Auth.auth().sendPasswordReset(withEmail: email, completion: {(error) in
                self.loader.stopAnimating()
                self.submitBtnOut.isEnabled = true
                if let err = error{
                    let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "Please check your email inbox.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please enter your email address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
