//
//  ViewController.swift
//  SalesforceAPI
//
//  Created by Nguyen Tuan Anh on 10/12/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.performPOSTLogin()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
         
    }
    
    func performPOSTLogin() -> Void {
        var parameters = [String:String]()
        parameters["grant_type"] = "password"
        parameters["client_id"] = "3MVG9d8..z.hDcPKzynfxKS2SDf8B5mXB9_xg3zVZqr6GH0IU2XEoOZAtJGmxhNyRePlVyGg9QMSEVSt1QOTa"
        parameters["client_secret"] = "8884643420454483631"
        parameters["username"] = "anh.nguyen2@niteco.com"
        parameters["password"] = "Tolachanh85144V6sqRV1d6eCs20ntpZ3ft7fj"
        
        let headers: HTTPHeaders = ["Content-Type" :"application/x-www-form-urlencoded"]
        
        Alamofire.request("https://login.salesforce.com/services/oauth2/token", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            // original URL request
            print("Request is :",response.request!)
            
            // HTTP URL response --> header and status code
            print("Response received is :",response.response!)
            
            // server data : example 267 bytes
            print("Response data is :",response.data!)
            
            // result of response serialization : SUCCESS / FAILURE
            print("Response result is :",response.result)
            
            debugPrint("Debug Print :", response)
        }
    }
    


}

