//
//  MultipleTablesController.swift
//  Example
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit
import MuddlerKit

final class MultipleTablesController: UIViewController {

    @IBOutlet fileprivate weak var tableView1: UITableView!
    @IBOutlet fileprivate weak var tableView2: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        manuallyAdjustsScrollViewInsetsAndOffset(tableView2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension MultipleTablesController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === tableView1 {
            return 3
        } else {
            return 10
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        if tableView === tableView1 {
            cell?.textLabel?.text = "Menu: \(indexPath.row)"
        } else {
            cell?.textLabel?.text = "Content: \(indexPath.row)"
        }
        return cell!
    }
}
