//
//  ViewController.swift
//  coredatademo
//
//  Created by MACOS on 8/26/17.
//  Copyright © 2017 MACOS. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mobile: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func insert1(_ sender: Any) {
        
        let model = NSEntityDescription.insertNewObject(forEntityName: "Studentdata", into: content);
        model.setValue(id.text, forKey: "id")
        model.setValue(name.text, forKey: "name")
        model.setValue(address.text, forKey: "address")
        model.setValue(mobile.text, forKey: "mobile")
        
        do {
            try content.save()
        
        } catch  {
            
        }
    }
    
    @IBAction func update1(_ sender: Any) {
        
        let dic = NSEntityDescription.entity(forEntityName: "Studentdata", in: content)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Studentdata")
        request.entity = dic
        
        let pred = NSPredicate(format: "(id = %@", id.text!)
        request.predicate = pred;
        
        do {
            
            let arr = try content.fetch(request)
            
            if arr.count > 0  {
                let obj = arr[0] as! NSManagedObject
                obj.setValue(self.id.text, forKey: "id")
                obj.setValue(self.name.text, forKey: "name")
                obj.setValue(self.address.text, forKey: "address")
                obj.setValue(self.mobile.text, forKey: "mobile")
                
            }
            
            do {
                try content.save()
                
            } catch  {
            }
        
        } catch  {
        }
        
    }
    
    @IBAction func delete1(_ sender: Any) {
        
        let dic = NSEntityDescription.entity(forEntityName: "Studentdata", in: content)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Studentdata")
        request.entity = dic;
        
        let pred = NSPredicate(format: "(id = %@)", id.text!);
        request.predicate = pred;
        
        do {
            let arr = try content.fetch(request)
            
            if arr.count > 0 {
                let obj = arr[0] as! NSManagedObject
                content.delete(obj)
                
                do {
                    try content.save()
                
                } catch {
                }
                
            }

        } catch  {
        }
        
    }
    @IBAction func select1(_ sender: Any) {
        
        let dic = NSEntityDescription.entity(forEntityName: "Studentdata", in: content)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Studentdata")
        request.entity = dic
        
        let pred = NSPredicate(format: "(id = %@)", id.text!)
        request.predicate = pred
        
        do {
            let arr = try content.fetch(request)
            if arr.count > 0 {
                let obj = arr[0] as! NSManagedObject
                id.text = obj.value(forKey: "id") as? String
                name.text = obj.value(forKey: "name") as? String
                address.text = obj.value(forKey: "address") as? String
                mobile.text = obj.value(forKey: "mobile") as? String
                
            }
            
        } catch  {
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

