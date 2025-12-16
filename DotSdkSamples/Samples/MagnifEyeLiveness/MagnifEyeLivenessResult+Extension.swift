import UIKit
import DotCore
import Foundation
import DotFaceCore

extension MagnifEyeLivenessResult: SampleResult {
    
    var uiImage: UIImage {
        UIImage(cgImage: CGImageFactory.create(image: image))
    }
    
    public var resultDescription: String? {
        NSLocalizedString("samples.magnifeye_liveness.result_description", comment: "")
    }
}

extension MagnifEyeLivenessResult: Encodable {
    
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
