//
//  Uppsala+fetch.swift
//  Uppsala
//
//  Created by Suita Fujino on 2019/01/05.
//  Copyright © 2019 Suita Fujino. All rights reserved.
//

extension Uppsala {
    
    public func fetchAwait(from url: URL) -> UpdateDetailFetcher.Result {
        return UpdateDetailFetcher().fetchAwait(from: url)
    }
    
}
