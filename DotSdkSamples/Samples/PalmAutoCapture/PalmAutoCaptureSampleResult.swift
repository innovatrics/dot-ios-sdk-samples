import DotPalmCore
import UIKit

class PalmAutoCaptureSampleResult: SampleResult {
    
    let uiImage: UIImage
    let resultDescription: String? = nil
    let palmAutoCaptureResult: PalmAutoCaptureResult
    
    init(uiImage: UIImage, palmAutoCaptureResult: PalmAutoCaptureResult) {
        self.uiImage = uiImage
        self.palmAutoCaptureResult = palmAutoCaptureResult
    }
}

extension PalmAutoCaptureSampleResult: Encodable {
    
    enum Keys: String, CodingKey {
        case palmAutoCaptureResult
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(palmAutoCaptureResult, forKey: .palmAutoCaptureResult)
    }
}
