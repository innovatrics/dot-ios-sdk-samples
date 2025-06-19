import UIKit
import DotFaceCore

class FaceAutoCaptureContainerViewController: ContainerViewController {
    
    struct NoFaceDetectedError: LocalizedError {
        var errorDescription: String? { return "No face detected." }
    }
    
    init() {
        
        let faceDetectionQuery = FaceDetectionQuery(
            faceQuality: .init(
                imageQuality: .init(
                    evaluateSharpness: true,
                    evaluateBrightness: true,
                    evaluateContrast: true,
                    evaluateUniqueIntensityLevels: true,
                    evaluateShadow: true,
                    evaluateSpecularity: true
                ),
                headPose: .init (
                    evaluateRoll: true,
                    evaluateYaw: true,
                    evaluatePitch: true
                ),
                wearables: .init (
                    evaluateGlasses: true
                ),
                expression: .init (
                    eyes: .init(
                        evaluateRightEye: true,
                        evaluateLeftEye: true
                    ),
                    evaluateMouth: true
                )
            )
        )
        let viewController = FaceAutoCaptureViewController(configuration: try! .init(query: faceDetectionQuery))
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.face_auto_capture.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    @MainActor
    private func navigateToResultViewController(_ faceAutoCaptureSampleResult: FaceAutoCaptureSampleResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let resultViewController = SampleResultViewController(sampleResult: faceAutoCaptureSampleResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension FaceAutoCaptureContainerViewController: FaceAutoCaptureViewControllerDelegate {
    
    func faceAutoCaptureViewController(_ viewController: FaceAutoCaptureViewController, captured result: FaceAutoCaptureResult) {
        Task {
            let faceAutoCaptureSampleResult = await DetectedFaceEvaluator().evaluate(
                image: result.bgrRawImage,
                detectedFace: result.face!
            )
            navigateToResultViewController(faceAutoCaptureSampleResult)
        }
    }
        
    func faceAutoCaptureViewControllerViewWillAppear(_ viewController: FaceAutoCaptureViewController) {
        viewController.start()
    }
}
