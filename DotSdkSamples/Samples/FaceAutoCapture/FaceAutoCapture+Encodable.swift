import Foundation
import DotFaceCore

extension FaceAttribute: Encodable {
    
    enum Keys: String, CodingKey {
        case score
        case arePreconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(score, forKey: .score)
        try container.encode(arePreconditionsMet, forKey: .arePreconditionsMet)
    }
}

extension FaceAspects: Encodable {
    
    enum Keys: String, CodingKey {
        case eyeDistanceToImageShorterSideRatio
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(eyeDistanceToImageShorterSideRatio, forKey: .eyeDistanceToImageShorterSideRatio)
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
        case arePreconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(angle, forKey: .angle)
        try container.encode(arePreconditionsMet, forKey: .arePreconditionsMet)
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
        case arePreconditionsMet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(score, forKey: .score)
        try container.encode(arePreconditionsMet, forKey: .arePreconditionsMet)
    }
}

extension DotFaceCore.Expression: Encodable {
    
    enum Keys: String, CodingKey {
        case eyes
        case mouth
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(eyes, forKey: .eyes)
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
        try container.encode(imageQuality, forKey: .imageQuality)
        try container.encode(headPose, forKey: .headPose)
        try container.encode(wearables, forKey: .wearables)
        try container.encode(expression, forKey: .expression)
    }
}
