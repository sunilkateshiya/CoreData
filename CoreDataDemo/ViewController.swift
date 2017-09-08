//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Administrator on 11/04/17.
//  Copyright © 2017 Administrator. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var resultLable: UILabel!
    @IBOutlet weak var fristNameSearchField: UITextField!
    @IBOutlet weak var FristNameField: UITextField!
    
    @IBOutlet weak var LastNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


           
        
    @IBAction func SaveUser(_ sender: AnyObject) {
        
        let appDel:AppDelegate=UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext=appDel.managedObjectContext
        
        let newUser=NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        
        newUser.setValue(self.FristNameField.text, forKey: "fristname")
         newUser.setValue(self.LastNameField.text, forKey: "lastname")
        
        do{
            try context.save()
            FristNameField.text = ""
            LastNameField.text = ""
            
        
        }catch{
            print("Error While Save In Date")
        }
        
        
        
    }
    @IBAction func searchAction(_ sender: AnyObject) {
        
        let appDel:AppDelegate=UIApplication.shared.delegate as! AppDelegate
        let context:NSManagedObjectContext=appDel.managedObjectContext
        
        let request=NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let searchString=self.fristNameSearchField.text!
        
        request.predicate=NSPredicate(format:"fristname == '\(searchString)'")
        
        do{
            let results=try context.fetch(request)
            
            if results.count>0 {
                let fristname=(results[0] as AnyObject).value(forKey: "fristname") as! String
                let lastname=(results[0] as AnyObject).value(forKey: "lastname") as! String
                
                self.resultLable.text=fristname+" "+lastname
            }else{
                
                self.resultLable.text="No Result Found"
                
            }
            
        }catch{
            
        }
        
        
    }
    @IBAction func ShowAllUser(_ sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let secvc : secondViewController=mainStoryboard.instantiateViewController(withIdentifier: "secondVC") as! secondViewController
        
        self.present(secvc,animated:true,completion:nil)
        
        
    }
    
}

