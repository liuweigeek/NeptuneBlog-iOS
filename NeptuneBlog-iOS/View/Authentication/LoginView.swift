//
//  LoginView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    let viewModel = AuthViewModel.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Image("twitter-logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 100)
                    .padding(.top, 88)
                    .padding(.bottom, 32)
                
                VStack(spacing: 20) {
                    CustomTextField(text: $username, placeholder: "用户名", imageName: "person", autocapitalization: .none)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    CustomSecureField(text: $password, placeholder: "密码")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }.padding(.horizontal, 32)
                
                HStack {
                    Spacer()
                    
                    Button(action: {}, label: {
                        Text("忘记密码?")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top, 16)
                            .padding(.trailing, 32)
                    })
                }
                
                Button(action: {
                    viewModel.signIn(withUsername: username, password: password) { errorMessage in
                        self.errorMessage = errorMessage
                        self.showingAlert = true
                    }
                }, label: {
                    Text("登录")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                }).padding(.vertical)
                .padding(.horizontal, 32)
                
                Spacer()
                
                HStack {
                    Text("还没有帐号?")
                        .font(.system(size: 16))
                    
                    NavigationLink(
                        destination: RegisterView()
                            .navigationBarBackButtonHidden(true),
                        label: {
                            Text("立即注册")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    )
                }.foregroundColor(.white)
                .padding(.bottom, 40)
            }
            .background(Color(#colorLiteral(red: 0.1137796417, green: 0.6296399236, blue: 0.9523974061, alpha: 1)))
            .ignoresSafeArea()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
