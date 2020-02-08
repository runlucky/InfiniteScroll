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
    private var isWorking = false
    private var db = Realm()

    private var _source: [City] = []
    private var source: [City] {
        get { _source }
        set {
            _source = newValue.sortedDescending()
            citiesTableView.reloadData()
        }
    }

    private let loadingCell = Bundle.main.loadNibNamed(TableViewCells.LoadingCellView.rawValue, owner: self, options: nil)?.first as! UITableViewCell

    var fetchDate = Date(timeIntervalSince1970: 1580719383)  // どこまでサーバーから取得したか。初期値は現在時刻
    let fetchRange: TimeInterval = 2                         // 1回の通信での取得数
    let fetchLimit = Date(timeIntervalSince1970: 1580719340) // 過去に遡る限界に日付
    let fetchThreshold = 5                                   // 残りセル数がこの数以下になったら取得


    override func viewDidLoad() {
        super.viewDidLoad()

        source = db.getCities()

        citiesTableView.delegate = self
        citiesTableView.dataSource = self

        fetchData()
    }

    private func fetchData() {
        if isWorking { return }
        isWorking = true
        citiesTableView.reloadData()
        let range: ClosedRange<Date> = (fetchDate.addingTimeInterval(-fetchRange))...fetchDate
        CaCities.getServerCities(range) { cities in
            self.isWorking = false
            self.fetchDate = range.lowerBound
            self.db.add(cities: cities)
            self.source = self.db.getCities()
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        isWorking ? 2 : 1
    }
}

extension InfiniteScrollViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isWorking { return }
        if fetchDate < fetchLimit { return }

        if (source.count - indexPath.row) < fetchThreshold {
            fetchData()
            return
        }

        if source[indexPath.row].timestamp < fetchDate {
            fetchData()
            return
        }
    }
}

extension InfiniteScrollViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? source.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = citiesTableView.dequeueReusableCell(withIdentifier: TableViewCells.BasicTableCell.rawValue, for: indexPath)
            cell.textLabel?.text = source[indexPath.row].description
            return cell
        }
        return loadingCell
    }
}
