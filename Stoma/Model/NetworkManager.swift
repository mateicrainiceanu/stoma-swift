//
//  NetworkManager.swift
//  Stoma
//
//  Created by Matei Crăiniceanu on 14.05.2023.
//

import Foundation
import SwiftyJSON

struct NetworkManager {
    
    func makePostRequest(urlString: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 203 {
                do {
                    let json = try JSON(data: data)
                    if let errText = json["err"].string {
                        let error = NSError(domain: "mateicrainiceanu.stomapp", code: 100, userInfo: [NSLocalizedDescriptionKey: errText])
                        completion(.failure(error))
                        return
                    }
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    //--- END of the makePostRequest function ---
   
}
//--- END STRUCT
