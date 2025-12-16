import UIKit

final class FaceAutoCapturePhaseView: UIView {
    
    enum _UIState: Equatable {
        case hidden
        case visible(text: String, textColor: UIColor, backgroundColor: UIColor)
    }
    
    private let textLabel = UILabel()
    var state: _UIState = .hidden {
        didSet {
            guard state != oldValue else { return }
            update(uiState: state)
        }
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        update(uiState: state)

        layer.cornerRadius = 6
        clipsToBounds = true

        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(uiState: _UIState) {
        switch uiState {
        case .hidden:
            isHidden = true
        case .visible(let text, let textColor, let backgroundColor):
            isHidden = false
            textLabel.text = text
            textLabel.textColor = textColor
            self.backgroundColor = backgroundColor
        }
    }
}
