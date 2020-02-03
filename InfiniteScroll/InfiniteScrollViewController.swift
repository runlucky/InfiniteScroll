//
//  InfiniteScrollViewController.swift
//  InfiniteScroll
//
//  Created by Amay Singhal on 10/6/15.
//  Copyright © 2015 ple. All rights reserved.
//

import UIKit

class InfiniteScrollViewController: UIViewController {
    @IBOutlet private weak var citiesTableView: UITableView!
    private var canFetchMoreResults = true
    private var displayCities: [String] = [] {
        didSet { citiesTableView.reloadData() }
    }

    private struct Constants {
        static let FetchThreshold = 5 // a constant to determine when to fetch the results; anytime   difference between current displayed cell and your total results fall below this number you want to fetch the results and reload the table
        static let FetchLimit = 50 // results to fetch in single call
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        citiesTableView.delegate = self
        citiesTableView.dataSource = self

        fetchData(from: 0)
    }

    private func fetchData(from index: Int) {
        CaCities.getCities(from: index, andCount: Constants.FetchLimit) { cities in
            self.displayCities += cities
            self.canFetchMoreResults = !(cities.count < Constants.FetchLimit)
        }
    }
}

extension InfiniteScrollViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (displayCities.count - indexPath.row) == Constants.FetchThreshold && canFetchMoreResults {
            fetchData(from: displayCities.count)
        }
    }
}

extension InfiniteScrollViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: TableViewCells.BasicTableCell.rawValue, for: indexPath)
        cell.textLabel?.text = displayCities[indexPath.row]
        return cell
    }
}
