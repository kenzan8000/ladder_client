import Foundation


/// MARK: - NSURL+Queries
extension URL {

    /// MARK: - Initialization
    
    /// create URL with url queries
    ///
    /// - Parameters:
    ///   - url: base url
    ///   - parameters: url queries
    init?(url: URL, parameters: Dictionary<String, String>) {
        var string = url.absoluteString
        var i: Int = 0
        for (key, value) in parameters {
            if i == 0 { string += "?" }
            else { string += "&" }

            let encodedKey = NSString(string: key).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) as String?
            let encodedValue = NSString(string: value).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) as String?
            string += encodedKey! + "=" + encodedValue!
            i += 1
        }

        self.init(string: string)
    }


    /// MARK: - public api
}
