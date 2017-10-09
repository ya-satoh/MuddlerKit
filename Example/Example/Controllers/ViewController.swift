//
//  ViewController.swift
//  Example
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit
import MuddlerKit

final class ViewController: UIViewController {

    @IBOutlet fileprivate private(set) weak var tableView: UITableView!
    var dataSource: [Menu] = Menu.all()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.mk.deselectRow()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.mk.sizeToFitFooterView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func prepareTableView() {
        tableView.registerNib(SampleCell.self)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SampleCell.self, for: indexPath)
        cell.label.text = dataSource[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource[indexPath.row] {
        case .adjustsScrollView:
            performSegue(withIdentifier: "ShowAdjustScrollView", sender: indexPath)
        default:
            performSegue(withIdentifier: "ShowDetail", sender: indexPath)
        }
    }
}

enum Menu {
    case adjustsScrollView
    case other

    var name: String {
        switch self {
        case .adjustsScrollView:
            return "UIViewController#manuallyAdjustsScrollViewInsetsAndOffset"
        case .other:
            return "other"
        }
    }

    static func all() -> [Menu] {
        return [.adjustsScrollView]
    }
}
