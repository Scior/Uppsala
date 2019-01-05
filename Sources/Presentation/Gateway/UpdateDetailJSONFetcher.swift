//
//  UpdateDetailJSONFetcher.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

/**
 A class to fetch the remote JSON file of update information.
 */
public final class UpdateDetailFetcher {
    
    public typealias Result = UppsalaResult<UpdateDetail, Error>
    
    // MARK: - Constants
    
    public static let timeoutForFetching = 5.0

    /**
     Fetches JSON from the given URL and parses into `UpdateDetail`.
     The error will be a fetching error or a parsing error.
     
     - Parameters:
       - url: The JSON `URL` to fetch.
       - session: The `URLSession` to use. The default id `URLSession.shared`.
       - completion: Called after fetching with the argument of `Result<UpdateDetail, Error>`.
     */
    public func fetch(from url: URL, session: URLSession = URLSession.shared, completion: @escaping (Result) -> Void) {
        session.fetch(from: url) { result in
            switch result {
            case .ok(let data):
                do {
                    let entity = try UpdateDetailJSONEntity.from(data: data)
                    let updateDetail = try UpdateDetail(from: entity)
                    completion(.ok(updateDetail))
                } catch let error {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    /**
     Fetches JSON **synchronously** from the given URL and parses into `UpdateDetail`.
     
     - Parameters:
       - url: The JSON `URL` to fetch.
       - session: The `URLSession` to use. The default id `URLSession.shared`.
       - timeout: The `Double` value for timeout.
     
     - Returns: `Result<UpdateDetail, Error>?`.
     */
    public func fetchAwait(from url: URL, session: URLSession = URLSession.shared, timeout: Double = UpdateDetailFetcher.timeoutForFetching) -> Result {
        let semaphore = DispatchSemaphore(value: 0)
        var fetchingResult: Result?
        
        fetch(from: url) { (result) in
            semaphore.signal()
            fetchingResult = result
        }
        
        switch semaphore.wait(timeout: .now() + timeout) {
        case .success:
            return fetchingResult ?? .error(FetcherError.internalError)
        case .timedOut:
            return .error(FetcherError.timeout)
        }
    }
    
}

extension UpdateDetailFetcher {
    public enum FetcherError: Error {
        case internalError
        case timeout
    }
}
