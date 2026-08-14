import UIKit
import DotDocument
import DotNfc

class NfcReadingDocumentAutoCaptureContainerViewController: ContainerViewController {
        
    init() {
        let configuration = DocumentAutoCaptureViewController.Configuration(baseConfiguration: .init(mrzValidation: .requirePresenceAndValidity))
        let viewController = DocumentAutoCaptureViewController(configuration: configuration)
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
    
    private func navigateToNfcReadingViewController(_ password: TravelDocumentReaderPassword) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }

        let nfcReadingViewController = NfcReadingViewController(password: password)
        navigationController?.setViewControllers([samplesViewController, nfcReadingViewController], animated: true)
    }

    private func presentErrorAlert(errorMessage: String) {
        let alertController = UIAlertController.createErrorController(errorMessage: errorMessage) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        present(alertController, animated: true)
    }
}

extension NfcReadingDocumentAutoCaptureContainerViewController: DocumentAutoCaptureViewControllerDelegate {
    
    func documentAutoCaptureViewController(_ viewController: BaseDocumentAutoCaptureViewController, finished result: DocumentAutoCaptureResult) {
        do {
            let mrzPassword = try MrzPasswordFactory.create(documentAutoCaptureResult: result)
            navigateToNfcReadingViewController(mrzPassword)
        } catch {
            presentErrorAlert(errorMessage: error.localizedDescription)
        }
    }
    
    func documentAutoCaptureViewControllerViewWillAppear(_ viewController: BaseDocumentAutoCaptureViewController) {
        viewController.start()
    }
}
