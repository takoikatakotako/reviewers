import SwiftUI
import PhotosUI

struct PostImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var images: [UIImage]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<PostImagePicker>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PostImagePicker>) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        let parent: PostImagePicker

        init(_ parent: PostImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()

            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    guard let image = image as? UIImage else {
                        return
                    }
                    DispatchQueue.main.sync {
                        self?.parent.images.append(image)
                    }
                }
            }
        }
    }
}
