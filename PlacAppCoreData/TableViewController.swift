//
//  TableViewController.swift
//  PlacAppCoreData
//
//  Created by rshastri on 4/28/17.
//  Copyright © 2017 rshastri. All rights reserved.
//

// Copyright 2017 Richa Shastri
//
//
//I give the full right to Dr lindquist and Arizona State University to build my project and evaluate it or the purpose of determining your grade and program assessment.
//
//Purpose: The TableViewController view which displays the list of places
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version April 29, 2017

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //var place:PlaceLibrary = PlaceLibrary()
    
    var appDel:AppDelegate?
    var mContext:NSManagedObjectContext?
    
    var placeobj = [NSManagedObject]()
    var names: [String] = [String]()
    
    var allplaces:[NSManagedObject] = [NSManagedObject]()

    @IBOutlet var table: UITableView!
    //@IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDel = (UIApplication.shared.delegate as! AppDelegate)
        mContext = appDel!.managedObjectContext
        
        //adddb()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        //display()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        let selectRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        do{
            let results = try mContext!.fetch(selectRequest)
            for res in results {
                if(!allplaces.contains(res as! NSManagedObject)){
                    allplaces.append(res as! NSManagedObject)
                }
            }
        } catch let error as NSError{
            NSLog("Error selecting movie \(title). Error: \(error)")
        }

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    
    func adddb(){
        let name:String = "ASUpoly"
        let category:String = "Polytechnic engineering school"
        let addressstreet:String = "east universioty drive mesa 45667"
        let addresstitle:String = "Mesa Airport"
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: mContext!)
        let aStud = NSManagedObject(entity: entity!, insertInto: mContext)
        aStud.setValue(name, forKey:"name")
        aStud.setValue(category, forKey:"category")
        aStud.setValue(addressstreet, forKey:"addressstreet")
        aStud.setValue(addresstitle, forKey:"addresstitle")
        let name1:String = "ASUWest"
        let category1:String = "west campus engineering school"
        let addressstreet1:String = "east universioty drive pheonix 45667"
        let addresstitle1:String = "Downtown"
        let entity1 = NSEntityDescription.entity(forEntityName: "Place", in: mContext!)
        let aStud1 = NSManagedObject(entity: entity1!, insertInto: mContext)
        aStud1.setValue(name1, forKey:"name")
        aStud1.setValue(category1, forKey:"category")
        aStud1.setValue(addressstreet1, forKey:"addressstreet")
        aStud1.setValue(addresstitle1, forKey:"addresstitle")

        do{
            try mContext!.save()
            placeobj.append(aStud)
            placeobj.append(aStud1)
        } catch let error as NSError{
            NSLog("Error adding student \(name). Error: \(error)")
        }
    
        
    }
    
    func display(){
        let selectRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        
        let aStud = placeobj[1]
        let aname: String = (aStud.value(forKey: "name") as? String)!
        names.append(aname)
        
        
        
        
        
    }
    
    @IBAction func addme(_ sender: UIBarButtonItem) {
        print("addd")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.allplaces.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        //var cell : UITableViewCell = UITableViewCell()
        //cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "tableCell")
        
        
        //cell.textLabel?.numberOfLines = 0
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        //let aStud = names[indexPath.row] as String
        //print(aStud)
        //cell.textLabel?.text = aStud
        
        let p = self.allplaces[indexPath.row]
        cell.textLabel?.text = p.value(forKey: "name") as? String
        //cell.detailTextLabel?.text = self.allMovies[indexPath.row]
        //cell.detailTextLabel?.text = movie.valueForKey("year") as? String
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        print("tableView editing row at: \(indexPath.row)")
        if editingStyle == .delete {
            // Delete the row from the data source
            //var name : String = self.studSelectTF.text!
            let plName = self.allplaces[indexPath.row].value(forKey: "name") as? String
            print(plName)
            let selectRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
            selectRequest.predicate = NSPredicate(format: "name == %@",plName!)
            do{
                let results = try mContext!.fetch(selectRequest)
                if results.count > 0 {
                    mContext!.delete(results[0] as! NSManagedObject)
                    try mContext?.save()
                }
            } catch let error as NSError{
                NSLog("error selecting all students \(error)")
            }
            self.allplaces.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    
}

    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        NSLog("seque identifier is \(segue.identifier)")
        if segue.identifier == "PlaceIdentifier" {
            let viewController:ViewController = segue.destination as! ViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            //viewController.place = self.place
            viewController.selectedplace = (self.allplaces[indexPath.row].value(forKey: "name") as? String)!
        }
        
    }

}
