//
//  ImagePicker.swift
//  Twitter Clone
//
//  Created by Scott Lau on 2021/5/23.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage?

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            parent.image = image
            parent.mode.wrappedValue.dismiss()
        }
    }
}
