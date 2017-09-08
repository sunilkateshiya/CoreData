//
//  secondViewController.swift
//  CoreDataDemo
//
//  Created by Administrator on 11/04/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import CoreData


class secondViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTable: UITableView!
    var userArray=[String]()
    
    override func viewDidLoad() {
        self.myTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.fatchData()
        self.myTable.reloadData()
    }
    
    func fatchData() {
        
        let appDel:AppDelegate=UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext=appDel.managedObjectContext
        
        do{
            let request=NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            let result=try context.fetch(request)
            
            
            for items in result as! [NSManagedObject]{
                
                let fristname = items.value(forKey: "fristname") as! String
                let lastname = items.value(forKey: "lastname") as! String
                
                self.userArray.append(fristname+" "+lastname)
            }
            
        }catch{
            
            print("Error While Fatching..")
            
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        cell.textLabel?.text=self.userArray[indexPath.row]
        
        return cell
    }

    @IBAction func goBack(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
   }
