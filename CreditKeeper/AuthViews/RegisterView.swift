//
//  RegisterView.swift
//  CreditKeeper
//
//  Created by Nick Molargik on 9/3/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel : MainViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var handle = ""
    @State private var confirmPassword = ""
    

    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [getBackgroundColor(tab: .profile), .black]), center: .center, startRadius: 2, endRadius: 650)
                .ignoresSafeArea()
            
            VStack {
                Button(action: {
                    withAnimation {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }, label: {
                    BackButtonView(text: "Log In Instead", color: Color.white)
                })
                
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
                    
                    ZStack {
                        TextField("Username", text: $handle)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .limitInputLength(value: $handle, length: 20)
                            .padding(.horizontal)
                        
                        Text("\(handle.count)/20")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 30)
                    }
                    SecureField("Password", text: $password)
                        .border(password != confirmPassword ? Color.red : Color.clear)
                        .padding(.horizontal)
                    
                    SecureField("Confirm password", text: $confirmPassword)
                        .border(password != confirmPassword ? Color.red : Color.clear)
                        .padding(.horizontal)
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 350)
                
                if viewModel.authError != "" {
                    ZStack {
                        Rectangle()
                            .frame(width: nil, height: 100)
                            .foregroundStyle(.white)
                            .padding()
                            .cornerRadius(20)
                        
                        Text(viewModel.authError)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .onAppear {
                                playHaptic()
                            }
                    }
                }
                
                Group {
                    Button(action: {
                        playHaptic()
                        withAnimation {
                            print("Registering new user")
                            viewModel.createUser(email: email, password: password, handle: handle) { created in
                                if (created) {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 100, height: 40)
                                .foregroundColor(.blue)
                            
                            Text("Register")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    })
                    .disabled(password != confirmPassword)
                    .padding()
                    
                    Spacer()
                }
            }
            .padding(.top, 70)
            .onDisappear() {
                viewModel.authError = ""
            }
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
    RegisterView(viewModel: MainViewModel())
}
