//
//  ProfileActionButtonView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/16.
//

import SwiftUI

struct ProfileActionButtonView: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        if viewModel.isSelf() {
            Button(action: {

            }, label: {
                Text("Edit Profile")
                        .frame(width: 360, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
            })
                    .cornerRadius(20)
        } else {
            HStack {
                Button(action: {
                    viewModel.isFollowing() ? viewModel.unfollow(successfulCompletion: { user in

                    }, failureCompletion: { errorMsg in

                    }) : viewModel.follow(successfulCompletion: { user in

                    }, failureCompletion: { errorMsg in

                    })
                }, label: {
                    Text(viewModel.isFollowing() ? "Following" : "Follow")
                            .frame(width: 180, height: 40)
                            .background(Color.blue)
                            .foregroundColor(.white)
                })
                        .cornerRadius(20)

                Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(20)
            }
        }
    }
}
