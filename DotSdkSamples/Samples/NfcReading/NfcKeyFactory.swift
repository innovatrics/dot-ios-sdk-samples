import Foundation
import DotNfc
import DotDocument

struct NfcKeyFactory {
    
    func create(documentAutoCaptureResult: DocumentAutoCaptureResult) throws -> NfcKey {
        guard let machineReadableZone = documentAutoCaptureResult.machineReadableZone,
              let travelDocumentType = documentAutoCaptureResult.travelDocumentType?.travelDocumentType
        else {
            fatalError("Machine readable zone or travel document type is nil.")
        }
        
        return try NfcKey(documentNumber: resolveDocumentNumber(machineReadableZone: machineReadableZone, travelDocumentType: travelDocumentType),
                          dateOfExpiry: resolveDateOfExpiry(machineReadableZone: machineReadableZone, travelDocumentType: travelDocumentType),
                          dateOfBirth: resolveDateOfBirth(machineReadableZone: machineReadableZone, travelDocumentType: travelDocumentType))
    }
    
    private func resolveDocumentNumber(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.documentNumber.value
        case .td2: return machineReadableZone.td2!.documentNumber.value
        case .td3: return machineReadableZone.td3!.passportNumber.value
        @unknown default: fatalError()
        }
    }
    
    private func resolveDateOfExpiry(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.dateOfExpiry.value
        case .td2: return machineReadableZone.td2!.dateOfExpiry.value
        case .td3: return machineReadableZone.td3!.dateOfExpiry.value
        @unknown default: fatalError()
        }
    }
    
    private func resolveDateOfBirth(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.dateOfBirth.value
        case .td2: return machineReadableZone.td2!.dateOfBirth.value
        case .td3: return machineReadableZone.td3!.dateOfBirth.value
        @unknown default: fatalError()
        }
    }
}
