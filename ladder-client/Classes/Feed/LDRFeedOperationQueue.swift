// MARK: - LDRFeedOperationQueue
class LDRFeedOperationQueue: ISHTTPOperationQueue {

    /// MARK: - property

    static let shared = LDRFeedOperationQueue()


    /// MARK: - initialization

    override init() {
        super.init()
    }


    /// MARK: - destruction

    deinit {
        self.cancelAllOperations()
    }


    /// MARK: - public api

    /**
     * start
     * @param completionHandler (json: JSON?, error: Error?) -> Void
     **/
    func start(completionHandler: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        self.requestSubs(completionHandler: completionHandler)
    }

    /**
     * request subs
     * @param completionHandler (json: JSON?, error: Error?) -> Void
     **/
    func requestSubs(completionHandler: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        // stop all feed operations
        self.cancelAllOperations()
        self.maxConcurrentOperationCount = 1

        // invalid ApiKey
        let apiKey = UserDefaults.standard.string(forKey: LDRUserDefaults.apiKey)
        if apiKey == nil || apiKey == "" { completionHandler(nil, LDRError.invalidApiKey); return }
        // invalid url
        let url = LDRUrl(path: LDR.api.subs, params: ["unread": "1"])
        if url == nil { completionHandler(nil, LDRError.invalidLdrUrl); return }

        // request
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = ["ApiKey": apiKey!].HTTPBodyValue()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if request.httpBody != nil { request.setValue("\(request.httpBody!.count)", forHTTPHeaderField: "Content-Length") }

        self.addOperation(LDROperation(
            request: request as URLRequest!,
            handler:{ [unowned self] (response: HTTPURLResponse?, object: Any?, error: Error?) -> Void in
                var json = JSON([])
                do {
                    if object != nil {
                        json = try JSON(data: object as! Data)
                    }
                }
                catch {
                    self.cancelAllOperations()
                    LDRPinOperationQueue.shared.cancelAllOperations()
                    NotificationCenter.default.post(name: LDRNotificationCenter.didGetInvalidUrlOrUsernameOrPasswordError, object: nil)
                    completionHandler(nil, LDRError.invalidUrlOrUsernameOrPassword)
                    return
                }
                DispatchQueue.main.async { [unowned self] in
                    if error != nil { completionHandler(nil, error!); return }

                    completionHandler(json, nil)
                }
            }
        ))
    }

    /**
     * request unread
     * @param subscribeId String
     * @param completionHandler (json: JSON?, error: Error?) -> Void
     **/
    func requestUnread(subscribeId: String, completionHandler: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        self.maxConcurrentOperationCount = 5

        // invalid ApiKey
        let apiKey = UserDefaults.standard.string(forKey: LDRUserDefaults.apiKey)
        if apiKey == nil || apiKey == "" { completionHandler(nil, LDRError.invalidApiKey); return }
        // invalid url
        let url = LDRUrl(path: LDR.api.unread)
        if url == nil { completionHandler(nil, LDRError.invalidLdrUrl); return }

        // request
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = ["ApiKey": apiKey!, "subscribe_id": subscribeId].HTTPBodyValue()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if request.httpBody != nil { request.setValue("\(request.httpBody!.count)", forHTTPHeaderField: "Content-Length") }

        self.addOperation(LDROperation(
            request: request as URLRequest!,
            handler:{ [unowned self] (response: HTTPURLResponse?, object: Any?, error: Error?) -> Void in
                var json = JSON([])
                do {
                    if object != nil {
                        json = try JSON(data: object as! Data)
                    }
                }
                catch {
                    self.cancelAllOperations()
                    LDRPinOperationQueue.shared.cancelAllOperations()
                    NotificationCenter.default.post(name: LDRNotificationCenter.didGetInvalidUrlOrUsernameOrPasswordError, object: nil)
                    completionHandler(nil, LDRError.invalidUrlOrUsernameOrPassword)
                    return
                }
                DispatchQueue.main.async { [unowned self] in
                    if error != nil { completionHandler(nil, error!); return }

                    completionHandler(json, nil)
                }
            }
        ))

    }

    /**
     * request touch_all
     * @param subscribeId String
     * @param completionHandler (json: JSON?, error: Error?) -> Void
     **/
    func requestTouchAll(subscribeId: String, completionHandler: @escaping (_ json: JSON?, _ error: Error?) -> Void) {
        self.maxConcurrentOperationCount = 5
    }

}