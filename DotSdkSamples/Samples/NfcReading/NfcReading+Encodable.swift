import Foundation
import DotNfc

extension TravelDocument: Encodable {
    
    enum Keys: String, CodingKey {
        case ldsVersion
        case accessControlProtocolUsed
        case authenticationStatus
        case ldsMasterFile
        case machineReadableZoneInformation
        case encodedIdentificationFeaturesFace
        case displayedSignatureOrUsualMark
        case additionalPersonalDetails
        case additionalDocumentDetails
        case optionalDetails
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(ldsVersion, forKey: .ldsVersion)
        try container.encode(accessControlProtocolUsed, forKey: .accessControlProtocolUsed)
        try container.encode(authenticationStatus, forKey: .authenticationStatus)
        try container.encode(ldsMasterFile, forKey: .ldsMasterFile)
        try container.encode(machineReadableZoneInformation, forKey: .machineReadableZoneInformation)
        try container.encode(encodedIdentificationFeaturesFace, forKey: .encodedIdentificationFeaturesFace)
        try container.encodeIfPresent(displayedSignatureOrUsualMark, forKey: .displayedSignatureOrUsualMark)
        try container.encodeIfPresent(additionalPersonalDetails, forKey: .additionalPersonalDetails)
        try container.encodeIfPresent(additionalDocumentDetails, forKey: .additionalDocumentDetails)
        try container.encodeIfPresent(optionalDetails, forKey: .optionalDetails)
    }
}

extension OptionalDetails: Encodable {
    
    enum Keys: String, CodingKey {
        case content
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(content?.description, forKey: .content)
    }
}

extension AdditionalDocumentDetails: Encodable {
    
    enum Keys: String, CodingKey {
        case issuingAuthority
        case dateOfIssue
        case endorsementsOrObservations
        case taxOrExitRequirements
        case personalizationTime
        case personalizationDeviceSerialNumber
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(issuingAuthority, forKey: .issuingAuthority)
        try container.encodeIfPresent(dateOfIssue, forKey: .dateOfIssue)
        try container.encodeIfPresent(endorsementsOrObservations, forKey: .endorsementsOrObservations)
        try container.encodeIfPresent(taxOrExitRequirements, forKey: .taxOrExitRequirements)
        try container.encodeIfPresent(personalizationTime, forKey: .personalizationTime)
        try container.encodeIfPresent(personalizationDeviceSerialNumber, forKey: .personalizationDeviceSerialNumber)
    }
}

extension AdditionalPersonalDetails: Encodable {
    
    enum Keys: String, CodingKey {
        case nameOfHolder
        case otherNames
        case personalNumber
        case fullDateOfBirth
        case placeOfBirth
        case address
        case telephone
        case profession
        case title
        case personalSummary
        case otherValidTravelDocumentNumbers
        case custodyInformation
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(nameOfHolder, forKey: .nameOfHolder)
        try container.encodeIfPresent(otherNames, forKey: .otherNames)
        try container.encodeIfPresent(personalNumber, forKey: .personalNumber)
        try container.encodeIfPresent(fullDateOfBirth, forKey: .fullDateOfBirth)
        try container.encodeIfPresent(address, forKey: .address)
        try container.encodeIfPresent(telephone, forKey: .telephone)
        try container.encodeIfPresent(profession, forKey: .profession)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(personalSummary, forKey: .personalSummary)
        try container.encodeIfPresent(otherValidTravelDocumentNumbers, forKey: .otherValidTravelDocumentNumbers)
        try container.encodeIfPresent(custodyInformation, forKey: .custodyInformation)
    }
}

extension DisplayedSignatureOrUsualMark: Encodable {
    
    enum Keys: String, CodingKey {
        case displayedSignatureOrUsualMarkImage
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(displayedSignatureOrUsualMarkImage, forKey: .displayedSignatureOrUsualMarkImage)
    }
}

extension EncodedIdentificationFeaturesFace: Encodable {
    
    enum Keys: String, CodingKey {
        case faceImage
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(faceImage, forKey: .faceImage)
    }
}

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
        case jpeg
        case jpeg2000
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

extension MachineReadableZoneInformation: Encodable {
    
    enum Keys: String, CodingKey {
        case documentCode
        case issuingStateOrOrganization
        case nameOfHolder
        case nationality
        case documentNumber
        case dateOfBirth
        case sex
        case dateOfExpiry
        case optionalData
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(documentCode, forKey: .documentCode)
        try container.encode(issuingStateOrOrganization, forKey: .issuingStateOrOrganization)
        try container.encode(nameOfHolder, forKey: .nameOfHolder)
        try container.encode(nationality, forKey: .nationality)
        try container.encode(documentNumber, forKey: .documentNumber)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encode(sex, forKey: .sex)
        try container.encode(dateOfExpiry, forKey: .dateOfExpiry)
        try container.encode(optionalData, forKey: .optionalData)
    }
}

