//
//  APICall.swift
//  Liverpool
//
//  Created by RanfeDom on 2/24/18.
//  Copyright © 2018 Ranfelabs. All rights reserved.
//

import Foundation

protocol APIDelegate: class {
  func recivedData(_ data: [String:Any])
  func failed()
}

class APICall {
  weak var delegate : APIDelegate?

  func search(_ searchWord: String) {
    guard let delegate = delegate else { return }
    guard let endpointURL = URL(string: "https://www.liverpool.com.mx/tienda?s=\(searchWord)&d3106047a194921c01969dfdec083925=json") else { return }
    
    let endpointURLRequest = URLRequest(url: endpointURL)
    let session = URLSession.shared
    
    let task = session.dataTask(with: endpointURLRequest) { (data, response, error) in
      guard error == nil else { return delegate.failed()}
      guard let responseData = data else { return delegate.failed() }
      
      do {
        guard let receivedData = try JSONSerialization.jsonObject(with: responseData,
                                                                  options: []) as? [String: Any] else {
                                                                    print("Could not get JSON from responseData as dictionary")
                                                                    return
        }
        delegate.recivedData(receivedData)
      } catch  {
        delegate.failed()
        return
      }
    }
    task.resume()
  }
}
