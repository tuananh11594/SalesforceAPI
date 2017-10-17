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
    
    var resultRequest = [String: Any]()
    
    var accessToken = ""

    @IBOutlet weak var showRequest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
         
    }
    
    func connectAPISalesforce() -> Void {
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
            print("Response result is :",response.result.value!)
            
            debugPrint("Debug Print :", response)
            
            do {
                let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
                self.resultRequest = json as! [String : Any]
            } catch {
                print(error)
            }
            
            if let access_token =  self.resultRequest["access_token"] {
                self.accessToken = access_token as! String
            }
            
        }
    }
    
    @IBAction func btnConnectAPISalesforce(_ sender: UIButton) {
        self.connectAPISalesforce()
    }
    
    @IBAction func btnCallAPI(_ sender: UIButton) {

        let headers: HTTPHeaders = ["Authorization" :"Bearer \(self.accessToken)"]
        
        Alamofire.request("https://tuananh-dev-ed.my.salesforce.com/services/data/v40.0/sobjects/Account", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            // original URL request
            print("Request is :",response.request!)
            
            // HTTP URL response --> header and status code
            print("Response received is :",response.response!)
            
            // server data : example 267 bytes
            print("Response data is :",response.data!)
            
            // result of response serialization : SUCCESS / FAILURE
            print("Response result is :",response.result.value!)
            
            debugPrint("Debug Print :", response)
            
            do {
                let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
               print(json)
            } catch {
                print(error)
            }
            

            
        }

    }
    
    
}

