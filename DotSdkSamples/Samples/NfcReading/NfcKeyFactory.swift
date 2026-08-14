import Foundation
import DotNfc
import DotDocument
import DotDocumentCommons

struct MrzPasswordFactory {
    private init () {}

    enum Error: LocalizedError {
        case machineReadableZoneNotAvailable

        var errorDescription: String? {
            return "The captured document has no parsed machine readable zone, so an NFC access key cannot be derived."
        }
    }

    static func create(documentAutoCaptureResult: DocumentAutoCaptureResult) throws -> MachineReadableZonePassword {
        guard let machineReadableZone = documentAutoCaptureResult.machineReadableZone,
              let travelDocumentType = documentAutoCaptureResult.travelDocumentType?.travelDocumentType
        else {
            throw Error.machineReadableZoneNotAvailable
        }
        
        return try MachineReadableZonePassword(
            documentNumber:
                resolveDocumentNumber(
                    machineReadableZone: machineReadableZone,
                    travelDocumentType: travelDocumentType
                ),
            dateOfExpiry:
                resolveDateOfExpiry(
                    machineReadableZone: machineReadableZone,
                    travelDocumentType: travelDocumentType
                ),
            dateOfBirth:
                resolveDateOfBirth(
                    machineReadableZone: machineReadableZone,
                    travelDocumentType: travelDocumentType
                )
        )
    }
    
    private static func resolveDocumentNumber(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.documentNumber.value
        case .td2: return machineReadableZone.td2!.documentNumber.value
        case .td3: return machineReadableZone.td3!.passportNumber.value
        @unknown default: fatalError()
        }
    }
    
    private static func resolveDateOfExpiry(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.dateOfExpiry.value
        case .td2: return machineReadableZone.td2!.dateOfExpiry.value
        case .td3: return machineReadableZone.td3!.dateOfExpiry.value
        @unknown default: fatalError()
        }
    }
    
    private static func resolveDateOfBirth(machineReadableZone: MachineReadableZone, travelDocumentType: TravelDocumentType) -> String {
        switch travelDocumentType {
        case .td1: return machineReadableZone.td1!.dateOfBirth.value
        case .td2: return machineReadableZone.td2!.dateOfBirth.value
        case .td3: return machineReadableZone.td3!.dateOfBirth.value
        @unknown default: fatalError()
        }
    }
}
