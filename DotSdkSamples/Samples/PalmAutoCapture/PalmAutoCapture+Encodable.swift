import Foundation
import DotPalmCore
import DotCore

extension PalmAutoCaptureResult: Encodable {
    
    enum Keys: String, CodingKey {
        case bgraRawImage
        case palm
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(bgraRawImage, forKey: .bgraRawImage)
        try container.encodeIfPresent(palm, forKey: .palm)
    }
}

extension ImageParameters: Encodable {

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
        case imageParameters
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(detectionPosition, forKey: .detectionPosition)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(imageParameters, forKey: .imageParameters)
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
