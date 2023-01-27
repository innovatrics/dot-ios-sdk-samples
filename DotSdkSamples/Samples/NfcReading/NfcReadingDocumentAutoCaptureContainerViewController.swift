import UIKit
import DotDocument
import DotNfc

class NfcReadingDocumentAutoCaptureContainerViewController: ContainerViewController {
    
    private let nfcKeyFactory = NfcKeyFactory()
    
    init() {
        let configuration = DocumentAutoCaptureConfiguration(isMrzReadingEnabled: true)
        let viewController = DocumentAutoCaptureViewController.create(configuration: configuration)
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.nfc_reading.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    private func navigateToNfcReadingViewController(_ nfcKey: NfcKey) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let nfcReadingViewController = NfcReadingViewController(nfcKey: nfcKey)
        navigationController?.setViewControllers([samplesViewController, nfcReadingViewController], animated: true)
    }
}

extension NfcReadingDocumentAutoCaptureContainerViewController: DocumentAutoCaptureViewControllerDelegate {
    
    func documentAutoCaptureViewController(_ viewController: DocumentAutoCaptureViewController, captured result: DocumentAutoCaptureResult) {
        do {
            let nfcKey = try nfcKeyFactory.create(documentAutoCaptureResult: result)
            navigateToNfcReadingViewController(nfcKey)
        } catch {
            let alertController = UIAlertController.createErrorController(errorMessage: "Failed to create NfcKey: \(error.localizedDescription)")
            present(alertController, animated: true)
        }
    }
    
    func documentAutoCaptureViewControllerViewWillAppear(_ viewController: DocumentAutoCaptureViewController) {
        viewController.start()
    }
}
