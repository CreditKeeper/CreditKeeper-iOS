//
//  MainViewModel_Auth.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/7/23.
//

import Foundation
import Firebase
import SwiftUI

extension MainViewModel {
    
    func createUser(email: String, password: String, handle: String, _ completion: @escaping (Bool) -> Void) {
        usernameIsAvailable(username: handle, { available in
            if (!available) {
                self.authError = "Username is already in use."
                completion(false)
                return
            } else {
                Task.init {
                    do {
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                // there was an error creating the user
                                print("Error creating user: \(error)")
                                self.authError = error.localizedDescription
                            } else {
                                self.authError = ""
                                // user was successfully created
                                if let authResult = authResult {
                                    print("Successfully created user: \(authResult.user)")
                                    self.loggedIn = true
                                    self.showAuth = false
                                    let newUser = User(id: UUID().uuidString, handle: handle, email: email, favPark: "", admin: false, joined: Date())
                                    self.currentUser = newUser
                                    self.writeUserDocument(user: self.currentUser!)
                                    completion(true)
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func writeUserDocument(user: User) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(user.id)
        
        userRef.setData(["handle": user.handle,"email": self.currentUser?.email ?? "", "bio": "", "admin": false, "pro": false, "authID": self.currentUser?.id ?? ""]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func initUser(user: FirebaseAuth.User?) {
        withAnimation {
            self.loggedIn = true
            self.showAuth = false
        }
        
        let userDocRef = Firestore.firestore().collection("user").document(user!.uid)
        userDocRef.getDocument { (snapshot, error) in
            if error == nil && snapshot?.exists == false {
                self.authError = "An error has occured. Network connection lost or no account found!"
            } else if snapshot?.exists == true {
                self.currentUser = self.firestoreManager.makeUser(document: snapshot!)
            }
        }
    }
    
    func usernameIsAvailable(username: String, _ completion: @escaping (Bool) -> Void) {
        // Get a reference to the users collection
        let db = Firestore.firestore()
        let usersRef = db.collection("user")
        
        // Create a query to get the user document with the specified username
        let query = usersRef.whereField("username", isEqualTo: username)
        
        // Get the query snapshot
        query.getDocuments() { snapshot, error in
            if let error = error {
                // there was an error querying the collection
                print("Error querying users collection: \(error)")
                completion(false)
            } else {
                // check if a user document with the specified username was found
                if snapshot!.documents.count > 0 {
                    // a user document with the specified username already exists
                    print("A user with the username '\(username)' already exists.")
                    completion(false)
                } else {
                    // the username is available
                    completion(true)
                }
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            withAnimation {
                self.loggedIn = false
                self.currentUser = nil
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateHandle(to handle: String) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(self.currentUser!.id)
        let oldHandle = (self.currentUser?.handle)!
        self.currentUser?.handle = handle // preemptively set the local username property,
        
        userRef.updateData(["handle": handle]) { err in
            if let err = err {
                self.currentUser?.handle = oldHandle
                print("Error writing new user handle: \(err)")
            } else {
                print("New handle successfully written!")
            }
        }
    }
}
