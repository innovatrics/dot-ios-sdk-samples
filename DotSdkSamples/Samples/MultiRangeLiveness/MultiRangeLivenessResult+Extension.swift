import UIKit
import DotCore
import Foundation
import DotFaceCore

extension MultiRangeLivenessResult: SampleResult {
    
    var image: UIImage {
        UIImage(cgImage: CGImageFactory.create(bgrRawImage: bgrRawImage))
    }
    
    public var resultDescription: String? {
        return nil
    }
}

extension MultiRangeLivenessResult: Encodable {
    
    enum Keys: String, CodingKey {
        case bgrRawImage
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(bgrRawImage, forKey: .bgrRawImage)
        try container.encode(content.description, forKey: .content)
    }
}
