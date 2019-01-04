//
//  URLSession+fetch.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/04.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

internal extension URLSession {
    
    typealias Result = UppsalaResult<Data, FetchingError>
    
    enum FetchingError: Error {
        case network(Error, URLResponse?)
        case invalidData(URLResponse?)
    }
    
    /**
     Fetch the raw data from URL.
     
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
