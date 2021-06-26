//
//  ProfileActionButtonView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/16.
//

import SwiftUI

struct ProfileActionButtonView: View {
    
    @State private var errorMessage = ""
    @State private var showingAlert = false
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        if viewModel.isSelf() {
            Button(action: {
                
            }, label: {
                Text("编辑资料")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
            })
            .cornerRadius(20)
        } else {
            HStack {
                Button(action: {
                    viewModel.isFollowing ? viewModel.unfollow(successfulCompletion: { user in
                        
                    }, failureCompletion: { errorMessage in
                        self.errorMessage = errorMessage
                        self.showingAlert = true
                    }) : viewModel.follow(successfulCompletion: { user in
                        
                    }, failureCompletion: { errorMessage in
                        self.errorMessage = errorMessage
                        self.showingAlert = true
                    })
                }, label: {
                    Text(viewModel.isFollowing ? "关注中" : "关注")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
                
                Text("私信")
                    .frame(width: 180, height: 40)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("\(errorMessage)"), dismissButton: .default(Text("好的")))
            }
        }
    }
}
