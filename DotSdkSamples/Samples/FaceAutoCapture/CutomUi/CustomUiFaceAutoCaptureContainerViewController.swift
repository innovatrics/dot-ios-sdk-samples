import DotFaceCore
import DotFaceCommons
import UIKit

final class CustomUiFaceAutoCaptureContainerViewController:
    ContainerViewController
{
    private let phaseView = FaceAutoCapturePhaseView()

    init() {
        let viewController = BaseFaceAutoCaptureViewController.create()
        super.init(viewController: viewController)
        viewController.delegate = self
        viewController.view.backgroundColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.custom_ui.face_auto_capture.title", comment: "")
        view.backgroundColor = .systemBackground
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(phaseView)
        phaseView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            phaseView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phaseView.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
            phaseView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            phaseView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 25),
            phaseView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -25),
            phaseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
        ])
    }
    
    @MainActor
    private func navigateToResultViewController(_ faceAutoCaptureSampleResult: FaceAutoCaptureSampleResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let resultViewController = SampleResultViewController(sampleResult: faceAutoCaptureSampleResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension CustomUiFaceAutoCaptureContainerViewController: FaceAutoCaptureViewControllerDelegate {
    
    func faceAutoCaptureViewController(_ viewController: BaseFaceAutoCaptureViewController, finished result: FaceAutoCaptureResult) {
        Task {
            let faceAutoCaptureSampleResult = await DetectedFaceEvaluator().evaluate(
                image: result.image,
                detectedFace: result.face!
            )
            navigateToResultViewController(faceAutoCaptureSampleResult)
        }
    }
    
    func faceAutoCaptureViewController(_ viewController: BaseFaceAutoCaptureViewController, uiStateUpdated uiState: FaceAutoCaptureUiState) {
        if let running = uiState as? FaceAutoCaptureUiState.Running, let phase = running.phase?.phase {
            switch phase {
            case .preCandidateSelection: phaseView.state = .visible(text: phase.labelText, textColor: .black, backgroundColor: .white)
            case .candidateSelection: phaseView.state = .visible(text: phase.labelText, textColor: .black, backgroundColor: .systemGreen)
            @unknown default: phaseView.state = .hidden
            }
        } else {
            phaseView.state = .hidden
        }
    }
        
    func faceAutoCaptureViewControllerViewWillAppear(_ viewController: BaseFaceAutoCaptureViewController) {
        viewController.start()
    }
}

extension FaceAutoCapturePhase {
    
    var labelText: String {
        switch self {
        case .preCandidateSelection: return "Pre-Candidate Selection"
        case .candidateSelection: return "Candidate Selection"
        @unknown default: return "Unknown Phase"
        }
    }
}
