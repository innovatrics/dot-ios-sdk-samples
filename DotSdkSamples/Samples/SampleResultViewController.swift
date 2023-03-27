import UIKit

protocol SampleResult: Encodable {
    var image: UIImage { get }
    var resultDescription: String? { get }
}

class SampleResultViewController<T: SampleResult>: UIViewController {
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    let sampleResult: T
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let imageView = UIImageView()
    private let textView = UITextView()
    
    init(sampleResult: T) {
        self.sampleResult = sampleResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("samples.result.title", comment: "")
        view.backgroundColor = .systemBackground
        
        setupSubviews()
    }
}

extension SampleResultViewController {
    
    private func setupImageView() {
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = sampleResult.image
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: sampleResult.image.size.width/sampleResult.image.size.height).isActive = true
    }
    
    private func setupTextView() {
        
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = sampleResult.resultDescription ?? String(data: try! encoder.encode(sampleResult), encoding: .utf8)
        textView.font = .systemFont(ofSize: 14)
    }
    
    private func setupSubviews() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupTextView()
        setupImageView()
        
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
