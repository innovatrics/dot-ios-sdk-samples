import UIKit
import DotFaceCore
import DotCore

struct DetectedFaceEvaluator {
    
    func evaluate(_ detectedFace: DetectedFace) async throws -> FaceAutoCaptureSampleResult {
        
        let image = UIImage(cgImage: CGImageFactory.create(bgrRawImage: detectedFace.image))
        let faceAspects = try detectedFace.evaluateFaceAspects()
        let faceQuality = try detectedFace.evaluateFaceQuality()
        
        return FaceAutoCaptureSampleResult(image: image,
                                           confidence: detectedFace.confidence,
                                           faceAspects: faceAspects,
                                           faceQuality: faceQuality)
    }
}
