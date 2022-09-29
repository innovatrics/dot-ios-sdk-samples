import Foundation
import DotFaceCore

extension FaceMatcher.Result: Encodable {
    
    enum Keys: String, CodingKey {
        case score
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(score, forKey: .score)
    }
}
