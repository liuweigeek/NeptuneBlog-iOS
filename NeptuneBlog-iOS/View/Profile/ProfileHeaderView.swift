//
//  ProfileHeaderView.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/16.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {

    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            
            if let mediumAvatar = viewModel.user?.mediumAvatar {
                KFImage(URL(string: mediumAvatar))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(color: .black, radius: 6)
            } else {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
            }

            Text(viewModel.user?.name ?? "")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.top, 8)

            Text("@\(viewModel.user?.username ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)

            Text("Billionaire by day, dark knight by night")
                    .font(.system(size: 14))
                    .padding(.top, 8)

            HStack(spacing: 40) {
                VStack {
                    Text(String(viewModel.user?.followingCount ?? 0))
                            .font(.system(size: 16))
                            .bold()

                    Text("Following")
                            .font(.footnote)
                            .foregroundColor(.gray)
                }

                VStack {
                    Text("\(String(viewModel.user?.followersCount ?? 0))")
                            .font(.system(size: 16))
                            .bold()

                    Text("Followers")
                            .font(.footnote)
                            .foregroundColor(.gray)
                }
            }
                    .padding()

            ProfileActionButtonView(viewModel: viewModel)

            Spacer()
        }
    }
}
