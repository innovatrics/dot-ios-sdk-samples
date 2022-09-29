import UIKit
import DotFaceCore

struct FaceMatchingExecutor {
    
    private let minFaceSizeRatio = 0.10
    private let maxFaceSizeRatio = 0.25
    
    private let faceMatcher = FaceMatcher()
    
    private let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }()
    
    func execute(referenceCGImage: CGImage, probeCGImage: CGImage) async throws -> String {
        let result = try faceMatcher.match(referenceFaceImage: try await createFaceImage(cgImage: referenceCGImage),
                                           probeFaceImage: try await createFaceImage(cgImage: probeCGImage))
        return String(data: try encoder.encode(result), encoding: .utf8)!
    }
    
    private func createFaceImage(cgImage: CGImage) async throws -> FaceImage {
        let bgrRawImage = BgrRawImageFactory.create(cgImage: cgImage)
        return try FaceImageFactory.create(image: bgrRawImage, minFaceSizeRatio: minFaceSizeRatio, maxFaceSizeRatio: maxFaceSizeRatio)
    }
}
