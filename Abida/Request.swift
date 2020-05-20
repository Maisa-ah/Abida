//
//  Request.swift
//  Abida
//
//  Created by Maisa Ahmad on 5/4/20.
//  Copyright © 2020 Maisa Ahmad. All rights reserved.
//

import Foundation

enum PrayerError:Error{
    case noDataAvailable
    case CannotProcess
}

//Makes API request with URLSession
struct PrayerRequest{
    let resourceURL:URL
    init(latitude:String, longitude:String){
        /*timestamp reference: stackoverflow*/
        let timestamp = NSDate().timeIntervalSince1970
        print("this is timestamp:")
        print(timestamp)
        
        let resourceString = "http:api.aladhan.com/v1/timings/\(timestamp)?latitude=\(latitude)&longitude=\(longitude)&method=99"
        
        guard let resourceURL = URL(string: resourceString) else{fatalError()}
        self.resourceURL = resourceURL
    }
    
    
    /*singleton - the static property shared allows urlsessions to be accessed globally*/
    func getTimes(completion: @escaping(Result<Timings, PrayerError>)-> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _, _ in
            //check if json data received
            guard let jsonData = data else{
                completion(.failure(.noDataAvailable))
                return
            }
            do{
                let decoder = JSONDecoder()
                let prayerResponse = try decoder.decode(Prayer.self, from:jsonData)
                //                print("Prayer response \(prayerResponse)")
                let detail = prayerResponse.data.timings
                completion(.success(detail))
                //                print("this is detail")
                //                print(detail)
            }catch{//catch error
                completion(.failure(.CannotProcess))
            }
        }
        dataTask.resume()
    }
}
