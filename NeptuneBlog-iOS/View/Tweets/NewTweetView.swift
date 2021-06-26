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
    let tweetPostedCompletion: (Tweet) -> Void
    @State private var captionText: String = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
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
                    
                    TextArea(text: $captionText, placeholder: "有什么新鲜事?")
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            .navigationBarItems(leading: Button(action: {
                isPresented = false
            }, label: {
                Text("取消")
                    .foregroundColor(.blue)
            }), trailing: Button(action: {
                viewModel.publishTweet(text: captionText, successfulCompletion: { tweet in
                    isPresented = false
                    self.tweetPostedCompletion(tweet)
                }, failureCompletion: { errorMessage in
                    self.errorMessage = errorMessage
                    self.showingAlert = true
                })
            }, label: {
                Text("发推")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }))
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
        }
    }
}
