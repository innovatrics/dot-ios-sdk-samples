import UIKit
import DotFaceCore
import DotCore

class SmileLivenessContainerViewController: ContainerViewController {
    
    init() {
        let viewController = SmileLivenessViewController.create()
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
        
        let images = [smileLivenessResult.neutralExpressionFace.image, smileLivenessResult.smileExpressionFace.image].map { bgrRawImage in
            return UIImage(cgImage: CGImageFactory.create(bgrRawImage: bgrRawImage))
        }
        let resultViewController = SmileLivenessSampleResultViewController(images: images)
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
