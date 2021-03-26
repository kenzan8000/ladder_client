import Combine
import Foundation
import XCTest
@testable import ladder_client

// MARK: - LDRRequest+PinAddTests
class LDRRequestPinAddTests: XCTestCase {

  // MARK: life cycle
  
  override func setUpWithError() throws {
    super.setUp()
  }

  override func tearDownWithError() throws {
    super.tearDown()
  }

  // MARK: test
  
  func testLDRRequestPinAdd_whenSucceeding_LDRPinAddResponseIsSuccessShouldBeTrue() throws {
    var result: LDRPinAddResponse? = nil
    let exp = expectation(description: #function)
    let sut = URLSession.shared.fakeSuccessPublisher(
      for: .pinAdd(
        title: "alextsui05 starred vercel/og-image",
        link: URL(string: "https://github.com/vercel/og-image") ?? URL(fileURLWithPath: "")
      )
    )

    _ = sut
      .sink(
        receiveCompletion: { _ in exp.fulfill() },
        receiveValue: { result = $0 }
      )
    
    wait(for: [exp], timeout: 0.1)
    XCTAssertNotNil(result)
    XCTAssertTrue(result?.isSuccess == true)
  }
  
  func testLDRRequestPinAdd_whenFailing_LDRPinAddResponseIsSuccessShouldBeFalse() throws {
    var result: LDRPinAddResponse? = nil
    let exp = expectation(description: #function)
    let sut = URLSession.shared.fakeFailurePublisher(
      for: .pinAdd(
        title: "alextsui05 starred vercel/og-image",
        link: URL(string: "https://github.com/vercel/og-image") ?? URL(fileURLWithPath: "")
      )
    )

    _ = sut
      .sink(
        receiveCompletion: { _ in exp.fulfill() },
        receiveValue: { result = $0 }
      )
    
    wait(for: [exp], timeout: 0.1)
    XCTAssertNotNil(result)
    XCTAssertTrue(result?.isSuccess == false)
  }
}

// MARK: - URLSession + Fake
extension URLSession {
  func fakeSuccessPublisher(for request: LDRRequest<LDRPinAddResponse>) -> AnyPublisher<LDRPinAddResponse, LDRError> {
    Future<LDRPinAddResponse, LDRError> { promise in
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let data = "{\"ErrorCode\": 0, \"isSuccess\": true}".data(using: .utf8)!
      let response = try! decoder.decode(LDRPinAddResponse.self, from: data)
      promise(.success(response))
    }
    .eraseToAnyPublisher()
  }
  
  func fakeFailurePublisher(for request: LDRRequest<LDRPinAddResponse>) -> AnyPublisher<LDRPinAddResponse, LDRError> {
    Future<LDRPinAddResponse, LDRError> { promise in
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let data = "{\"ErrorCode\": 400, \"isSuccess\": false}".data(using: .utf8)!
      let response = try! decoder.decode(LDRPinAddResponse.self, from: data)
      promise(.success(response))
    }
    .eraseToAnyPublisher()
  }
}
