//
//  userActivity.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/20/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct user_activity{
    
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    func isUserActive(isActive: Bool, completion: @escaping (_ error: String?) -> ()){
        self.db.collection("chatUsers").document(self.uid!).updateData(["isActive":String(isActive)], completion: {(error) in
            if let err = error{
                print(err)
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        })
    }
    
    func sendMessage(sid:String, rid:String, sName:String, rName:String, _message:String, completion: @escaping (_ error: String?, _ msg: message?) -> ()){
        let formattedDate = String(Date().timeIntervalSince1970)
        var chatId = String()
        if sid > rid{
            chatId = sid + rid
        }else{
            chatId = rid + sid
        }
        var ref:DocumentReference?
        ref = self.db.collection("messages").addDocument(data: ["sid":sid,"rid":rid, "sName":sName, "rName":rName,"message": _message,"type":"txt", "sDel":"false", "duration":"", "rDel":"false","date":formattedDate,"chatId":chatId], completion: {(error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else{
                self.addToChat(formattedDate: formattedDate, chatId: chatId, sid: sid, rid: rid, sName: sName, rName: rName, message: _message, type: "txt", duration: "", completion: {(error) in
                    if let err = error{
                        completion(err,nil)
                    }else{
                        let msg = message(date: formattedDate, message: _message, rDel: "false", rid: rid, rName: rName, sDel: "false", sid: sid, sName: sName, type: "txt", messageId: ref!.documentID, chatId: chatId, duration: "")
                        completion(nil,msg)
                    }
                })
            }
        })
    }
    
    func sendPicture( sid:String, rid:String, sName:String, rName:String, _message:UIImage, completion: @escaping (_ error: String?, _ msg: message?) -> ()){
        let formattedDate = String(Date().timeIntervalSince1970)
        var chatId = String()
        if sid > rid{
            chatId = sid + rid
        }else{
            chatId = rid + sid
        }
        self.uploadImage(image: _message, completion: {(error,url) in
            var ref:DocumentReference?
            if let err = error{
                completion(err,nil)
            }else if let Url = url{
                ref = self.db.collection("messages").addDocument(data: ["sid":sid,"rid":rid,"sName":sName, "rName":rName,"sDel":"false", "rDel":"false","duration":"","message":Url.absoluteString,"type":"img","date":formattedDate,"chatId":chatId], completion: {(error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        if let err = error{
                            completion(err.localizedDescription,nil)
                        }else {
                            self.addToChat(formattedDate: formattedDate, chatId: chatId, sid: sid, rid: rid, sName: sName, rName: rName, message: Url.absoluteString, type: "img", duration: "", completion: {(error) in
                                if let err = error{
                                    completion(err,nil)
                                }else{
                                    let msg = message(date: formattedDate, message: Url.absoluteString, rDel: "false", rid: rid, rName: rName, sDel: "false", sid: sid, sName: sName, type: "img", messageId: ref!.documentID, chatId: chatId, duration: "")
                                    completion(nil, msg)
                                }
                            })
                        }
                    }
                })
            }
        })
    }
    
    func sendAudio( sid:String, rid:String, sName:String, rName:String, _message:String, duration:String, completion: @escaping (_ error: String?, _ msg: message?) -> ()){
        let formattedDate = String(Date().timeIntervalSince1970)
        var chatId = String()
        if sid > rid{
            chatId = sid + rid
        }else{
            chatId = rid + sid
        }
        self.uploadAudio(audioPath: _message, completion: {(error,url) in
            var ref:DocumentReference?
            if let err = error{
                completion(err,nil)
            }else if let Url = url{
                ref = self.db.collection("messages").addDocument(data: ["sid":sid,"rid":rid,"sName":sName, "rName":rName,"sDel":"false", "rDel":"false", "duration":duration,"message":Url.absoluteString,"type":"audio","date":formattedDate,"chatId":chatId], completion: {(error) in
                    if let err = error{
                        completion(err.localizedDescription,nil)
                    }else{
                        if let err = error{
                            completion(err.localizedDescription,nil)
                        }else {
                            self.addToChat(formattedDate: formattedDate, chatId: chatId, sid: sid, rid: rid, sName: sName, rName: rName, message: Url.absoluteString, type: "audio", duration: duration, completion: {(error) in
                                if let err = error{
                                    completion(err,nil)
                                }else{
                                    let msg = message(date: formattedDate, message: Url.absoluteString, rDel: "false", rid: rid, rName: rName, sDel: "false", sid: sid, sName: sName, type: "audio", messageId: ref!.documentID, chatId: chatId, duration: duration)
                                    completion(nil, msg)
                                }
                            })
                        }
                    }
                })
            }
        })
    }
    
    func addToChat(formattedDate:String,chatId:String, sid:String, rid:String, sName:String, rName:String, message:String, type:String, duration: String, completion: @escaping (_ error:String?) ->()){
        self.db.collection("chat").document(chatId).setData(["sid":sid,"rid":rid,"sName":sName, "rName":rName,"sDel":"false", "rDel":"false","message":message,"type":type,"date":formattedDate,"duration":duration,"chatId":chatId], completion: {(error) in
            if let err = error{
                completion(err.localizedDescription)
            }else{
                completion(nil)
            }
        })
    }
    
    func uploadAudio(audioPath:String?, completion: @escaping (_ error: String?,_ url:URL?) -> ()){
        if staticLinker.uploadProgress != nil{
            staticLinker.uploadProgress.removeAllObservers()
        }
        let audioUpload = Storage.storage().reference().child("audio/\(UUID())\(uid!)")
        staticLinker.uploadProgress = audioUpload.putFile(from: URL(string: audioPath!)!, metadata: nil, completion: { (metadata, error) in
            if let err = error {
                completion(err.localizedDescription,nil)
            }else{
                audioUpload.downloadURL(completion: { (url, error) in
                    if let err = error {
                        completion(err.localizedDescription,nil)
                    }else{
                        completion(nil,url)
                    }
                })
            }
        })
    }
    
    func uploadImage(image:UIImage?, completion: @escaping (_ error: String?,_ url:URL?) -> ()){
        if staticLinker.uploadProgress != nil{
            staticLinker.uploadProgress.removeAllObservers()
        }
        let data = image!.jpegData(compressionQuality: 1.0)
        let imageUpload = Storage.storage().reference().child("Images/\(UUID())\(uid!)/image.jpg")
        staticLinker.uploadProgress = imageUpload.putData(data!, metadata: nil) { (metadata, error) in
            if let err = error {
                completion(err.localizedDescription,nil)
            }else{
                imageUpload.downloadURL(completion: { (url, error) in
                    if let err = error {
                        completion(err.localizedDescription,nil)
                    }else{
                        completion(nil,url)
                    }
                })
            }
        }
    }
    
    func uploadProfileImage( image:UIImage?, completion: @escaping (_ error: String?,_ url:URL?) -> ()){
        let data = image!.jpegData(compressionQuality: 1.0)
        let imageUpload = Storage.storage().reference().child("Images/\(uid!)/image.jpg")
        _ = imageUpload.putData(data!, metadata: nil) { (metadata, error) in
            if let err = error {
                completion(err.localizedDescription,nil)
            }else{
                imageUpload.downloadURL(completion: { (url, error) in
                    if let err = error {
                        completion(err.localizedDescription,nil)
                    }else{
                        completion(nil,url)
                    }
                })
            }
        }
    }
    
    func getAllChats(completion: @escaping (_ error: String?,_ messages:[message]?) -> ()){
        self.db.collection("chat").addSnapshotListener({(snapshot, error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else{
                var temp:messageCodable
                var DataArray = [message]()
                for documents in snapshot!.documents{
                    let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoder = JSONDecoder()
                    do
                    {
                        temp = try decoder.decode(messageCodable.self, from: jsonData)
                        if (temp.sid == self.uid && temp.sDel == "false") || (temp.rid == self.uid && temp.rDel == "false"){
                            DataArray.append(message(date: temp.date!, message: temp.message!, rDel: temp.rDel!, rid: temp.rid!, rName: temp.rName!, sDel: temp.sDel!, sid: temp.sid!, sName: temp.sName!, type: temp.type!, messageId: documents.documentID, chatId: temp.chatId!, duration: temp.duration!))
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                if DataArray.count == 0{
                    completion(nil,nil)
                }else{
                    completion(nil,DataArray)
                }
            }
        })
    }
    
    func getAllUsers(completion: @escaping (_ error: String?,_ messages:[user]?) -> ()){
        self.db.collection("chatUsers").addSnapshotListener({(snapshot, error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else{
                var temp:userCodable
                var DataArray = [user]()
                for documents in snapshot!.documents{
                    let jsonData = try! JSONSerialization.data(withJSONObject: documents.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                    let decoder = JSONDecoder()
                    do
                    {
                        temp = try decoder.decode(userCodable.self, from: jsonData)
                        if documents.documentID != self.uid{
                            DataArray.append(user(email: temp.email!, image: temp.image!, isActive: temp.isActive!, name: temp.name!, userId: documents.documentID))
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                }
                if DataArray.count == 0{
                    completion(nil,nil)
                }else{
                    completion(nil,DataArray)
                }
            }
        })
    }
    
    func getUser(id:String, completion: @escaping (_ error: String?,_ user:user?) -> ()){
        staticLinker.listnerRef1 = self.db.collection("chatUsers").document(id).addSnapshotListener( {(document,error) in
            if let err = error{
                completion(err.localizedDescription,nil)
            }else if let document = document, document.exists {
                let jsonData = try! JSONSerialization.data(withJSONObject: document.data()!, options: JSONSerialization.WritingOptions.prettyPrinted)
                let decoder = JSONDecoder()
                do
                {
                    let temp = try decoder.decode(userCodable.self, from: jsonData)
                    if document.documentID != self.uid{
                        completion(nil,user(email: temp.email!, image: temp.image!, isActive: temp.isActive!, name: temp.name!, userId: document.documentID))
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func getImage(id:String, completion: @escaping (_ error: String?,_ url:String?) -> ()){
        self.db.collection("chatUsers").document(id).getDocument(completion: {(document,error) in
            if let err = error{
                completion(err.localizedDescription,"")
            }else if let document = document, document.exists {
                completion(nil,document.data()!["image"] as? String)
            }
        })
    }
    
}
