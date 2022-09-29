import UIKit
import DotFaceCore

class FaceAutoCaptureSampleResult: SampleResult {
    
    let image: UIImage
    let confidence: Double
    let passiveLivenessFaceAttribute: FaceAttribute
    let faceAspects: FaceAspects
    let faceQuality: FaceQuality
    
    init(image: UIImage, confidence: Double, passiveLivenessFaceAttribute: FaceAttribute, faceAspects: FaceAspects, faceQuality: FaceQuality) {
        self.image = image
        self.confidence = confidence
        self.passiveLivenessFaceAttribute = passiveLivenessFaceAttribute
        self.faceAspects = faceAspects
        self.faceQuality = faceQuality
    }
}

extension FaceAutoCaptureSampleResult: Encodable {
    
    enum Keys: String, CodingKey {
        case confidence
        case passiveLivenessFaceAttribute
        case faceAspects
        case faceQuality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(passiveLivenessFaceAttribute, forKey: .passiveLivenessFaceAttribute)
        try container.encode(faceAspects, forKey: .faceAspects)
        try container.encode(faceQuality, forKey: .faceQuality)
    }
}
