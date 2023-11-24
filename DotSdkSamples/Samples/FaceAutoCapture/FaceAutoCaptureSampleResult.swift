import UIKit
import DotFaceCore

class FaceAutoCaptureSampleResult: SampleResult {
    
    let image: UIImage
    let resultDescription: String? = nil
    let confidence: Double
    let faceAspects: FaceAspects
    let faceQuality: FaceQuality

    init(image: UIImage, confidence: Double, faceAspects: FaceAspects, faceQuality: FaceQuality) {
        self.image = image
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
