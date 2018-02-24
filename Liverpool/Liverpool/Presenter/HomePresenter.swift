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
  
  private func getListViewModelFrom(_ obj: Any) -> ListViewModel? {
    guard
      let item = obj as? [String:Any],
      let attributes = item["attributes"] as? [String: Any],
      let title = attributes["product.displayName"] as? [String], let titleString = title.first,
      let price = attributes["sku.list_Price"] as? [String], let priceString = price.first,
      let urlImage = attributes["product.smallImage"] as? [String], let urlImageString = urlImage.first
      else { return nil }
    return ListViewModel(title: titleString, price: "$\(priceString)", imgURL: urlImageString)
  }
}

extension HomePresenter: HomePresentable {
  func search(_ category: String) {
    apiCall.search(category)
  }
}

extension HomePresenter: APIDelegate {
  func recivedData(_ data: [Any]) {

    let dataForView = data.flatMap {getListViewModelFrom($0)}
    view.updateViewWith(dataForView)
  }
  
  func failed() {
  }
}
