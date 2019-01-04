//
//  UpdateDetailJSONFetcher.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/02.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

public class UpdateDetailJSONFetcher {
    
    public typealias Result = UppsalaResult<Data, FetchingError>
    
    public enum FetchingError: Error {
        case network(Error, URLResponse?)
        case invalidData(URLResponse?)
        case decodeFailure(Error)
    }
    
    // MARK: - Methods
    
    /**
     Fetch the raw data from URL.
     TODO: Move to the extension
     
     - Parameters:
       - url: The `URL` to fetch.
       - completion: Called after fetching with the argument of `Result<Data, FetchingError>`.
     */
    public func fetch(from url: URL, completion: ((Result) -> Void)? = nil) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion?(.error(.network(error, response)))
                return
            }
            guard let data = data else {
                completion?(.error(.invalidData(response)))
                return
            }
            
           completion?(.ok(data))
        }.resume()
    }
    
}
