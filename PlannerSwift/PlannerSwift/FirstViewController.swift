//
//  FirstViewController.swift
//  PlannerSwift
//
//  Created by user174585 on 6/21/20.
//  Copyright © 2020 Mark Paddy 111876646. All rights reserved.
//

import UIKit
import CoreData
var hide = false;
var list = [Plan]()
class FirstViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var arr2=[String]()
    var arr3=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.

    }
    //returns number of entries in Coredata
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (hide == true){
            return returnDateShort().count
        }
        return returnPlan().count }
    
    @IBAction func resetButton(_ sender: Any) {
        hide = false
        arr2.removeAll(keepingCapacity: false)
        arr3.removeAll(keepingCapacity: false)
        tableViewFirst.reloadData()
    }
    //function to populate the list
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: "cellP")
        if(hide == true){
            let curD = Date()
            
            if( returnD()[indexPath.row] < curD){
                
                    cell.textLabel?.text = arr2[indexPath.row]
                    let conjoin = (arr3[indexPath.row] + " "+returnDateShort()[indexPath.row] )
            cell.detailTextLabel?.text = conjoin
        

                return(cell)}
                
        }
        cell.textLabel?.text = returnPlan()[indexPath.row]
        var conjoin = (returnClass()[indexPath.row] + " "+returnDate()[indexPath.row] )
        cell.detailTextLabel?.text = conjoin
        
        return(cell)

    }
    //insert datalabel into cell

    //function for deleting a specific row by swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let cell = tableView.cellForRow(at: indexPath)

            var toDelete = (cell?.textLabel?.text)!
            deleteFeed(id: toDelete)
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableViewFirst: UITableView!
        @IBAction func hideOverdue(_ sender: Any) {
        hide=true
        tableViewFirst.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableViewFirst.reloadData()
    }
    //returns all subject entries in a String Array
     func returnPlan()->Array<String>
       {
        var ary = [String]()
                   let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
           request.returnsObjectsAsFaults=false
           do{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context  = appDelegate.persistentContainer.viewContext
               let result = try context.fetch(request)
               for data in result as! [NSManagedObject]{

                ary.append(data.value(forKey: "subject")as! String)}
               }catch{
                   return(ary)
               }
        return(ary)
    }
    //returns all class entries in a String array
       
      func returnClass()->Array<String>
        {
         var ary = [String]()
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
            request.returnsObjectsAsFaults=false
            do{
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context  = appDelegate.persistentContainer.viewContext
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject]{
                 
                 ary.append(data.value(forKey: "subjectClass")as! String)}
                }catch{
                    print("error at ReturnClass()")
                    return(ary)
                }
         return(ary)
     }
    func returnDate()->Array<String>
       {
        var ary = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
           request.returnsObjectsAsFaults=false
           do{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context  = appDelegate.persistentContainer.viewContext
               let result = try context.fetch(request)
               for data in result as! [NSManagedObject]{
                var d = data.value(forKey: "date")
                let dateString = formatter.string(from: d as! Date)
                ary.append(dateString)}
               }catch{
                   print("error at ReturnClass()")
                   return(ary)
               }
        return(ary)
    }
    func returnD()->Array<Date>
       {
        var ary = [Date]()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
           request.returnsObjectsAsFaults=false
           do{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context  = appDelegate.persistentContainer.viewContext
               let result = try context.fetch(request)
               for data in result as! [NSManagedObject]{
                var d = data.value(forKey: "date")
                ary.append(d as! Date)}
               }catch{
                   print("error at ReturnClass()")
                   return(ary)
               }
        return(ary)
    }
    func returnDateShort()->Array<String>
       {
        var ary = [String]()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
           request.returnsObjectsAsFaults=false
           do{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context  = appDelegate.persistentContainer.viewContext
               let result = try context.fetch(request)
               for data in result as! [NSManagedObject]{
                var e = data.value(forKey: "date")
                var f = Date()
                if( e as! Date > f as! Date){
                    var d = data.value(forKey: "date")
                    let dateString = formatter.string(from: d as! Date)
                    arr2.append(data.value(forKey:"subject") as! String)
                    arr3.append(data.value(forKey:"subjectClass") as! String)
                    ary.append(dateString)}}
                    
               }catch{
                   print("error at ReturnClass()")
                   return(ary)
               }
        return(ary)
    }
    func deleteFeed(id:String)
{
    let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
    let context  = appDelegate?.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
    fetchRequest.predicate = NSPredicate(format: "subject = %@", "\(id)")
    do
    {
        let fetchedResults =  try context!.fetch(fetchRequest) as? [NSManagedObject]

        for entity in fetchedResults! {

            context?.delete(entity)
        }
    }
    catch _ {
        print("Could not delete")

    }
}
    
}
 
