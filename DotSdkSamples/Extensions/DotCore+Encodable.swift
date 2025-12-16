import DotCore

extension Image: Encodable {
    
    enum Keys: String, CodingKey {
        case bytes
        case format
        case size
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(bytes.description, forKey: .bytes)
        try container.encode(format, forKey: .format)
        try container.encode(size, forKey: .size)
    }
}

extension ImageFormat: Encodable {
    
    enum Keys: String, CodingKey {
        case rawBgr
        case rawBgra
        case jpeg
        case jpeg2000
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}
