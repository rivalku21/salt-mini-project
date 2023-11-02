//
//  UserViewModel.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import Foundation

class UserListViewModel {
    private(set) var users: [UserViewModel] = []
    
    func getAllData() async {
        do {
            let usersData = try await Webservice().getData()
            self.users = usersData.data.map(UserViewModel.init)
            
        } catch {
            print(error)
        }
    }
    
    func postLogin(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let dataToSend = UserLoginModel(email: email, password: password)
        let jsonEncoder = JSONEncoder()
        
        do {
            let jsonData = try jsonEncoder.encode(dataToSend)
            Webservice().postLogin(jsonData:jsonData) { success in
                if success {
                    print("Login was successful")
                    completion(true)
                } else {
                    print("Login failed")
                    completion(false)
                }
            }
        } catch {
            print("Error encoding data to JSON: \(error)")
        }
    }
}

struct UserViewModel {
    
    private let user: UserModel
    
    init(user: UserModel) {
           self.user = user
    }
    
    var email: String {
        user.email
    }
    
    var firstName: String {
        user.first_name
    }
    
    var lastName: String {
        user.last_name
    }
    
    var avatar: String {
        user.avatar
    }
}
