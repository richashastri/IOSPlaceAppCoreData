//
//  PlaceDescription.swift
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
//Purpose: The Place Description class
//
// Ser423 Mobile Applications
//see http://pooh.poly.asu.edu/Mobile
//@author Richa Shastri Richa.Shastri@asu.edu
//        Software Engineering, CIDSE, ASU Poly
//@version April 29, 2017

import Foundation

class PlaceDescription{
    
    private var n:String
    
    var name:String {
        set {
            n = name
        }
        get{
            return n
        }
    }
    
    private var des:String
    var description:String{
        set{
            des = description
        }
        get{
            return des
        }
    }
    
    private var categ:String
    var category:String{
        set{
            categ=category
        }
        get{
            return categ
        }
    }
    
    
    private var addTitle:String
    var addressTitle:String{
        set{
            addTitle=addressTitle
        }
        get{
            return addTitle
        }
    }
    
    private var addstreet:String
    var addressStreet:String{
        set{
            addstreet=addressStreet
        }
        get{
            return addstreet
        }
    }
    
    private var elev:Double
    var elevation:Double{
        set{
            elev=elevation
        }
        get{
            return elev
        }
    }
    
    private var lat:Double
    var latitude:Double{
        set{
            lat=latitude
        }
        get{
            return lat
        }
        
    }
    
    private var long:Double
    var longitude:Double{
        set{
            long=longitude
        }
        get{
            return long
        }
    }
    
    private var img:String
    var image:String{
        set{
            img=image
        }
        get{
            return img
        }
    }
    
    
    
    
    public init (name:String,description:String,category:String,addressTitle:String,addressStreet:String,elevation:Double,latitude:Double,longitude:Double,image:String) {
        self.n=name
        self.des=description
        self.categ=category
        self.addTitle=addressTitle
        self.addstreet=addressStreet
        self.elev=elevation
        self.lat=latitude
        self.long=longitude
        self.img = image
        
    }
    
    
    public init (jsonStr: String){
        
        self.n=""
        self.des=""
        self.categ=""
        self.addTitle=""
        self.addstreet=""
        self.elev=0
        self.lat=0
        self.long=0
        self.img = ""
        
        
        
        if let data: NSData = jsonStr.data(using: String.Encoding.utf8) as NSData?{
            do{
                let dict = try JSONSerialization.jsonObject(with: data as Data,options:.mutableContainers) as?[String:AnyObject]
                
                self.n=(dict!["name"] as? String)!
                self.des=(dict!["description"] as? String)!
                
                self.categ=(dict!["category"] as? String)!
                self.addTitle=(dict!["address-title"] as? String)!
                
                self.addstreet=(dict!["address-street"] as? String)!
                
                self.elev=(dict!["elevation"] as? Double)!
                
                self.lat=(dict!["latitude"] as? Double)!
                
                self.long=(dict!["longitude"] as? Double)!
                
                self.img = (dict!["image"] as? String)!
                
                
                
            } catch {
                print("unable to convert Json to a dictionary")
                
            }
        }
    }
    
    public init(dict:[String:Any]){
        self.n = dict["name"] == nil ? "unknown" : dict["name"] as! String
        self.des=dict["description"] == nil ? "unknown" : dict["description"] as! String
        
        self.categ=dict["category"] == nil ? "unknown" : dict["category"] as! String
        self.addTitle=dict["address-title"] == nil ? "unknown" : dict["address-title"] as! String
        self.addstreet=dict["address-street"] == nil ? "unknown" : dict["address-street"] as! String
        
        self.elev=dict["elevation"] == nil ? 0 : dict["elevation"] as! Double
        
        self.lat=dict["latitude"] == nil ? 0 : dict["latitude"] as! Double
        self.long=dict["longitude"] == nil ? 0 : dict["longitude"] as! Double
        self.img = dict["image"] == nil ? "unknown" : dict["image"] as! String
        
        
        
}

}

