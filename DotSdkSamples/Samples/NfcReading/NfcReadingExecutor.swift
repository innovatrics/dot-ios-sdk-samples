import DotNfc
import UIKit

protocol NfcReadingExecutorDelegate: AnyObject {
    func nfcReadingExecutorSuccess(_ executor: NfcReadingExecutor, result: NfcReadingSampleResult)
    func nfcReadingExecutorError(_ executor: NfcReadingExecutor, errorDescription: String)
}

class NfcReadingExecutor {
    
    enum Error: LocalizedError {
        case missingFaceImage
        
        var errorDescription: String? {
            return "Failed to get face image from travel document."
        }
    }
    
    private lazy var travelDocumentReader: NfcTravelDocumentReader = {
        let authorityCertificatesUrl = Bundle.main.url(forResource: "master_list", withExtension: "pem")
        let configuration = NfcTravelDocumentReaderConfiguration(authorityCertificatesUrl: authorityCertificatesUrl)
        let travelDocumentReader = NfcTravelDocumentReader(configuration: configuration)
        travelDocumentReader.setDelegate(self)
        return travelDocumentReader
    }()
    
    weak var delegate: NfcReadingExecutorDelegate?
    
    func execute(nfcKey: NfcKey) {
        travelDocumentReader.read(nfcKey: nfcKey)
    }
}

extension NfcReadingExecutor: NfcTravelDocumentReaderDelegate {
    
    func nfcTravelDocumentReader(_ nfcTravelDocumentReader: NfcTravelDocumentReader, succeeded travelDocument: TravelDocument) {
        guard let bytes = travelDocument.encodedIdentificationFeaturesFace.faceImage?.bytes, let image = UIImage(data: bytes) else {
            delegate?.nfcReadingExecutorError(self, errorDescription: Error.missingFaceImage.localizedDescription)
            return
        }
        
        let sampleResult =  NfcReadingSampleResult(image: image, travelDocument: travelDocument)
        delegate?.nfcReadingExecutorSuccess(self, result: sampleResult)
    }
    
    func nfcTravelDocumentReader(_ nfcTravelDocumentReader: NfcTravelDocumentReader, failed error: NfcTravelDocumentReaderError) {
        delegate?.nfcReadingExecutorError(self, errorDescription: error.localizedDescription)
    }
}
