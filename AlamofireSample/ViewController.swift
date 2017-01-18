//
//  ViewController.swift
//  AlamofireSample
//
//  Created by rajamohamed on 13/01/17.
//  Copyright © 2017 sedintechnologies. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON




class ViewController: UITableViewController {
    
    var contactArray: Array<Contacts> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func loadContacts(){
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { response in
            if let gfagag = response.result.value{
                print("JSON : \(gfagag)")
                let json  = JSON.init(data:response.data!)
                let list: Array<JSON> = json["contacts"].array!
                print("The size of the contact List before looping is \(list.count)")
                for item in list{
                    let name = item["name"].string
                    let gmail = item["email"].string
                    let contacts = Contacts()
                    contacts.name = name
                    contacts.email = gmail
                    self.contactArray.append(contacts)
                    
                }
                print("The size of the contact List after looping is \(self.contactArray.count)")
                self.tableView.reloadData();
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let contactsItem = contactArray[indexPath.row]
        cell.textLabel?.text = contactsItem.name
        cell.detailTextLabel?.text = contactsItem.email
        return cell
    }
}

