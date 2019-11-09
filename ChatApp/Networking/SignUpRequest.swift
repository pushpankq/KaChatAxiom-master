//
//  File.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class SignUpRequest{
    
    let db = Firestore.firestore()
    
    private var name:String
    private var email:String
    private var password:String
    private var picUpload = user_activity()
    
    init(name:String, email:String, password:String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func signUpRequest(image:UIImage?, completion: @escaping (_ error: String? , _ isLogin: Bool?) -> ()){
        Auth.auth().createUser(withEmail: self.email, password: self.password, completion: {(user, error) in
            if let err = error{
                completion(err.localizedDescription,false)
            }else{
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.name
                changeRequest?.commitChanges(completion: {(error) in
                    if let _ = error{
                        completion(nil,false)
                    }else{
                        self.createUser(image: image, completion: {(error) in
                            if let err = error{
                                completion(err,false)
                            }else{
                                completion(nil,true)
                            }
                        })
                    }
                })
            }
        })
    }
    private func createUser(image:UIImage?, completion: @escaping (_ error: String?) -> ()){
        if let img = image{
            self.picUpload.uploadProfileImage(image:img, completion: {(error,url) in
                if let err = error{
                    completion(err)
                }else if let Url = url{ self.db.collection("chatUsers").document(Auth.auth().currentUser!.uid).setData(["email":self.email,"name":self.name,"isActive":"false","image": Url.absoluteString], completion: {(error) in
                        if let err = error{
                            completion(err.localizedDescription)
                        }else{
                            completion(nil)
                        }
                    })
                }
            })
        }else{
            self.db.collection("chatUsers").document(Auth.auth().currentUser!.uid).setData(["email":self.email,"name":self.name, "isActive":"false","image":""], completion: {(error) in
                if let err = error{
                    completion(err.localizedDescription)
                }else{
                    completion(nil)
                }
            })
        }
    }
    
}
