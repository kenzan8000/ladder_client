import Combine
import KeychainAccess

// MARK: - LDRRequest + PinAll
extension LDRRequest where Response == LDRPinAllResponse {
  // MARK: static api
  
  /// Request retrieving all pins
  /// - Returns:
  static func pinAll() -> Self {
    let url = URL(ldrPath: LDRApi.Api.pinAll)
    let body = [
      "ApiKey": Keychain(service: .ldrServiceName, accessGroup: .ldrSuiteName)[LDRKeychain.apiKey] ?? ""
    ].HTTPBodyValue()
    return LDRRequest(
      url: url,
      method: .post(body),
      headers: .defaultHeader(url: url, body: body)
    )
  }
}

// MARK: - LDRPinAllResponse
typealias LDRPinAllResponse = [LDRPinResponse]

// MARK: - LDRPinResponse
struct LDRPinResponse: Decodable {
  // MARK: prooperty
  let createdOn: Int
  let link: String
  let title: String
}
