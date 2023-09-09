//
//  LoginView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View, KeyboardReadable {
    @StateObject var viewModel : MainViewModel
    @State private var email = ""
    @State private var password = ""
    @State var showPasswordForgot = false
    @State private var errorMessage = ""
    @State private var resetting = false
    @State private var googleAuth = false
    @State private var networkProgress = false
    @Binding var registeringUser : Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Text("Ready to Ride?")
                        .bold()
                        .font(.title)
                        .shadow(radius: 10)
                        .padding(.top)
                    
                    Text("Log in to get started!")
                        .font(.callout)
                        .padding(.bottom)
                    
                    Image(systemName: "person.3.fill")
                        .font(.system(size: 70))
                        .shadow(radius: 10)
                    
                    Text("Use your Email and Password:")
                        .bold()
                }
                .foregroundStyle(.white)
                
                
                
                Group {
                    TextField("Email Address", text: $email)
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                        print("Is keyboard visible? ", newIsKeyboardVisible)
                                        viewModel.keyboardVisible = newIsKeyboardVisible
                                    }
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                        print("Is keyboard visible? ", newIsKeyboardVisible)
                                        viewModel.keyboardVisible = newIsKeyboardVisible
                                    }
                        .onSubmit {
                            withAnimation {
                                authenticate()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation {
                                        viewModel.keyboardVisible = false
                                    }
                                }
                                
                            }
                        }
                }
                .textFieldStyle(RoundedTextFieldStyle())
                
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
                                .foregroundStyle(.blue)
                        }
                    })
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            authenticate()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    viewModel.keyboardVisible = false
                                }
                            }
                            
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 100, height: 40)
                                .foregroundStyle(.blue)
                            
                            if (!networkProgress) {
                            Text("Sign In")
                                .bold()
                                .foregroundStyle(.white)
                            } else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            }
                        }
                    })
                    .padding(.trailing)
                }
                .padding(.top)
                
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
                            registeringUser = true
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 200, height: 40)
                                .foregroundStyle(.green)
                            
                            Text("Sign Up with Email")
                                .bold()
                                .foregroundStyle(.white)
                        }
                    })
                    
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            registeringUser = true
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 200, height: 40)
                                .foregroundStyle(.red)
                            
                            Text("Sign Up with Google")
                                .bold()
                                .foregroundStyle(.white)
                        }
                    })
                    
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            registeringUser = true
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 200, height: 40)
                                .foregroundStyle(.white)
                            
                            Text("Sign Up with Apple")
                                .bold()
                                .foregroundStyle(.black)
                        }
                    })
                }
                
                Spacer()
            }
            .padding(.top, 70)
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
                        .textFieldStyle(RoundedTextFieldStyle())
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                        print("Is keyboard visible? ", newIsKeyboardVisible)
                                        viewModel.keyboardVisible = newIsKeyboardVisible
                                    }
                    
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
                                    .foregroundStyle(.blue)
                                
                                Text("Request Password Reset")
                                    .foregroundStyle(.white)
                                    
                            }
                            .opacity(email.count == 0 ? 0 : 1)
                        }
                    })
                    .disabled(resetting || email.count == 0)
                    .padding()
                    
                    Spacer()
                }
            }
            .alert("Auth Alert", isPresented: .constant(errorMessage != ""), actions: {Button (action: {
                errorMessage = ""}, label: {Text("Ok")})}, message: {Text(errorMessage)})
        }
        .alert("Auth Alert", isPresented: .constant(errorMessage != ""), actions: {Button (action: {
            errorMessage = ""}, label: {Text("Ok")})}, message: {Text(errorMessage)})
    }
    
    func authenticate() {
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
                        let docRef = viewModel.firestoreManager.db.collection("user").document(authResult.user.uid)

                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                viewModel.currentUser = viewModel.firestoreManager.makeUser(document: document)
                            } else {
                                print("User document does not exist for sign in")
                            }
                        }
                    }
                    viewModel.loggedIn = true
                    viewModel.getMyCredits()
                }
                networkProgress = false
            }
        }
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(
                Color(UIColor.systemGray6)
            )
            .clipShape(Capsule(style: .continuous))
    }
}

#Preview {
    LoginView(viewModel: MainViewModel(), registeringUser: .constant(false))
}
