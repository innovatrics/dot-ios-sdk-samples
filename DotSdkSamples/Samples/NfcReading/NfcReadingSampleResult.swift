import UIKit
import DotNfc

class NfcReadingSampleResult: SampleResult {
    
    let uiImage: UIImage
    let resultDescription: String? = nil
    let travelDocument: TravelDocument
    
    init(uiImage: UIImage, travelDocument: TravelDocument) {
        self.uiImage = uiImage
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
