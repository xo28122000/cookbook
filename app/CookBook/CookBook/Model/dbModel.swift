//
//  dbModel.swift
//  firbaseSwiftProj
//
//  Created by Ramy Fekry on 4/16/21.
//

import Foundation
import Firebase
//import FirebaseFirestore


/**
 If you run the app you should see the output of the demo code in the bottom.
 This all is demoed in the LoginViewController.swift > TESTING_RUN()
 */
class dbModel {
    var ref: DatabaseReference!
    
    init?() {
        ref = Database.database().reference()
    }
    
    //used to register a user in firebase.
    func setUserValue(uid: String, username: String) -> Void {
        
        ref.child("/users/\(uid)").setValue([
            "username": username
        ])
    }
    
    //gets a list of users from the database.
    func getAllUsers() -> Any? {
        var result: Any?
        
        ref.child("users").getData() { (error, snapshot) in
            if let error = error {
                print("Error getting data \(error)")
                result = nil
            }
            else if snapshot.exists() {
                print("Got data \(snapshot.value as! NSDictionary)")
                result = snapshot.value
            }
            else {
                print("No data available")
                result = nil
            }
        }
        
        return result
    }
    
    //gets one specific user's info.
    func getUserBy(uid: String) -> Any? {
        var result: Any?
        
        ref.child("users/\(uid)").getData() { (error, document) in
            if let err = error {
                print("error getting all users", err)
                result = nil
            }else {
                print("MEEE", document)
                result = document
            }
            
        }
        return result
        
    }
    
    
    //    func readAsObserver(){
    //        let userID: String? = Auth.auth().currentUser?.uid
    //        print("userID is: ", userID ?? "")
    //
    //    }
    
    
}


/**
 
 // pipeline of saving message for the currently authenticated user on device.
 
 //        let messagesDB = Database.database().reference().child("Messages")
 //
 //        let messageDictionary : NSDictionary = ["Sender" : Auth.auth().currentUser?.email as String? as Any, "MessageBody" : "Hello from MBP"]
 //
 //        messagesDB.childByAutoId().setValue(messageDictionary) {
 //                    (error, ref) in
 //                    if error != nil {
 //                        print(error!)
 //                    }
 //                    else {
 //                        print("Message saved successfully!")
 //                    }
 //               }
 
 
 // Fetching the users (or a certain user ) from db.
 
 //        ref.child("users").child(userID as? String ?? "default value").observeSingleEvent(of: .value, with: { (snapshot) in
 //          // Get user value
 //          let value = snapshot.value as? NSDictionary
 //          let username = value?["username"] as? String ?? ""
 //          let user = User.value(forKey: username)
 //
 //            print("user is coming from db", user)
 //
 //          }) { (error) in
 //            print(error.localizedDescription)
 //        }
 
 
 
 //fetching all users using Result
 //      Result
 //        /\
 //   Error  Optional<City>
 //               /\
 //            Nil  City
 
 //            print("got user by uid as ", document)
 //            result = Result {
 //                document
 //            }
 //
 //
 //            switch result {
 //            case .success(let city):
 //                if let city: AuthorOfMeal = city as? AuthorOfMeal {
 //                    // A `City` value was successfully initialized from the DocumentSnapshot.
 //                    print("City: \(String(describing: city))")
 //                }
 //            case .failure(let error):
 //                // A `City` value could not be initialized from the DocumentSnapshot.
 //                print("Error decoding city: \(error)")
 //            }
 
 
 */
