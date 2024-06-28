import UIKit
import DotFaceCore
import DotCore

class SmileLivenessContainerViewController: ContainerViewController {
    
    init() {
        let viewController = SmileLivenessViewController()
        super.init(viewController: viewController)
        viewController.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("samples.smile_liveness.title", comment: "")
        view.backgroundColor = .systemBackground
    }
    
    private func navigateToResultViewController(_ smileLivenessResult: SmileLivenessResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let image = UIImage(cgImage: CGImageFactory.create(bgrRawImage: smileLivenessResult.bgrRawImage))
        let resultViewController = SmileLivenessSampleResultViewController(images: [image])
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension SmileLivenessContainerViewController: SmileLivenessViewControllerDelegate {
    
    func smileLivenessViewController(_ viewController: SmileLivenessViewController, finished result: SmileLivenessResult) {
        navigateToResultViewController(result)
    }
    
    func smileLivenessViewControllerViewWillAppear(_ viewController: SmileLivenessViewController) {
        viewController.start()
    }
}
