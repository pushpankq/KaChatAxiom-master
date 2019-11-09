//
//  ViewController.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController,signInFill {
    
    func fillFields(email: String, password: String) {
        self.emailField.text = email
        self.passwordField.text = password
    }
    
    @IBOutlet weak var emailField: textFieldDesign!
    @IBOutlet weak var passwordField: textFieldDesign!
    @IBOutlet weak var signBtnOut: ButtonDesign!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var loginObj:loginRequest!
    var hidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.loader.isHidden = true
        self.loader.hidesWhenStopped = true
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = hidden
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp"{
            let signUpVc = segue.destination as! SignUpViewController
            signUpVc.signUpDel = self
        }
    }
    @IBAction func signUpBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        hidden = true
        self.loader.startAnimating()
        self.signBtnOut.isEnabled = false
        if let email = self.emailField.text, let password = self.passwordField.text{
            self.loginObj = loginRequest(email: email, password: password)
            self.loginObj.loginRequest(completion: {(error, isLogin) in
                self.loader.stopAnimating()
                self.signBtnOut.isEnabled = true
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Success", message: "You are logged into your account.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
                        // setting the login status to true
                        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                        UserDefaults.standard.synchronize()
                        RouteManager.shared.showHome()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    let userActivityObj = user_activity()
                    userActivityObj.isUserActive(isActive: true, completion: {(error) in
                        if let err = error{
                            print(err)
                        }
                    })
                }
            })
        }else{
            let alert = UIAlertController(title: "Alert", message: "Please fill all fields", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

