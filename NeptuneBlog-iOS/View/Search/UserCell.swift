//
//  UserCell.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/6.
//

import SwiftUI
import Kingfisher

struct UserCell: View {

    @Environment(\.colorScheme) var colorScheme

    let user: User

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                KFImage(URL(string: user.smallAvatar ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                            .font(.system(size: 14, weight: .semibold))

                    Text(user.name)
                            .font(.system(size: 14))
                }
                        .foregroundColor(colorScheme == .dark ? .white : .black)

                Spacer()
            }

            Divider()
        }
    }
}
