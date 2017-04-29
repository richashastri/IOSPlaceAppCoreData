//
//  ViewController.swift
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
//Purpose: The view controller that lists the description of the selected place and contains picker, edit text filed and save button along with great distance value
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version April 29, 2017

import UIKit
import CoreData

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //var place:PlaceLibrary = PlaceLibrary()
    var selectedplace:String = "unknown"
    var allplaces:[NSManagedObject] = [NSManagedObject]()
    var placeobj = [NSManagedObject]()
    var appDel:AppDelegate?
    var mContext:NSManagedObjectContext?
    var selectedlat:Double = 0.0
    var selectedlong: Double=0.0
    
    @IBOutlet weak var nameid: UITextField!
    
    @IBOutlet weak var catid: UITextField!
    @IBOutlet weak var distid: UILabel!
    
    @IBOutlet weak var bearing: UILabel!
    @IBOutlet weak var pickerview: UIPickerView!
    
    //@IBOutlet weak var Nameid: UITextField!
    
    //@IBOutlet weak var catid: UITextField!
    @IBOutlet weak var addsid: UITextField!
    @IBOutlet weak var addtid: UITextField!
    @IBOutlet weak var descid: UITextField!
    @IBOutlet weak var eleid: UITextField!
    
    @IBOutlet weak var imgid: UITextField!
    @IBOutlet weak var longid: UITextField!
    @IBOutlet weak var latid: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appDel = (UIApplication.shared.delegate as! AppDelegate)
        mContext = appDel!.managedObjectContext
        
        
        
        
        if(selectedplace != "unknown"){
            
            
            let selectRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
            selectRequest.predicate = NSPredicate(format: "name == %@",selectedplace)
            do{
                let results = try mContext!.fetch(selectRequest)
                if results.count > 0 {
                    
                    self.selectedlat = ((results[0] as AnyObject).value(forKey: "latitude") as? Double)!
                    self.selectedlong = ((results[0] as AnyObject).value(forKey: "longitude") as? Double)!
                    
                    nameid.text = selectedplace
                    descid.text = (results[0] as AnyObject).value(forKey: "desc") as? String
                    imgid.text = (results[0] as AnyObject).value(forKey: "image") as? String
                    addsid.text = (results[0] as AnyObject).value(forKey: "addressstreet") as? String
                    addtid.text = (results[0] as AnyObject).value(forKey: "addresstitle") as? String
                    catid.text = (results[0] as AnyObject).value(forKey: "category") as? String
                    latid.text = "\(((results[0] as AnyObject).value(forKey: "latitude") as? Double)!)"
                    longid.text = "\(((results[0] as AnyObject).value(forKey: "longitude") as? Double)!)"
                    eleid.text = "\(((results[0] as AnyObject).value(forKey: "elevation") as? Double)!)"
                    
                    
                }
            } catch let error as NSError{
                NSLog("Error selecting student: Error: \(error)")
            }
            
            
            loadpicker()
            pickerview.dataSource = self
            pickerview.delegate = self
            
        }
        
        
    }
    
    func loadpicker()  {
        
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

        
    }
    
    @IBAction func addingfields(_ sender: Any) {
        print("save")
        let myname:String = nameid.text!
        let mydesc:String = descid.text!
        let myimg:String = imgid.text!
        let myadds:String = addsid.text!
        let myaddt:String = addtid.text!
        let mycat:String = catid.text!
        let mylat:Double = Double(latid.text!)!
        let mylong:Double = Double(longid.text!)!
        let myele:Double = Double(eleid.text!)!
        
        
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Place", in: mContext!)
        let aplace = NSManagedObject(entity: entity!, insertInto: mContext)
        aplace.setValue(myname, forKey:"name")
        aplace.setValue(mydesc, forKey:"desc")
        aplace.setValue(myimg, forKey:"image")
        aplace.setValue(myadds, forKey:"addressstreet")
        aplace.setValue(myaddt, forKey:"addresstitle")
        aplace.setValue(mycat, forKey:"category")
        aplace.setValue(mylat, forKey:"latitude")
        aplace.setValue(mylong, forKey:"longitude")
        aplace.setValue(myele, forKey:"elevation")
        do{
            try mContext!.save()
            placeobj.append(aplace)
        } catch let error as NSError{
            NSLog("Error adding student \(myname). Error: \(error)")
        }

        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveid" {
            print("i was called")
            //print(place.names[0])
            let navController = segue.destination as! UINavigationController
            let detailController = navController.viewControllers.first as! TableViewController
            
            //let myviewController:TableViewController = segue.destination as! TableViewController
            //detailController.place = self.place
            //print(place.names[0])
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return self.allplaces.count
            }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.allplaces[row].value(forKey: "name") as? String
        //return String(" ")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let p:String = (self.allplaces[row].value(forKey: "name") as? String)!
        dist(letplace: p)
    }
    
    
    
    func dist(letplace:String) {
        
        var lat1:Double=0.0
        var long1:Double=0.0
        
        let selectRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        selectRequest.predicate = NSPredicate(format: "name == %@",letplace)
        do{
            let results = try mContext!.fetch(selectRequest)
            if results.count > 0 {
                
                lat1 = ((results[0] as AnyObject).value(forKey: "latitude") as? Double)!
                long1 = ((results[0] as AnyObject).value(forKey: "longitude") as? Double)!
                

                
                
            }
        } catch let error as NSError{
            NSLog("Error selecting student: Error: \(error)")
        }

        
        //let lat1 = self.place.placedesc[letplace]!.latitude
        //print(lat1)
        //let lat2 = self.place.placedesc[selectedplace]!.latitude
        //print(lat2)
        
        //let long1 = self.place.placedesc[letplace]!.longitude
        //print(long1)
        //let long2 = self.place.placedesc[selectedplace]!.longitude
        //print(long2)
        
        let R = Double(6371) // Radius of the earth in km
        
        let d = self.selectedlat - lat1
        //print(d)
        
        let p = d.degreesToRadians
        //print(p)
        
        let dLon = (self.selectedlong - long1).degreesToRadians
        //print(dLon)
        
        
        let a = sin(d/2) * sin(d/2) + cos(lat1) * cos(self.selectedlat) * sin(dLon/2) * sin(dLon/2)
        //print(a)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        //print(c)
        let ans = R * c // Distance in km
        //print (ans)
        
        distid.text = String(ans)
        bearing.text = String(ans-self.selectedlat * lat1)
        
        
        
    }
    
}
