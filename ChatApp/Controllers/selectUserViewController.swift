//
//  selectUserViewController.swift
//  ChatApp
//
//  Created by Kashif Rizwan on 8/28/19.
//  Copyright © 2019 Dima Nikolaev. All rights reserved.
//

import UIKit
import SDWebImage

protocol prepareNewChat{
    func fillFields(rid:String, rName:String, performSegue: Bool)
}

class selectUserViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var userListTableView: UITableView!
     var getChatsObj = user_activity()
    private var msg = "Loading..."
    private var userDataList:[user]!
    var fillNewChatDel: prepareNewChat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userListTableView.delegate = self
        self.userListTableView.dataSource = self
        self.userListTableView.rowHeight = UITableView.automaticDimension
        self.userListTableView.reloadData()
        self.userListner()
    }
    
    func userListner(){
        getChatsObj.getAllUsers(completion: {(error, msgs) in
            DispatchQueue.main.async {
                if let err = error{
                    self.msg = err
                    self.userDataList = nil
                    self.userListTableView.reloadData()
                }else{
                    if msgs != nil{
                        self.userDataList = msgs
                        self.userListTableView.reloadData()
                    }else{
                        self.msg = "No Users"
                        self.userDataList = nil
                        self.userListTableView.reloadData()
                    }
                }
            }
        })
    }
}
extension selectUserViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! userTableViewCell
        cell.name.text = self.userDataList[indexPath.row].name
        cell.name.text = self.userDataList[indexPath.row].name
        cell.name.text = self.userDataList[indexPath.row].name
        
        if self.userDataList[indexPath.row].image == ""{
            cell.userImage.image = UIImage(named: "userProfile.jpg")
        }else{
            cell.userImage!.sd_setImage(with: URL(string: self.userDataList[indexPath.row].image), completed: nil)
        }
        if self.userDataList[indexPath.row].isActive == true{
            cell.userImage.borderColor = UIColor(red: 7/255, green: 224/255, blue: 40/255, alpha: 1.0)
        }else{
            cell.userImage.borderColor = UIColor(red: 71/255, green: 92/255, blue: 102/255, alpha: 1.0)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSection: NSInteger = 0
        
        if self.userDataList != nil {
            self.userListTableView.tableFooterView = UIView()
            numOfSection = 1
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.userListTableView.bounds.size.width, height: self.userListTableView.bounds.size.height))
            noDataLabel.text = msg
            noDataLabel.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.center
            self.userListTableView.tableFooterView = noDataLabel
        }
        return numOfSection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.fillNewChatDel != nil{
            self.fillNewChatDel?.fillFields(rid: self.userDataList[indexPath.row].userId, rName: self.userDataList[indexPath.row].name, performSegue: true)
            self.navigationController?.popViewController(animated: true)
        }
        self.userListTableView.deselectRow(at: indexPath, animated: true)
    }
}
