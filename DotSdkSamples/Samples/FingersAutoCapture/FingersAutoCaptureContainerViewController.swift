import UIKit
import DotFingersCore
import DotCore

class FingersAutoCaptureContainerViewController: ContainerViewController {

    init() {
        let viewController = FingersAutoCaptureViewController()
        super.init(viewController: viewController)
        viewController.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.fingers_auto_capture.title", comment: "")
        view.backgroundColor = .systemBackground
    }

    private func navigateToResultViewController(_ result: FingersAutoCaptureResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }

        let resultViewController = FingersAutoCaptureResultViewController(result: result)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension FingersAutoCaptureContainerViewController: FingersAutoCaptureViewControllerDelegate {

    func fingersAutoCaptureViewController(_ viewController: BaseFingersAutoCaptureViewController, finished result: FingersAutoCaptureResult) {
        navigateToResultViewController(result)
    }

    func fingersAutoCaptureViewControllerViewWillAppear(_ viewController: BaseFingersAutoCaptureViewController) {
        viewController.start()
    }
}
