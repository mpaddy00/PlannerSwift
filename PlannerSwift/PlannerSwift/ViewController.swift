//
//  ViewController.swift
//  PlannerSwift
//
//  Created by user174585 on 6/23/20.
//  Copyright © 2020 Mark Paddy 111876646. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var jank = false
    var globalStr = ""
    var arr2 = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(jank==true){
            return reloadGraph(id: globalStr).count
        }
        return returnClass().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: UITableViewCell.CellStyle.value2, reuseIdentifier: "cellP")
        if(jank==false){
               cell.textLabel?.text = returnClass()[indexPath.row]
                
               return(cell)    }
        else if(jank==true){
       
               cell.textLabel?.text = reloadGraph(id: globalStr)[indexPath.row]
            cell.detailTextLabel?.text=arr2[indexPath.row]
            jank=false
            return(cell)
        }
    return(cell)
    }
    @IBOutlet weak var tableCl:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NSLog("You selected cell number: \(indexPath.row)!")

        let cell = tableView.cellForRow(at: indexPath)

            var toRecreate = (cell?.textLabel?.text)!
            jank=true
            globalStr = toRecreate
            tableView.reloadData()
        
    }
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
                var check = (data.value(forKey:"subjectClass")as! String)
                if !(ary.contains(check))
                {
                    ary.append(data.value(forKey: "subjectClass")as! String)}
                
            }
            }catch{
                print("error at ReturnClass()")
                return(ary)
            }
     return(ary)
 }
    func reloadGraph(id:String)->Array<String>{
        var ary = [String]()
               let formatter = DateFormatter()
         formatter.dateFormat = "MM/dd/yyyy"
        let appDelegate =
                UIApplication.shared.delegate as? AppDelegate
            let context  = appDelegate?.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Plan")
            fetchRequest.predicate = NSPredicate(format: "subjectClass = %@", "\(id)")
            do
            {
                    let result = try context?.fetch(fetchRequest)
                           for data in result as! [NSManagedObject]{
                            var d = data.value(forKey: "date")
                            let dateString = formatter.string(from: d as! Date)
                            arr2.append(dateString)
                            ary.append(data.value(forKey: "subject")as! String)}
                            
                           }catch{
                               return(ary)
                           }
        print(ary)
                    return(ary)
                }
    @IBAction func resetButton(_ sender: Any) {
        jank=false
        arr2.removeAll(keepingCapacity: false)
        tableCl.reloadData()
            
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
}


