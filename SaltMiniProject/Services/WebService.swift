//
//  WebServices.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import Foundation

enum UsersError: Error {
    case invalidServerResponse
}

class Webservice {
    func getData() async throws -> DataModel {
        let url = URL(string: "\(Constants.Urls.reqres)users?page=2")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw UsersError.invalidServerResponse
              }
        
        let decoder = JSONDecoder()
        let dataResponse = try decoder.decode(DataModel.self, from: data)
        
        return dataResponse
    }
    
    func postLogin(jsonData: Data, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: URL(string: "\(Constants.Urls.reqres)login")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false)
            } else if let httpResponse = response as? HTTPURLResponse {
                if 200 ..< 300 ~= httpResponse.statusCode {
                    print("Success")
                    completion(true)
                } else {
                    print("Response status code: \(httpResponse.statusCode)")
                    completion(false)
                }
            }
        }
        
        // Start the data task to send the request
        task.resume()
    }
}
