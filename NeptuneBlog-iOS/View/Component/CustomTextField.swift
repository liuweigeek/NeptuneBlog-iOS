//
//  CustomTextField.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/22.
//

import SwiftUI

struct CustomTextField: View {

    @Binding var text: String
    let placeholder: String
    let imageName: String
    let autocapitalization: UITextAutocapitalizationType

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                        .foregroundColor(Color(.init(white: 1, alpha: 0.87)))
                        .padding(.leading, 40)
            }

            HStack(spacing: 16) {
                Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)

                TextField("", text: $text)
                        .autocapitalization(autocapitalization)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: "Email", imageName: "envelope", autocapitalization: .none)
    }
}
