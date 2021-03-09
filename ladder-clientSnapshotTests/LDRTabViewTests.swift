import SnapshotTesting
import SwiftUI
import XCTest
@testable import ladder_client

// MARK: - LDRTabViewTests
class LDRTabViewTests: XCTestCase {

  // MARK: life cycle
  
  override func setUpWithError() throws {
    super.setUp()
  }

  override func tearDownWithError() throws {
    super.tearDown()
  }

  // MARK: test
  
  func testLDRTabView_whenSelectedTabIsFeed_snapshotTesting() throws {
    let storageProvider = LDRStorageProvider(name: LDR.coreData, group: LDR.testGroup)
    let sut = UIHostingController(
      rootView: LDRTabView(
        selected: LDRTabView.Tab.feed,
        feedViewModel: LDRFeedViewModel(storageProvider: storageProvider),
        pinViewModel: LDRPinViewModel(storageProvider: storageProvider)
      )
    )
    
    [(UIUserInterfaceStyle.dark, "dark"), (UIUserInterfaceStyle.light, "light")].forEach { style, named in
      sut.overrideUserInterfaceStyle = style
      assertSnapshot(
        matching: sut,
        as: .image(on: .iPhone8, precision: 0.95, traits: .iPhone8(.portrait)),
        named: named
      )
      assertSnapshot(
        matching: sut,
        as: .recursiveDescription(on: .iPhone8),
        named: named
      )
    }
  }
  
  func testLDRTabView_whenSelectedTabIsPin_snapshotTesting() throws {
    let storageProvider = LDRStorageProvider(name: LDR.coreData, group: LDR.testGroup)
    let sut = UIHostingController(
      rootView: LDRTabView(
        selected: LDRTabView.Tab.pin,
        feedViewModel: LDRFeedViewModel(storageProvider: storageProvider),
        pinViewModel: LDRPinViewModel(storageProvider: storageProvider)
      )
    )
    
    [(UIUserInterfaceStyle.dark, "dark"), (UIUserInterfaceStyle.light, "light")].forEach { style, named in
      sut.overrideUserInterfaceStyle = style
      assertSnapshot(
        matching: sut,
        as: .image(on: .iPhone8, precision: 0.95, traits: .iPhone8(.portrait)),
        named: named
      )
      assertSnapshot(
        matching: sut,
        as: .recursiveDescription(on: .iPhone8),
        named: named
      )
    }
  }
}

// MARK: - LDR + Tests
extension LDR {
  static let testGroup = "org.kenzan8000.ladder-client.test"
}