//
//  ViewController.swift
//  SalesforceAPI
//
//  Created by Nguyen Tuan Anh on 10/12/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var resultRequest = [String: Any]()
    
    var accessToken = ""
    
    var listAccounts = [String]()

    @IBOutlet weak var showRequest: UILabel!
    @IBOutlet weak var nameAccountTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.nameAccountTableView.delegate = self
        self.nameAccountTableView.dataSource = self
    
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
        parameters["password"] = "Tolachanh85140ob2wBXlZpkXsAgg3AsYz7gvU"
        
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
            
            var json: [String: Any]!
            
            do {
                json = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String : Any]
                print(json)
                
                if let items = json["recentItems"] as? [[String: Any]] {
                    for item in items {
                        if let name = item["Name"] as? String {
                            self.listAccounts.append(name)
                        }
                    }
                    self.nameAccountTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func btnCreateAcount(_ sender: UIButton) {
        var parameters = [String:String]()
        parameters["Name"] = "alibaba"
        parameters["ShippingCity"] = "Ha Noi"
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(self.accessToken)","Accept":"application/json","Content-Type" :"application/json"]
        
        Alamofire.request("https://tuananh-dev-ed.my.salesforce.com/services/data/v40.0/sobjects/Account", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
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
                self.nameAccountTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func btnDeleteAccount(_ sender: UIButton) {
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(self.accessToken)","Accept":"application/json","Content-Type" :"application/json"]
        
        Alamofire.request("https://tuananh-dev-ed.my.salesforce.com/services/data/v40.0/sobjects/Account/0017F00000DK4ppQAD", method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
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
                self.nameAccountTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func btnUpdateAccount(_ sender: Any) {
        
        var parameters = [String:String]()
        parameters["ShippingCity"] = "Ha Noi"
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(self.accessToken)","Accept":"application/json","Content-Type" :"application/json"]
        
        Alamofire.request("https://tuananh-dev-ed.my.salesforce.com/services/data/v40.0/sobjects/Account/0017F00000DK5VeQAL", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
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
                self.nameAccountTableView.reloadData()
            } catch {
                print(error)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameAccounts = listAccounts[indexPath.row]
        cell.textLabel?.text = nameAccounts
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

