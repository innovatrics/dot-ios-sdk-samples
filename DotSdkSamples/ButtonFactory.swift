import UIKit

struct ButtonFactory {
    
    enum ButtonType {
        case documentAutoCapture, nfcReading, faceAutoCapture, magnifEyeLiveness, smileLiveness, palmAutoCapture
        
        var title: String {
            switch self {
            case .documentAutoCapture: return NSLocalizedString("samples.document_auto_capture.title", comment: "")
            case .nfcReading: return NSLocalizedString("samples.nfc_reading.title", comment: "")
            case .faceAutoCapture: return NSLocalizedString("samples.face_auto_capture.title", comment: "")
            case .magnifEyeLiveness: return NSLocalizedString("samples.magnifeye_liveness.title", comment: "")
            case .smileLiveness: return NSLocalizedString("samples.smile_liveness.title", comment: "")
            case .palmAutoCapture: return NSLocalizedString("samples.palm_auto_capture.title", comment: "")
            }
        }
        
        var subtitle: String {
            switch self {
            case .documentAutoCapture: return NSLocalizedString("samples.document_auto_capture.subtitle", comment: "")
            case .nfcReading: return NSLocalizedString("samples.nfc_reading.subtitle", comment: "")
            case .faceAutoCapture: return NSLocalizedString("samples.face_auto_capture.subtitle", comment: "")
            case .magnifEyeLiveness: return NSLocalizedString("samples.magnifeye_liveness.subtitle", comment: "")
            case .smileLiveness: return NSLocalizedString("samples.smile_liveness.subtitle", comment: "")
            case .palmAutoCapture: return NSLocalizedString("samples.palm_auto_capture.subtitle", comment: "")
            }
        }
        
        var height: CGFloat {
            switch self {
            case .documentAutoCapture: return 55
            case .nfcReading: return 85
            case .faceAutoCapture: return 55
            case .magnifEyeLiveness: return 55
            case .smileLiveness: return 55
            case .palmAutoCapture: return 55
            }
        }
    }
    
    func create(_ buttonType: ButtonType) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.titleLabel?.numberOfLines = 0
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.setAttributedTitle(getTitle(buttonType), for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }
    
    func getHeight(_ buttonType: ButtonType) -> CGFloat {
        return buttonType.height
    }
    
    private func getTitle(_ buttonType: ButtonType) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let title = NSMutableAttributedString(string: buttonType.title,
                                              attributes: [.font: UIFont.systemFont(ofSize: 15, weight: .semibold),
                                                           .paragraphStyle: paragraphStyle])
        let subtitle = NSAttributedString(string: buttonType.subtitle,
                                          attributes: [.font: UIFont.systemFont(ofSize: 13),
                                                       .paragraphStyle: paragraphStyle])
        
        title.append(NSAttributedString(string: "\n", attributes: nil))
        title.append(subtitle)
        return title
    }
}
