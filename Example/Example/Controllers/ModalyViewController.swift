//
//  ModalyViewController.swift
//  Example
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit
import MuddlerKit

class ModalyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tapBarItem(_ sender: AnyObject) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.initialSetup()
        }
    }

    @IBAction func tapButton(_ sender: AnyObject) {
        print("remove `dispatch_async_main_after_time(_:)`")
    }
}
