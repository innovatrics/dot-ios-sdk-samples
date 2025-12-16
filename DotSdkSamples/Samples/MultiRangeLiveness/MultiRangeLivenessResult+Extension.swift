import UIKit
import DotCore
import Foundation
import DotFaceCore

extension MultiRangeLivenessResult: SampleResult {
    
    var uiImage: UIImage {
        UIImage(cgImage: CGImageFactory.create(image: image))
    }
    
    public var resultDescription: String? {
        return nil
    }
}

extension MultiRangeLivenessResult: Encodable {
    
    enum Keys: String, CodingKey {
        case image
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(image, forKey: .image)
        try container.encode(content.description, forKey: .content)
    }
}
