//
//  LoginView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/22.
//

import SwiftUI

struct LoginView: View {

    @State var username = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel

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
                    CustomTextField(text: $username, placeholder: "Username", imageName: "person", autocapitalization: .none)
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                    CustomSecureField(text: $password, placeholder: "Password")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                }.padding(.horizontal, 32)

                HStack {
                    Spacer()

                    Button(action: {}, label: {
                        Text("Forgot Password?")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, 16)
                                .padding(.trailing, 32)
                    })
                }

                Button(action: {
                    viewModel.signIn(withUsername: username, password: password) { errorMsg in

                    }
                }, label: {
                    Text("Sign In")
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
                    Text("Don't have an account?")
                            .font(.system(size: 16))

                    NavigationLink(
                            destination: RegisterView()
                                    .navigationBarBackButtonHidden(true),
                            label: {
                                Text("Sign Up")
                                        .font(.system(size: 16, weight: .semibold))
                            }
                    )
                }.foregroundColor(.white)
                        .padding(.bottom, 40)
            }.background(Color(#colorLiteral(red: 0.1137796417, green: 0.6296399236, blue: 0.9523974061, alpha: 1)))
                    .ignoresSafeArea()
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
