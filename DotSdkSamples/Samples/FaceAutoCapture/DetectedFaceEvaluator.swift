import UIKit
import DotFaceCore
import DotCore

struct DetectedFaceEvaluator {
    
    func evaluate(image: Image, detectedFace: FaceDetector.Face) async -> FaceAutoCaptureSampleResult {
        return FaceAutoCaptureSampleResult(uiImage: UIImage(cgImage: CGImageFactory.create(image: image)),
                                           confidence: detectedFace.confidence,
                                           faceAspects: detectedFace.aspects,
                                           faceQuality: detectedFace.quality)
    }
}
