//
//  ViewController.swift
//  HelloAlamoFire
//
//  Created by Sebastian Buys on 3/5/19.
//  Copyright © 2019 Sebastian Buys. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // From the Alamofire docs:
        // https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#making-a-request
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request #1: \(String(describing: response.request))")   // original url request
            print("Response #1: \(String(describing: response.response))") // http url response
            print("Result #1: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON #1: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data #1: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        // Another request to the Star Wars API
        Alamofire.request("https://swapi.co/api/people/1/").responseJSON { response in
            print("Request #2: \(String(describing: response.request))")   // original url request
            print("Response #2: \(String(describing: response.response))") // http url response
            print("Result #2: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON #2: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data #2: \(utf8Text)") // original server data as UTF8 string
            }
            
            // Parse using JSONSerialization
            // Parse the response:
            // We should know the shape of the response to cast it correctly:
            // https://swapi.co/api/people/1/
            // {
            //      "name": "LukeSkywalker",
            //      "height": "172",
            //      "films": [
            //          "https://swapi.co/api/films/2/"
            //      ]
            // }
            
            // For this example, we'll just look for name and films:
            
            if let data = response.data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                // At this point jsonObject is of type [String: Any]
                
                // Look for name, which we expect to be a string
                if let nameValue = jsonObject?["name"] as? String {
                    print("The person at swapi.co/api/people/1 is named: \(nameValue)")
                }
                
                // Look for films, which we expect to be an array of string
                if let films = jsonObject?["films"] as? [String] {
                    print("Films with this character include: \(films)")
                }
                
                //
            } else {
                print("Error parsing response")
            }
        }
        
        
    }


}