extension NameOfHolder: Encodable {
    
    enum Keys: String, CodingKey {
        case primaryIdentifier
        case secondaryIdentifier
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(primaryIdentifier, forKey: .primaryIdentifier)
        try container.encodeIfPresent(secondaryIdentifier, forKey: .secondaryIdentifier)
    }
}

extension LdsMasterFile: Encodable {
    
    enum Keys: String, CodingKey {
        case lds1eMrtdApplication
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(lds1eMrtdApplication, forKey: .lds1eMrtdApplication)
    }
}

extension Lds1eMrtdApplication: Encodable {
    
    enum Keys: String, CodingKey {
        case comHeaderAndDataGroupPresenceInformation
        case sodDocumentSecurityObject
        case dg1MachineReadableZoneInformation
        case dg2EncodedIdentificationFeaturesFace
        case dg3AdditionalIdentificationFeatureFingers
        case dg4AdditionalIdentificationFeatureIrises
        case dg5DisplayedPortrait
        case dg7DisplayedSignatureOrUsualMark
        case dg8DataFeatures
        case dg9StructureFeatures
        case dg10SubstanceFeatures
        case dg11AdditionalPersonalDetails
        case dg12AdditionalDocumentDetails
        case dg13OptionalDetails
        case dg14SecurityOptions
        case dg15ActiveAuthenticationPublicKeyInfo
        case dg16PersonsToNotify
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(comHeaderAndDataGroupPresenceInformation, forKey: .comHeaderAndDataGroupPresenceInformation)
        try container.encode(sodDocumentSecurityObject, forKey: .sodDocumentSecurityObject)
        try container.encode(dg1MachineReadableZoneInformation, forKey: .dg1MachineReadableZoneInformation)
        try container.encode(dg2EncodedIdentificationFeaturesFace, forKey: .dg2EncodedIdentificationFeaturesFace)
        try container.encodeIfPresent(dg3AdditionalIdentificationFeatureFingers, forKey: .dg3AdditionalIdentificationFeatureFingers)
        try container.encodeIfPresent(dg4AdditionalIdentificationFeatureIrises, forKey: .dg4AdditionalIdentificationFeatureIrises)
        try container.encodeIfPresent(dg5DisplayedPortrait, forKey: .dg5DisplayedPortrait)
        try container.encodeIfPresent(dg7DisplayedSignatureOrUsualMark, forKey: .dg7DisplayedSignatureOrUsualMark)
        try container.encodeIfPresent(dg8DataFeatures, forKey: .dg8DataFeatures)
        try container.encodeIfPresent(dg9StructureFeatures, forKey: .dg9StructureFeatures)
        try container.encodeIfPresent(dg10SubstanceFeatures, forKey: .dg10SubstanceFeatures)
        try container.encodeIfPresent(dg11AdditionalPersonalDetails, forKey: .dg11AdditionalPersonalDetails)
        try container.encodeIfPresent(dg12AdditionalDocumentDetails, forKey: .dg12AdditionalDocumentDetails)
        try container.encodeIfPresent(dg13OptionalDetails, forKey: .dg13OptionalDetails)
        try container.encodeIfPresent(dg14SecurityOptions, forKey: .dg14SecurityOptions)
        try container.encodeIfPresent(dg15ActiveAuthenticationPublicKeyInfo, forKey: .dg15ActiveAuthenticationPublicKeyInfo)
        try container.encodeIfPresent(dg16PersonsToNotify, forKey: .dg16PersonsToNotify)
    }
}

extension Lds1ElementaryFile: Encodable {
    
    enum Keys: String, CodingKey {
        case bytes
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(bytes?.description, forKey: .bytes)
    }
}

extension AccessControlProtocol: Encodable {
    
    enum Keys: String, CodingKey {
        case bac
        case pace
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.description)
    }
}

extension AuthenticationStatus: Encodable {
   
    enum Keys: String, CodingKey {
        case data
        case chip
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(data, forKey: .data)
        try container.encode(chip, forKey: .chip)
    }
}

extension DataAuthenticationStatus: Encodable {
   
    enum Keys: String, CodingKey {
        case status
        case authenticationProtocol
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(status.description, forKey: .status)
        try container.encode(authenticationProtocol.description, forKey: .authenticationProtocol)
    }
}

extension ChipAuthenticationStatus: Encodable {
   
    enum Keys: String, CodingKey {
        case status
        case authenticationProtocol
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(status.description, forKey: .status)
        try container.encodeIfPresent(authenticationProtocol?.authenticationProtocol.description, forKey: .authenticationProtocol)
    }
}
