//
//  LoginView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel : MainViewModel
    @State private var email = ""
    @State private var password = ""
    @State var showPasswordForgot = false
    @State private var errorMessage = ""
    @State private var resetting = false
    @State private var googleAuth = false
    @State private var networkProgress = false
    @Binding var signingUp : Bool
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .profile), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Group {
                        Text("Ready to Claim Your Credits?")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .shadow(radius: 10)
                            .padding(.top)
                        
                        Text("Log in to get started!")
                            .foregroundStyle(.white)
                            .font(.callout)
                            .padding(.bottom)
                        
                        Image(systemName: "person.3.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 70))
                            .shadow(radius: 10)
                    }
                    
                    Text("Use your Email and Password:")
                        .bold()
                    
                    Group {
                        TextField("Email Address", text: $email)
                            .padding(.horizontal)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .padding(.horizontal)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        Button(action: {
                            showPasswordForgot.toggle()
                            playHaptic()
                            
                        }, label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 150, height: 40)
                                    .foregroundStyle(.white)
                                
                                Text("Lost Password?")
                                    .foregroundColor(.blue)
                            }
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                        if (!networkProgress) {
                            Button(action: {
                                playHaptic()
                                withAnimation {
                                    networkProgress = true
                                    print("Logging in...")
                                    
                                    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                                        if let error = error {
                                            // there was an error logging in
                                            print("Error logging in: \(error)")
                                            self.errorMessage = error.localizedDescription
                                        } else {
                                            self.errorMessage = ""
                                            // user was successfully logged in
                                            if let authResult = authResult {
                                                let userId = authResult.user.uid
                                                
                                                //Get the user's username from Firestore
                                                viewModel.firestoreManager.db.collection("users").document(userId).getDocument { (snapshot, error) in
                                                    if let error = error {
                                                        // there was an error getting the username
                                                        print("Error getting username: \(error)")
                                                    } else {
                                                        // the username was successfully retrieved
                                                        if let snapshot = snapshot, let data = snapshot.data(), let handle = data["handle"] as? String {
                                                            print("Successfully retrieved handle: \(handle)")
                                                            viewModel.currentUser = viewModel.firestoreManager.makeUser(document: snapshot)
                                                        }
                                                    }
                                                }
                                                print("Successfully logged in user: \(userId)")
                                            }
                                            viewModel.loggedIn = true
                                        }
                                        networkProgress = false
                                    }
                                }
                            }, label: {
                                ZStack {
                                    Capsule()
                                        .frame(width: 100, height: 40)
                                        .foregroundColor(.blue)
                                    
                                    Text("Sign In")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                }
                            })
                            .padding(.trailing)
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.top)
                    
                    if errorMessage != "" {
                        ZStack {
                            Rectangle()
                                .frame(width: nil, height: 100)
                                .foregroundStyle(.ultraThinMaterial)
                                .padding()
                                .cornerRadius(20)
                            
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .onAppear {
                                    playHaptic()
                                }
                        }
                    }
                    
                    Rectangle()
                        .frame(width: nil, height: 3)
                        .foregroundStyle(.white)
                        .padding()
                    
                    Group {
                        Text("No Account?")
                            .bold()
                        
                        Button(action: {
                            playHaptic()
                            withAnimation {
                                signingUp = true
                            }
                        }, label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(.blue)
                                
                                Text("Sign Up with Email")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        })
                        
                        Button(action: {
                            playHaptic()
                            withAnimation {
                                signingUp = true
                            }
                        }, label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(.red)
                                
                                Text("Sign Up with Google")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                        })
                        
                        Button(action: {
                            playHaptic()
                            withAnimation {
                                signingUp = true
                            }
                        }, label: {
                            ZStack {
                                Capsule()
                                    .frame(width: 200, height: 40)
                                    .foregroundColor(.white)
                                
                                Text("Sign Up with Apple")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                        })
                    }
                    
                    Spacer()
                }
                .padding(.top, 70)
                
            }
        }
        .sheet(isPresented: $showPasswordForgot) {
            ZStack {
                Color(.black)
                
                VStack {
                    Button(action: {
                        withAnimation {
                            email = ""
                            showPasswordForgot.toggle()
                        }
                    }, label: {
                        BackButtonView(text: "Cancel", color: Color.blue)
                    })
                    
                    Text("Forgot Your Password?")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Text("Provide your account email:")
                    TextField("Account Email:", text: $email)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                    
                    Button(action: {
                        withAnimation {
                            resetting = true
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                if (error?.localizedDescription ?? "" != "") {
                                    errorMessage = error!.localizedDescription
                                } else {
                                    email = ""
                                    showPasswordForgot.toggle()
                                }
                            }
                            resetting = false
                        }
                        
                    }, label: {
                        if (resetting) {
                            ProgressView()
                                .scaleEffect(2)
                            
                        } else {
                            ZStack {
                                Capsule()
                                    .frame(width: 220, height: 50)
                                    .foregroundColor(.blue)
                                
                                Text("Request Password Reset")
                                    .foregroundColor(.white)
                                    
                            }
                            .opacity(email.count == 0 ? 0 : 1)
                        }
                    })
                    .disabled(resetting || email.count == 0)
                    .padding()
                    
                    if errorMessage != "" {
                        ZStack {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .onAppear {
                                    playHaptic()
                                }
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginView(viewModel: MainViewModel(), signingUp: .constant(false))
}
