//
//  ViewController.swift
//  Liverpool
//
//  Created by RanfeDom on 2/24/18.
//  Copyright © 2018 Ranfelabs. All rights reserved.
//

import UIKit
import SwiftSpinner

class ViewController: UIViewController {

  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var itemsTableView: UITableView!
  var items: [ListViewModel]?
  var presenter : HomePresentable?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    presenter = HomePresenter(self)
    itemsTableView.dataSource = self
    searchBar.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let items = items else { return 0}
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell, let items = items else { return UITableViewCell() }
    cell.configureCell(items[indexPath.row])
    return cell
  }
}

extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text, !text.isEmpty else { return }
    SwiftSpinner.show("Searching")
    searchBar.resignFirstResponder()
    presenter?.search(text)
  }
}

extension ViewController: HomeViewable {
  func updateViewWith(_ items: [ListViewModel]) {
    self.items = items
    DispatchQueue.main.async { [unowned self] in
      self.itemsTableView.reloadData()
      SwiftSpinner.hide()
    }
  }
}
