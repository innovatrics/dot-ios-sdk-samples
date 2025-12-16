import Foundation
import DotDocument
import DotCore

extension DocumentAutoCaptureResult: Encodable {
    
    enum Keys: String, CodingKey {
        case image
        case document
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(image, forKey: .image)
        try container.encodeIfPresent(document, forKey: .document)
    }
}

extension ImageSize: Encodable {
    
    enum Keys: String, CodingKey {
        case width
        case height
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }
}

extension DocumentImageQuality: Encodable {
    
    enum Keys: String, CodingKey {
        case brightness
        case sharpness
        case hotspotsScore
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(brightness, forKey: .brightness)
        try container.encode(sharpness, forKey: .sharpness)
        try container.encode(hotspotsScore, forKey: .hotspotsScore)
    }
}

extension DocumentQuality: Encodable {

    enum Keys: String, CodingKey {
        case imageQuality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(imageQuality, forKey: .imageQuality)
    }
}

extension DocumentDetector.Document: Encodable {
    
    enum Keys: String, CodingKey {
        case detectionPosition
        case confidence
        case widthToHeightRatio
        case quality
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(detectionPosition, forKey: .detectionPosition)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(widthToHeightRatio, forKey: .widthToHeightRatio)
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

extension PointDouble: Encodable {
    
    enum Keys: String, CodingKey {
        case x
        case y
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
    }
}
