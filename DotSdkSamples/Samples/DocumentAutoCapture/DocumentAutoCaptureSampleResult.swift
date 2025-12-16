import DotDocument
import UIKit

class DocumentAutoCaptureSampleResult: SampleResult {
    
    let uiImage: UIImage
    let resultDescription: String? = nil
    let documentAutoCaptureResult: DocumentAutoCaptureResult
    
    init(uiImage: UIImage, documentAutoCaptureResult: DocumentAutoCaptureResult) {
        self.uiImage = uiImage
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
