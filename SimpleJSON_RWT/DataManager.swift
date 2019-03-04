//
//  DataManager.swift
//  SimpleJSON_RWT
//
//  Created by Richard Tanner on 3/4/19.
//  Copyright © 2019 Richard Tanner. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    let MYJSONURL = "https://api.myjson.com/bins/136w0u"
    
    var dataArray = ["No data yet, Captain!"]
    
    func getData(completion: @escaping (_ success: Bool) -> ()) {
        var success = true
        
        let actualUrl = URL(string: MYJSONURL)
        
        let task = URLSession.shared.dataTask(with: actualUrl!) { (data, response, error) in
            
            guard let _ = data, error == nil else {
                // we had an error or the data didn't come back
                success = false
                return
            }
            
            
            /********* NEW GOODNESS *********/
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj!.value(forKey: "characters")!)
                
                //getting the characters tag array from json and converting it to NSArray
                if let veggieArray = jsonObj!.value(forKey: "characters") as? Array<String> {
                    self.dataArray = veggieArray
                }
            }
            /********* /NEW GOODNESS *********/
            
            
            // old code to print the things
//            if let successfulData = data {
//                print(String(data: successfulData, encoding: String.Encoding.ascii))
//            }
            
            
            // call back to the completion handler that was passed in, notifying to do things (we don't care what)
            completion(success)
        }
        task.resume()
        
    }
    

}
