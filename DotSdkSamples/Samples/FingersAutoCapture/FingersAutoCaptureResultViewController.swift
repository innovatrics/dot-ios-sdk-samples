import UIKit
import DotCore
import DotFingersCore

/// Shows the result of a Fingers Auto Capture: the detected finger images, the
/// fingerprint images produced by `FingerToFingerprintTransformer` (computed
/// asynchronously), and a JSON summary of the detection. Mirrors the Android
/// `FingersAutoCaptureResultFragment` (finger images card + fingerprint images card).
final class FingersAutoCaptureResultViewController: UIViewController {

    private let result: FingersAutoCaptureResult

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private let fingerprintsActivityIndicator = UIActivityIndicatorView(style: .medium)

    private var orderedBundles: [(label: String, bundle: FingerBundle?)] {
        return [
            ("Index", result.fingerBundles.index),
            ("Middle", result.fingerBundles.middle),
            ("Ring", result.fingerBundles.ring),
            ("Little", result.fingerBundles.little),
        ]
    }

    init(result: FingersAutoCaptureResult) {
        self.result = result
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
        showFingerImages()
        showSummary()
        transformAndShowFingerprints()
    }
}

extension FingersAutoCaptureResultViewController {

    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.alignment = .fill

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -10),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -10),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -20),
        ])
    }

    private func showFingerImages() {
        contentStackView.addArrangedSubview(makeHeaderLabel(NSLocalizedString("samples.fingers_auto_capture.result.finger_images", comment: "")))
        for (label, bundle) in orderedBundles {
            guard let bundle = bundle else { continue }
            let uiImage = UIImage(cgImage: CGImageFactory.create(image: bundle.image))
            contentStackView.addArrangedSubview(makeLabeledImageView(label: label, image: uiImage))
        }
    }

    private func transformAndShowFingerprints() {
        contentStackView.addArrangedSubview(makeHeaderLabel(NSLocalizedString("samples.fingers_auto_capture.result.fingerprint_images", comment: "")))
        fingerprintsActivityIndicator.startAnimating()
        contentStackView.addArrangedSubview(fingerprintsActivityIndicator)

        let bundles = result.fingerBundles
        DispatchQueue.global().async { [weak self] in
            do {
                let fingerprintImages = try FingerToFingerprintTransformer().transform(fingerBundles: bundles)
                let labeled: [(String, Image?)] = [
                    ("Index", fingerprintImages.index),
                    ("Middle", fingerprintImages.middle),
                    ("Ring", fingerprintImages.ring),
                    ("Little", fingerprintImages.little),
                ]
                let images: [(String, UIImage)] = labeled.compactMap { label, image in
                    image.map { (label, UIImage(cgImage: CGImageFactory.create(image: $0))) }
                }
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.fingerprintsActivityIndicator.stopAnimating()
                    self.fingerprintsActivityIndicator.removeFromSuperview()
                    images.forEach { label, image in
                        self.contentStackView.addArrangedSubview(self.makeLabeledImageView(label: label, image: image))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.fingerprintsActivityIndicator.stopAnimating()
                    self.fingerprintsActivityIndicator.removeFromSuperview()
                    self.contentStackView.addArrangedSubview(self.makeHeaderLabel("Transformation failed: \(error.localizedDescription)"))
                }
            }
        }
    }

    private func showSummary() {
        let fingers: [Summary.Finger] = orderedBundles.compactMap { label, bundle in
            guard let bundle = bundle else { return nil }
            return Summary.Finger(
                finger: label,
                confidence: bundle.finger.confidence,
                pixelsPerInch: bundle.pixelsPerInch,
                imageSize: "\(bundle.image.size)"
            )
        }
        let summary = Summary(detectedFingerCount: fingers.count, fingers: fingers, contentSizeBytes: result.content.count)

        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = .systemFont(ofSize: 14)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        textView.text = (try? encoder.encode(summary)).flatMap { String(data: $0, encoding: .utf8) }
        contentStackView.addArrangedSubview(textView)
    }

    private func makeHeaderLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }

    private func makeLabeledImageView(label: String, image: UIImage) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = label
        titleLabel.font = .systemFont(ofSize: 13)

        // Full-width image whose height follows the aspect ratio, matching the
        // Android sample's match_parent width / wrap_content height.
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let aspectRatio = image.size.height / max(image.size.width, 1)
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: aspectRatio).isActive = true

        let stack = UIStackView(arrangedSubviews: [titleLabel, imageView])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }
}

private struct Summary: Encodable {

    struct Finger: Encodable {
        let finger: String
        let confidence: Double
        let pixelsPerInch: Double
        let imageSize: String
    }

    let detectedFingerCount: Int
    let fingers: [Finger]
    let contentSizeBytes: Int
}
