//
//  RegisterView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel : MainViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var handle = ""
    @State private var confirmPassword = ""
    @State private var networkProgress = false
    @Binding var registeringUser : Bool
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    registeringUser = false
                }
            }, label: {
                BackButtonView(text: "Log In Instead", color: Color.white)
            })
            
            Spacer()
            
            Text("Register as a New User")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 20)

            Group {
                TextField("Email Address", text: $email)
                    .padding(.horizontal)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                    print("Is keyboard visible? ", newIsKeyboardVisible)
                                    viewModel.keyboardVisible = newIsKeyboardVisible
                                }
                
                ZStack {
                    TextField("Username", text: $handle)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .limitInputLength(value: $handle, length: 20)
                        .padding(.horizontal, 15)
                        .padding(.top, 3)
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                        print("Is keyboard visible? ", newIsKeyboardVisible)
                                        viewModel.keyboardVisible = newIsKeyboardVisible
                                    }
                    
                    Text("\(handle.count)/20")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 30)
                }
                SecureField("Password", text: $password)
                    .border(password != confirmPassword ? Color.red : Color.clear)
                    .padding(.horizontal)
                    .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                    print("Is keyboard visible? ", newIsKeyboardVisible)
                                    viewModel.keyboardVisible = newIsKeyboardVisible
                                }
                
                SecureField("Confirm password", text: $confirmPassword)
                    .border(password != confirmPassword ? Color.red : Color.clear)
                    .padding(.horizontal)
                    .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                                    print("Is keyboard visible? ", newIsKeyboardVisible)
                                    viewModel.keyboardVisible = newIsKeyboardVisible
                                }
            }
            .textFieldStyle(RoundedTextFieldStyle())
            .frame(maxWidth: 350)
            
            if (!networkProgress) {
                Group {
                    Button(action: {
                        networkProgress = true
                        playHaptic()
                        withAnimation {
                            print("Registering new user")
                            viewModel.createUser(email: email, password: password, handle: handle) { created in
                                if (created) {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                networkProgress = false
                            }
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 100, height: 40)
                                .foregroundStyle(.blue)
                            
                            Text("Register")
                                .bold()
                                .foregroundStyle(.white)
                        }
                    })
                    .disabled(password != confirmPassword)
                    .padding()
                    
                    Spacer()
                }
            } else {
                ProgressView()
            }
        }
        .padding(.top, 50)
        .alert("Auth Alert", isPresented: .constant(viewModel.authError != ""), actions: {Button (action: {
            viewModel.authError = ""}, label: {Text("Ok")})}, message: {Text(viewModel.authError)})
        .onDisappear() {
            viewModel.authError = ""
        }
    }
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

#Preview {
    RegisterView(viewModel: MainViewModel(), registeringUser: .constant(true))
}
