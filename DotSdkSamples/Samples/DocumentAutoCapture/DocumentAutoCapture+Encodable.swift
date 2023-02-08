import Foundation
import DotDocument
import DotCore

extension DocumentAutoCaptureResult: Encodable {
    
    enum Keys: String, CodingKey {
        case bgraRawImage
        case documentDetectorResult
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(bgraRawImage, forKey: .bgraRawImage)
        try container.encode(documentDetectorResult, forKey: .documentDetectorResult)
    }
}

extension BgraRawImage: Encodable {
    
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

extension DocumentDetector.Result: Encodable {
    
    enum Keys: String, CodingKey {
        case confidence
        case widthToHeightRatio
        case corners
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(confidence, forKey: .confidence)
        try container.encode(widthToHeightRatio.value, forKey: .widthToHeightRatio)
        try container.encode(corners, forKey: .corners)
    }
}

extension Corners: Encodable {
    
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
