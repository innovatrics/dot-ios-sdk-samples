import UIKit
import DotCore
import Foundation
import DotFaceCore

extension MagnifEyeLivenessResult: SampleResult {
    
    var image: UIImage {
        UIImage(cgImage: CGImageFactory.create(bgrRawImage: bgrRawImage))
    }
    
    public var resultDescription: String? {
        NSLocalizedString("samples.magnifeye_liveness.result_description", comment: "")
    }
}

extension MagnifEyeLivenessResult: Encodable {
    
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

extension BgrRawImage: Encodable {
    
    enum Keys: String, CodingKey {
        case size
        case bytes
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(size, forKey: .size)
        try container.encode(bytes.description, forKey: .bytes)
    }
}
