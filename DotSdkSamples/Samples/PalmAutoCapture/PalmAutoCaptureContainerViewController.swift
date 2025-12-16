import UIKit
import DotPalmCore
import DotCore

class PalmAutoCaptureContainerViewController: ContainerViewController {
    
    init() {
        let viewController = PalmAutoCaptureViewController()
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.palm_auto_capture.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    private func navigateToResultViewController(_ result: PalmAutoCaptureResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let uiImage = UIImage(cgImage: CGImageFactory.create(image: result.image))
        let sampleResult = PalmAutoCaptureSampleResult(uiImage: uiImage, palmAutoCaptureResult: result)
        let resultViewController = SampleResultViewController(sampleResult: sampleResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension PalmAutoCaptureContainerViewController: PalmAutoCaptureViewControllerDelegate {
    
    func palmAutoCaptureViewController(_ viewController: BasePalmAutoCaptureViewController, finished result: PalmAutoCaptureResult) {
        navigateToResultViewController(result)
    }
    
    func palmAutoCaptureViewControllerViewWillAppear(_ viewController: BasePalmAutoCaptureViewController) {
        viewController.start()
    }
}
