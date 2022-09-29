import UIKit

class FaceMatchingViewController: UIViewController {
    
    enum State {
        case matchingNotStarted
        case matchingInProgress
        case matchingSuccess(String)
        case matchingError(String)
    }
    
    @MainActor
    var state = State.matchingNotStarted {
        didSet {
            updateState()
        }
    }
    
    private let referenceImage = UIImage(named: "sheldon")!
    private let probeImage = UIImage(named: "leonard")!
    
    private let activityIndicator = ActivityIndicatorViewController()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("samples.face_matcher.title", comment: "")
        view.backgroundColor = .systemBackground
        
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if case .matchingNotStarted = state {
            performFaceMatching()
        }
    }
}

extension FaceMatchingViewController {
    
    private func performFaceMatching() {
        state = .matchingInProgress
        Task {
            do {
                let resultDescription = try await FaceMatchingExecutor().execute(referenceCGImage: self.referenceImage.cgImage!, probeCGImage: self.probeImage.cgImage!)
                self.state = .matchingSuccess(resultDescription)
            } catch {
                state = .matchingError(error.localizedDescription)
            }
        }
    }
    
    private func updateState() {
        switch state {
        case .matchingNotStarted:
            hideActivityIndicator()
            textView.text = nil
        case .matchingInProgress:
            showActivityIndicator()
            textView.text = nil
        case .matchingSuccess(let resultDescription):
            hideActivityIndicator()
            textView.text = resultDescription
        case .matchingError(let errorDescription):
            hideActivityIndicator()
            textView.text = nil
            presentErrorAlert(errorMessage: "Face matching failed: \(errorDescription)")
        }
    }
    
    private func presentErrorAlert(errorMessage: String) {
        let alertController = UIAlertController.createErrorController(errorMessage: errorMessage)
        present(alertController, animated: true)
    }
    
    private func showActivityIndicator() {
        addChild(activityIndicator)
        activityIndicator.view.frame = view.frame
        view.addSubview(activityIndicator.view)
        activityIndicator.didMove(toParent: self)
    }
    
    private func hideActivityIndicator() {
        activityIndicator.willMove(toParent: nil)
        activityIndicator.view.removeFromSuperview()
        activityIndicator.removeFromParent()
    }
    
    private func setupImages() {
        
        [referenceImage, probeImage].forEach { image in
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.setContentHuggingPriority(.required, for: .vertical)
            stackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width/image.size.height).isActive = true
        }
    }
    
    private func setupTextView() {
        
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 14)
    }
    
    private func setupSubviews() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupTextView()
        setupImages()
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
