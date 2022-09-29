import UIKit
import DotFaceCore

struct DetectedFaceEvaluator {
    
    func evaluate(_ detectedFace: DetectedFace) async throws -> FaceAutoCaptureSampleResult {
        
        let image = UIImage(cgImage: CGImageFactory.create(bgrRawImage: detectedFace.image))
        let passiveLivenessFaceAttribute = try detectedFace.evaluatePassiveLiveness()
        let faceAspects = try detectedFace.evaluateFaceAspects()
        let faceQuality = try detectedFace.evaluateFaceQuality()
        
        return FaceAutoCaptureSampleResult(image: image,
                                           confidence: detectedFace.confidence,
                                           passiveLivenessFaceAttribute: passiveLivenessFaceAttribute,
                                           faceAspects: faceAspects,
                                           faceQuality: faceQuality)
    }
}
