import UIKit
import AVFoundation

class BarcodeScannerPreview: UIView {
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()

    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
}

import SwiftUI

struct BarcodeScannerView: UIViewRepresentable {
    let foundCode: (_ code: String) -> Void

    private let session = AVCaptureSession()
    private let metadataOutput = AVCaptureMetadataOutput()

    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let foundCode: (_ code: String) -> Void

        init(_ foundCode: @escaping (_ code: String) -> Void) {
            self.foundCode = foundCode
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let value = readableObject.stringValue else { return }
                foundCode(value)
            }
        }
    }

    func setupCamera(_ uiView: BarcodeScannerPreview, context: Context) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo

                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)

                    metadataOutput.metadataObjectTypes = [.ean8, .ean13]
                    metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer

                DispatchQueue.global(qos: .userInitiated).async {
                    session.startRunning()
                }
            }
        }
    }

    func makeUIView(context: Context) -> BarcodeScannerPreview {
        let cameraView = BarcodeScannerPreview(session: session)

        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(cameraView, context: context)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(cameraView, context: context)
                    }
                }
            }
        }
        return cameraView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(foundCode)
    }

    static func dismantleUIView(_ uiView: BarcodeScannerPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }

    func updateUIView(_ uiView: BarcodeScannerPreview, context: Context) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
