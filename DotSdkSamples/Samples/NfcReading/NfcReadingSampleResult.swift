import UIKit
import DotNfc

class NfcReadingSampleResult: SampleResult {
    
    let image: UIImage
    let resultDescription: String? = nil
    let travelDocument: TravelDocument
    
    init(image: UIImage, travelDocument: TravelDocument) {
        self.image = image
        self.travelDocument = travelDocument
    }
}

extension NfcReadingSampleResult: Encodable {
    
    enum Keys: String, CodingKey {
        case travelDocument
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(travelDocument, forKey: .travelDocument)
    }
}
