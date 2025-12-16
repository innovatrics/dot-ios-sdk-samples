import Foundation
import DotPalmCore
import DotCore

extension PalmAutoCaptureResult: Encodable {
    
    enum Keys: String, CodingKey {
        case image
        case palm
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(image, forKey: .image)
        try container.encodeIfPresent(palm, forKey: .palm)
    }
}

extension PalmQuality: Encodable {
    
    enum Keys: String, CodingKey {
        case imageQuality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(imageQuality, forKey: .imageQuality)
    }
}

extension PalmImageQuality: Encodable {

    enum Keys: String, CodingKey {
        case brightness
        case sharpness
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(brightness, forKey: .brightness)
        try container.encode(sharpness, forKey: .sharpness)
    }
}

extension PalmDetector.Palm: Encodable {
    
    enum Keys: String, CodingKey {
        case detectionPosition
        case confidence
        case quality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(detectionPosition, forKey: .detectionPosition)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(quality, forKey: .quality)
    }
}

extension DetectionPosition: Encodable {
    
    enum Keys: String, CodingKey {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(topLeft, forKey: .topLeft)
        try container.encode(topRight, forKey: .topRight)
        try container.encode(bottomRight, forKey: .bottomRight)
        try container.encode(bottomLeft, forKey: .bottomLeft)
    }
}
