import UIKit
import DotFaceCore

class FaceAutoCaptureSampleResult: SampleResult {
    
    let uiImage: UIImage
    let resultDescription: String? = nil
    let confidence: Double
    let faceAspects: FaceAspects
    let faceQuality: FaceQuality

    init(uiImage: UIImage, confidence: Double, faceAspects: FaceAspects, faceQuality: FaceQuality) {
        self.uiImage = uiImage
        self.confidence = confidence
        self.faceAspects = faceAspects
        self.faceQuality = faceQuality
    }
}

extension FaceAutoCaptureSampleResult: Encodable {
    
    enum Keys: String, CodingKey {
        case confidence
        case faceAspects
        case faceQuality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(faceAspects, forKey: .faceAspects)
        try container.encode(faceQuality, forKey: .faceQuality)
    }
}
