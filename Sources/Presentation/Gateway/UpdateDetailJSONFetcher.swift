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
public class UpdateDetailFetcher {
    
    public typealias Result = UppsalaResult<UpdateDetail, Error>

    /**
     Fetchs JSON from the given URL and parses into `UpdateDetail`.
     
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
                    let updateDetail = try UpdateDetail.from(data: data)
                    completion(.ok(updateDetail))
                } catch let error {
                    completion(.error(error))
                }
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
}
