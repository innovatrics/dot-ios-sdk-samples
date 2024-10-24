import DotPalmCore
import UIKit

class PalmAutoCaptureSampleResult: SampleResult {
    
    let image: UIImage
    let resultDescription: String? = nil
    let palmAutoCaptureResult: PalmAutoCaptureResult
    
    init(image: UIImage, palmAutoCaptureResult: PalmAutoCaptureResult) {
        self.image = image
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
