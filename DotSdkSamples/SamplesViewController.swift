import UIKit
import DotDocument
import DotFaceCore

class SamplesViewController: UIViewController {

    private let buttonFactory = ButtonFactory()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    
    private lazy var documentAutoCaptureButton = buttonFactory.create(.documentAutoCapture)
    private lazy var nfcReadingButton = buttonFactory.create(.nfcReading)
    private lazy var faceAutoCaptureButton = buttonFactory.create(.faceAutoCapture)
    private lazy var smileLivenessButton = buttonFactory.create(.smileLiveness)
    private lazy var magnifEyeLivenessButton = buttonFactory.create(.magnifEyeLiveness)
    private lazy var faceMatcherButton = buttonFactory.create(.faceMatcher)
    
    private lazy var buttons: [UIButton] = [documentAutoCaptureButton,
                                            nfcReadingButton,
                                            faceAutoCaptureButton,
                                            smileLivenessButton,
                                            magnifEyeLivenessButton,
                                            faceMatcherButton]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("samples.title", comment: "")
        view.backgroundColor = .systemBackground
        
        setupSubviews()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        refreshButtonColors()
    }
}

extension SamplesViewController {
    
    @objc private func showDocumentAutoCapture() {
        let viewController = DocumentAutoCaptureContainerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showNfcReading() {
        let viewController = NfcReadingDocumentAutoCaptureContainerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showFaceAutoCapture() {
        guard checkDotFaceIsInitialized() else { return }
        
        let viewController = FaceAutoCaptureContainerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showMagnifEyeLiveness() {
        let viewController = MagnifEyeLivenessContainerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showSmileLiveness() {
        guard checkDotFaceIsInitialized() else { return }
        
        let viewController = SmileLivenessContainerViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func showFaceMatcher() {
        guard checkDotFaceIsInitialized() else { return }
        
        let viewController = FaceMatchingViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SamplesViewController {
    
    private func checkDotFaceIsInitialized() -> Bool {
        if DotFaceLibrary.shared.isInitialized {
            return true
        } else {
            let alertController = UIAlertController.createErrorController(errorMessage: "DotFace is not initialized.")
            present(alertController, animated: true)
            return false
        }
    }
    
    private func refreshButtonColors() {
        buttons.forEach { $0.layer.borderColor = UIColor.label.cgColor }
    }
    
    private func setupSubviews() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        buttons.forEach { button in
            stackView.addArrangedSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        documentAutoCaptureButton.addTarget(self, action: #selector(showDocumentAutoCapture), for: .touchUpInside)
        nfcReadingButton.addTarget(self, action: #selector(showNfcReading), for: .touchUpInside)
        faceAutoCaptureButton.addTarget(self, action: #selector(showFaceAutoCapture), for: .touchUpInside)
        smileLivenessButton.addTarget(self, action: #selector(showSmileLiveness), for: .touchUpInside)
        magnifEyeLivenessButton.addTarget(self, action: #selector(showMagnifEyeLiveness), for: .touchUpInside)
        faceMatcherButton.addTarget(self, action: #selector(showFaceMatcher), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            documentAutoCaptureButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.documentAutoCapture)),
            nfcReadingButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.nfcReading)),
            faceAutoCaptureButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.faceAutoCapture)),
            smileLivenessButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.smileLiveness)),
            magnifEyeLivenessButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.magnifEyeLiveness)),
            faceMatcherButton.heightAnchor.constraint(equalToConstant: buttonFactory.getHeight(.faceMatcher)),
        ])
    }
}
