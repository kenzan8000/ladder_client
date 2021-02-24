import KeychainAccess
import os
import SwiftUI

let logger = Logger(subsystem: "\(Bundle.main.bundleIdentifier ?? "").logger", category: "main")

// MARK: - LadderClientApp
@main
struct LadderClientApp: App {
  // MARK: property
  
  var body: some Scene {
    WindowGroup {
      LDRTabView(
        loginViewModel: LDRLoginViewModel(),
        feedViewModel: LDRFeedViewModel(),
        pinViewModel: LDRPinViewModel()
      )
    }
  }
  
  // MARK: initialization
  
  init() {
    /*
    if let url = LDRRequestHelper.createUrl(path: LDRApi.login) {
      if url.host != nil {
        if let session = Keychain(
          service: LDRKeychain.serviceName,
          accessGroup: LDRKeychain.suiteName
          )[LDRKeychain.session] {
          let cookies = HTTPCookie.cookies(
            withResponseHeaderFields: ["Set-Cookie": "\(LDR.cookieName)=\(session)"],
            for: url
          )
          for cookie in cookies {
              HTTPCookieStorage.shared.setCookie(cookie)
          }
        }
      }
    }
    */
  }
}
