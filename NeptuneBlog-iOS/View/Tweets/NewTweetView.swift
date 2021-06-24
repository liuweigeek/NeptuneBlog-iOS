//
//  NewTweetView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/20.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    
    @Binding var isPresented: Bool
    @State var captionText: String = ""
    @ObservedObject var viewModel = UploadTweetViewModel()
    @ObservedObject var userSessionManager = UserSessionManager.shared
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    if let user = userSessionManager.user {
                        
                        if let mediumAvatar = user.mediumAvatar {
                            KFImage(URL(string: mediumAvatar))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }
                    }
                    
                    TextArea(text: $captionText, placeholder: "What's happening?")
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }, label: {
                Text("Cancel")
                    .foregroundColor(.blue)
            }), trailing: Button(action: {
                viewModel.publishTweet(text: captionText, successfulCompletion: { tweet in
                    isPresented = false
                }, failureCompletion: { errorMsg in
                    
                })
            }, label: {
                Text("Tweet")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }))
        }
    }
}
