//
//  HomePresenter.swift
//  Liverpool
//
//  Created by RanfeDom on 2/24/18.
//  Copyright © 2018 Ranfelabs. All rights reserved.
//

class HomePresenter {
  let apiCall = APICall()
  let view : HomeViewable

  init(_ view: HomeViewable) {
    self.view = view
    apiCall.delegate = self
  }
}

extension HomePresenter: HomePresentable {
  func search(_ category: String) {
    apiCall.search(category)
  }
}

extension HomePresenter: APIDelegate {
  func recivedData(_ data: [String : Any]) {
    print(data)
    
  }
  
  func failed() {
  }
}
