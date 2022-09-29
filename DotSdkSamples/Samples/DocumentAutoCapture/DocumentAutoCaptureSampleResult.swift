import DotDocument
import UIKit

class DocumentAutoCaptureSampleResult: SampleResult {
    
    let image: UIImage
    let documentAutoCaptureResult: DocumentAutoCaptureResult
    
    init(image: UIImage, documentAutoCaptureResult: DocumentAutoCaptureResult) {
        self.image = image
        self.documentAutoCaptureResult = documentAutoCaptureResult
    }
}

extension DocumentAutoCaptureSampleResult: Encodable {
    
    enum Keys: String, CodingKey {
        case documentAutoCaptureResult
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(documentAutoCaptureResult, forKey: .documentAutoCaptureResult)
    }
}
