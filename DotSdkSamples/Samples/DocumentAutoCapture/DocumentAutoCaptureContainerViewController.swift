import UIKit
import DotDocument
import DotCore

class DocumentAutoCaptureContainerViewController: ContainerViewController {
    
    init() {
        let viewController = DocumentAutoCaptureViewController()
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.document_auto_capture.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    private func navigateToResultViewController(_ result: DocumentAutoCaptureResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let uiImage = UIImage(cgImage: CGImageFactory.create(bgraRawImage: result.bgraRawImage))
        let sampleResult = DocumentAutoCaptureSampleResult(image: uiImage, documentAutoCaptureResult: result)
        let resultViewController = SampleResultViewController(sampleResult: sampleResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension DocumentAutoCaptureContainerViewController: DocumentAutoCaptureViewControllerDelegate {
    
    func documentAutoCaptureViewController(_ viewController: DocumentAutoCaptureViewController, captured result: DocumentAutoCaptureResult) {
        navigateToResultViewController(result)
    }
    
    func documentAutoCaptureViewControllerViewWillAppear(_ viewController: DocumentAutoCaptureViewController) {
        viewController.start()
    }
}
