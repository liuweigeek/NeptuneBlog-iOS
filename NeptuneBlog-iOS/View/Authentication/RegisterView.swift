//
//  RegisterView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/22.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var name = ""
    @State private var showImagePicker = false
    @State private var selectedUIImage: UIImage?
    @State private var image: Image?
    @State private var errorMessage = ""
    @State private var showingAlert = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let viewModel = AuthViewModel.shared
    
    func loadImage() {
        guard let selectedImage = selectedUIImage else {
            return
        }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .padding(.top, 88)
                        .padding(.bottom, 16)
                } else {
                    Image("plus_photo")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFill()
                        .frame(width: 140, height: 140)
                        .padding(.top, 88)
                        .padding(.bottom, 16)
                        .foregroundColor(.white)
                }
            }).sheet(isPresented: $showImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: $selectedUIImage)
            })
            
            VStack(spacing: 20) {
                CustomTextField(text: $email, placeholder: "电子邮箱", imageName: "envelope", autocapitalization: .none)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.15)))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
                CustomTextField(text: $name, placeholder: "昵称", imageName: "person", autocapitalization: .words)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.15)))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                
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
            
            Button(action: {
                let user = User(email: email, username: username, name: name, password: password)
                viewModel.signUp(user: user, profileImage: selectedUIImage ?? nil) { errorMessage in
                    self.errorMessage = errorMessage
                    self.showingAlert = true
                }
            }, label: {
                Text("注册")
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
                Text("已有帐号?")
                    .font(.system(size: 16))
                
                Button(
                    action: {
                        mode.wrappedValue.dismiss()
                    },
                    label: {
                        Text("立即登录")
                            .font(.system(size: 16, weight: .semibold))
                    }
                )
            }.foregroundColor(.white)
            .padding(.bottom, 40)
        }
        .background(Color(#colorLiteral(red: 0.1137796417, green: 0.6296399236, blue: 0.9523974061, alpha: 1)))
        .ignoresSafeArea()
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
