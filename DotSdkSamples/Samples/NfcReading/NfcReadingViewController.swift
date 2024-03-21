import DotNfc
import UIKit

class NfcReadingViewController: UIViewController {
    
    enum State {
        case nfcReadingNotStarted
        case nfcReadingInProgress
        case nfcReadingSuccess(NfcReadingSampleResult)
        case nfcReadingCanceled
        case nfcReadingError(String)
    }
    
    @MainActor
    var state = State.nfcReadingNotStarted {
        didSet {
            updateState()
        }
    }
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    private let nfcKey: NfcKey
    private lazy var nfcReadingExecutor: NfcReadingExecutor = {
        let nfcReadingExecutor = NfcReadingExecutor()
        nfcReadingExecutor.delegate = self
        return nfcReadingExecutor
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let textView = UITextView()
    
    private var imageViewWidthConstraint: NSLayoutConstraint?
    
    init(nfcKey: NfcKey) {
        self.nfcKey = nfcKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("samples.nfc_reading.title", comment: "")
        view.backgroundColor = .systemBackground
        
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if case .nfcReadingNotStarted = state {
            performNfcReading()
        }
    }
}

extension NfcReadingViewController {
    
    private func updateState() {
        switch state {
        case .nfcReadingNotStarted:
            textView.text = nil
            imageView.image = nil
        case .nfcReadingInProgress:
            textView.text = nil
            imageView.image = nil
        case .nfcReadingSuccess(let sampleResult):
            textView.text = String(data: try! encoder.encode(sampleResult), encoding: .utf8)
            addImage(sampleResult.image)
        case .nfcReadingCanceled:
            textView.text = nil
            imageView.image = nil
            navigationController?.popViewController(animated: true)
        case .nfcReadingError(let errorDescription):
            textView.text = nil
            imageView.image = nil
            presentErrorAlert(errorMessage: "NFC Reading failed: \(errorDescription)")
        }
    }
    
    private func presentErrorAlert(errorMessage: String) {
        let alertController = UIAlertController.createErrorController(errorMessage: errorMessage) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        present(alertController, animated: true)
    }
    
    private func performNfcReading() {
        state = .nfcReadingInProgress
        nfcReadingExecutor.execute(nfcKey: nfcKey)
    }
    
    private func addImage(_ image: UIImage) {
        imageViewWidthConstraint?.isActive = false
        imageView.image = image
        imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width/image.size.height)
        imageViewWidthConstraint?.isActive = true
    }
    
    private func setupImageView() {
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)
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
        
        setupImageView()
        setupTextView()
        
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
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}

extension NfcReadingViewController: NfcReadingExecutorDelegate {
    
    func nfcReadingExecutorSuccess(_ executor: NfcReadingExecutor, result: NfcReadingSampleResult) {
        state = .nfcReadingSuccess(result)
    }
    
    func nfcReadingExecutorCanceled(_ executor: NfcReadingExecutor) {
        state = .nfcReadingCanceled
    }
    
    func nfcReadingExecutorError(_ executor: NfcReadingExecutor, errorDescription: String) {
        state = .nfcReadingError(errorDescription)
    }
}
