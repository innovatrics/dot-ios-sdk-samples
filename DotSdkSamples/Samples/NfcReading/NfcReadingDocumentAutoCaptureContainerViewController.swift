import UIKit
import DotDocument
import DotNfc

class NfcReadingDocumentAutoCaptureContainerViewController: ContainerViewController {
        
    init() {
        let configuration = DocumentAutoCaptureViewController.Configuration(mrzValidation: .validateAlways)
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
}

extension NfcReadingDocumentAutoCaptureContainerViewController: DocumentAutoCaptureViewControllerDelegate {
    
    func documentAutoCaptureViewController(_ viewController: DocumentAutoCaptureViewController, captured result: DocumentAutoCaptureResult) {
        let mrzPassword = try! MrzPasswordFactory.create(documentAutoCaptureResult: result)
        navigateToNfcReadingViewController(mrzPassword)
    }
    
    func documentAutoCaptureViewControllerViewWillAppear(_ viewController: DocumentAutoCaptureViewController) {
        viewController.start()
    }
}
