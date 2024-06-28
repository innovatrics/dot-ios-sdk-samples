import UIKit
import DotFaceCore

class MagnifEyeLivenessContainerViewController: ContainerViewController {
    
    init() {
        let viewController = MagnifEyeLivenessViewController()
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.magnifeye_liveness.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    private func navigateToResultViewController(_ magnifEyeLivenessResult: MagnifEyeLivenessResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let resultViewController = SampleResultViewController(sampleResult: magnifEyeLivenessResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension MagnifEyeLivenessContainerViewController: MagnifEyeLivenessViewControllerDelegate {
    func magnifEyeLivenessViewController(_ viewController: MagnifEyeLivenessViewController, finished result: MagnifEyeLivenessResult) {
        navigateToResultViewController(result)
    }
    
    func magnifEyeLivenessViewControllerViewWillAppear(_ viewController: MagnifEyeLivenessViewController) {
        viewController.start()
    }
}

