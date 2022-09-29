import Foundation
import DotFaceCore

extension FaceAttribute: Encodable {
    
    enum Keys: String, CodingKey {
        case score
        case preconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(score, forKey: .score)
        try container.encode(preconditionsMet, forKey: .preconditionsMet)
    }
}

extension FaceAspects: Encodable {
    
    enum Keys: String, CodingKey {
        case eyeDistance
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(eyeDistance, forKey: .eyeDistance)
    }
}

extension FaceImageQuality: Encodable {
    
    enum Keys: String, CodingKey {
        case sharpness
        case brightness
        case contrast
        case uniqueIntensityLevels
        case shadow
        case specularity
        case backgroundUniformity
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(sharpness, forKey: .sharpness)
        try container.encodeIfPresent(brightness, forKey: .brightness)
        try container.encodeIfPresent(contrast, forKey: .contrast)
        try container.encodeIfPresent(uniqueIntensityLevels, forKey: .uniqueIntensityLevels)
        try container.encodeIfPresent(shadow, forKey: .shadow)
        try container.encodeIfPresent(specularity, forKey: .specularity)
        try container.encodeIfPresent(backgroundUniformity, forKey: .backgroundUniformity)
    }
}

extension HeadPoseAttribute: Encodable {
    
    enum Keys: String, CodingKey {
        case angle
        case preconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(angle, forKey: .angle)
        try container.encode(preconditionsMet, forKey: .preconditionsMet)
    }
}

extension HeadPose: Encodable {
    
    enum Keys: String, CodingKey {
        case roll
        case yaw
        case pitch
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(roll, forKey: .roll)
        try container.encodeIfPresent(yaw, forKey: .yaw)
        try container.encodeIfPresent(pitch, forKey: .pitch)
    }
}

extension Wearables: Encodable {
    
    enum Keys: String, CodingKey {
        case glasses
        case mask
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(glasses, forKey: .glasses)
        try container.encodeIfPresent(mask, forKey: .mask)
    }
}

extension Glasses: Encodable {
    
    enum Keys: String, CodingKey {
        case score
        case preconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(score, forKey: .score)
        try container.encode(preconditionsMet, forKey: .preconditionsMet)
    }
}

extension Expression: Encodable {
    
    enum Keys: String, CodingKey {
        case eyes
        case mouth
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(eyes, forKey: .eyes)
        try container.encodeIfPresent(mouth, forKey: .mouth)
    }
}

extension EyesExpression: Encodable {
    
    enum Keys: String, CodingKey {
        case rightEye
        case leftEye
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(rightEye, forKey: .rightEye)
        try container.encodeIfPresent(leftEye, forKey: .leftEye)
    }
}

extension FaceQuality: Encodable {
    
    enum Keys: String, CodingKey {
        case imageQuality
        case headPose
        case wearables
        case expression
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(imageQuality, forKey: .imageQuality)
        try container.encodeIfPresent(headPose, forKey: .headPose)
        try container.encodeIfPresent(wearables, forKey: .wearables)
        try container.encodeIfPresent(expression, forKey: .expression)
    }
}
