import DotNfc
import UIKit

protocol NfcReadingExecutorDelegate: AnyObject {
    func nfcReadingExecutorSuccess(_ executor: NfcReadingExecutor, result: NfcReadingSampleResult)
    func nfcReadingExecutorError(_ executor: NfcReadingExecutor, errorDescription: String)
    func nfcReadingExecutorCanceled(_ executor: NfcReadingExecutor)
}

class NfcReadingExecutor {
    
    enum Error: LocalizedError {
        case missingFaceImage
        
        var errorDescription: String? {
            return "Failed to get face image from travel document."
        }
    }
    
    private lazy var travelDocumentReader: NfcTravelDocumentReaderProtocol = {
        let authorityCertificatesUrl = Bundle.main.url(forResource: "master_list", withExtension: "pem")
        let configuration = NfcTravelDocumentReaderConfiguration(authorityCertificatesUrl: authorityCertificatesUrl)
        let travelDocumentReader = NfcTravelDocumentReaderFactory().create(configuration: configuration)
        travelDocumentReader.setDelegate(self)
        return travelDocumentReader
    }()
    
    weak var delegate: NfcReadingExecutorDelegate?
    
    func execute(nfcKey: NfcKey) {
        travelDocumentReader.read(nfcKey: nfcKey)
    }
}

extension NfcReadingExecutor: NfcTravelDocumentReaderDelegate {
    
    func nfcTravelDocumentReader(_ nfcTravelDocumentReader: NfcTravelDocumentReaderProtocol, succeeded travelDocument: TravelDocument) {
        guard let bytes = travelDocument.encodedIdentificationFeaturesFace.faceImage?.bytes, let image = UIImage(data: bytes) else {
            delegate?.nfcReadingExecutorError(self, errorDescription: Error.missingFaceImage.localizedDescription)
            return
        }
        
        let sampleResult =  NfcReadingSampleResult(image: image, travelDocument: travelDocument)
        delegate?.nfcReadingExecutorSuccess(self, result: sampleResult)
    }
    
    func nfcTravelDocumentReaderCanceled(_ nfcTravelDocumentReader: NfcTravelDocumentReaderProtocol) {
        delegate?.nfcReadingExecutorCanceled(self)
    }
    
    func nfcTravelDocumentReader(_ nfcTravelDocumentReader: NfcTravelDocumentReaderProtocol, failed error: NfcTravelDocumentReaderError) {
        delegate?.nfcReadingExecutorError(self, errorDescription: error.localizedDescription)
    }
}
