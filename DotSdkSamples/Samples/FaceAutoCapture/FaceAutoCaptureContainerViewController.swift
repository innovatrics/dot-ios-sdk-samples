import UIKit
import DotFaceCore

class FaceAutoCaptureContainerViewController: ContainerViewController {
    
    init() {
        let provider = PassiveLivenessQualityProvider()
        let configuration = FaceAutoCaptureConfiguration(qualityAttributes: provider.getQualityAttributes())
        let viewController = FaceAutoCaptureViewController.create(configuration: configuration)
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
    
    @MainActor
    private func presentErrorAlert(_ error: Error) {
        let alertController = UIAlertController.createErrorController(errorMessage: "Failed to evaluate detected face: \(error.localizedDescription)")
        present(alertController, animated: true)
    }
}

extension FaceAutoCaptureContainerViewController: FaceAutoCaptureViewControllerDelegate {
    
    func faceAutoCaptureViewController(_ viewController: FaceAutoCaptureViewController, stepChanged captureStepId: CaptureStepId, with detectedFace: DetectedFace?) {}
    
    func faceAutoCaptureViewController(_ viewController: FaceAutoCaptureViewController, captured detectedFace: DetectedFace) {
        Task {
            do {
                let faceAutoCaptureSampleResult = try await DetectedFaceEvaluator().evaluate(detectedFace)
                navigateToResultViewController(faceAutoCaptureSampleResult)
            } catch {
                presentErrorAlert(error)
            }
        }
    }
    
    func faceAutoCaptureViewControllerViewWillAppear(_ viewController: FaceAutoCaptureViewController) {
        viewController.start()
    }
}
