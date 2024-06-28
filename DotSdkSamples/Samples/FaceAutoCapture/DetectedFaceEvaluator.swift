import UIKit
import DotFaceCore
import DotCore

struct DetectedFaceEvaluator {
    
    func evaluate(image: BgrRawImage, detectedFace: FaceDetector.Face) async -> FaceAutoCaptureSampleResult {
        
        let image = UIImage(cgImage: CGImageFactory.create(bgrRawImage: image))
        let faceAspects = detectedFace.faceAspects
        let faceQuality = detectedFace.faceQuality
        return FaceAutoCaptureSampleResult(image: image,
                                           confidence: detectedFace.confidence,
                                           faceAspects: faceAspects,
                                           faceQuality: faceQuality)
    }
}
