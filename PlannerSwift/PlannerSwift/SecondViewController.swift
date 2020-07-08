//
//  SecondViewController.swift
//  PlannerSwift
//
//  Created by user174585 on 6/21/20.
//  Copyright © 2020 Mark Paddy 111876646. All rights reserved.
//

import UIKit
import CoreData
class SecondViewController: UIViewController {
    var i=0
        private var datePicker: UIDatePicker?
        @IBOutlet weak var dateFld: UITextField!
        override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
            let tapGesture = UITapGestureRecognizer(target: self, action:#selector(viewTapped(gestureRecognizer:)) )
            dateFld.inputView=datePicker
            
            view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
       
      
    }
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFld.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    
    @IBOutlet weak var classFld: UITextField!

    @IBOutlet weak var subjectClassfld: UITextField!
    @IBAction func addButton(_ sender: Any) {
        if(classFld.text != "")
        {
            
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   let context = appDelegate.persistentContainer.viewContext
                   let entity = NSEntityDescription.entity(forEntityName: "Plan", in: context)
                    let newUser = NSManagedObject (entity: entity!, insertInto: context)
                    newUser.setValue(classFld.text, forKey: "subject")
                    newUser.setValue(subjectClassfld.text, forKey: "subjectClass")
            newUser.setValue(datePicker?.date, forKey: "Date")

            
                  do{
                    try context.save()
                    i+=1
                    
                    classFld.text=""
                    subjectClassfld.text=""
                    
                  }catch{
                      print("saving failed")
                  }
 
        }
        self.view.endEditing(true)
}
    @IBAction func deletebutton(_ sender: Any) {
        self.deleteAllData(entity: "Plan")
    }
    func deleteAllData(entity: String)
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Plan", in: context)
    let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
    let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
    do { try context.execute(DelAllReqVar) }
    catch { print(error) }
}
    
    
              }




