import UIKit
import DotFaceCore
import DotFaceCommons

class MultiRangeLivenessContainerViewController: ContainerViewController {
    
    init() {
        let challengeSequence: [MultiRangeLivenessChallengeItem] = [.one, .three, .five, .zero]
        let viewController = MultiRangeLivenessViewController(configuration: try! .init(challengeSequence: challengeSequence.map { .init(challengeItem: $0) }))
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
    
    private func navigateToResultViewController(_ multiRangeLivenessResult: MultiRangeLivenessResult) {
        guard let samplesViewController = navigationController?.viewControllers.first else { return }
        
        let resultViewController = SampleResultViewController(sampleResult: multiRangeLivenessResult)
        navigationController?.setViewControllers([samplesViewController, resultViewController], animated: true)
    }
}

extension MultiRangeLivenessContainerViewController: MultiRangeLivenessViewControllerDelegate {
    func multiRangeLivenessViewController(_ viewController: MultiRangeLivenessViewController, finished result: MultiRangeLivenessResult) {
        navigateToResultViewController(result)
    }
    
    func multiRangeLivenessViewControllerViewWillAppear(_ viewController: MultiRangeLivenessViewController) {
        viewController.start()
    }
}

