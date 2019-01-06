//
//  URLSession+fetch.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/04.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

extension URLSession {
    
    typealias Result = UppsalaResult<Data, FetchingError>
    
    /**
     Represents the reason of fetching error.
     */
    enum FetchingError: Error {
        /// Caused by bad network.
        case network(Error, URLResponse?)
        /// Caught unexpectedly broken data without an explicit error.
        case invalidData(URLResponse?)
    }
    
    /**
     Fetchs the raw data from URL.
     
     - Parameters:
       - url: The `URL` to fetch.
       - completion: Called after fetching with the argument of `Result<Data, FetchingError>`.
     */
    func fetch(from url: URL, completion: ((Result) -> Void)? = nil) {
        self.dataTask(with: url) { (data, response, error) in
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
