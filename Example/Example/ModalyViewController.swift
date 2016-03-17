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

    @IBAction func tapBarItem(sender: AnyObject) {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            delegate.initialSetup()
        }
    }

    @IBAction func tapButton(sender: AnyObject) {
        let time = 1.0
        dispatch_async_main_after_time(time) {
            let alert = UIAlertController.alertController(title: "Dispatch", message: "dispatch_async_main_after_time : (\(time))")
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
