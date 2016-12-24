//
//  SampleCell.swift
//  Example
//
//  Created by Kosuke Matsuda on 2016/12/24.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit
import MuddlerKit

final class SampleCell: UITableViewCell, ReusableView {

    @IBOutlet private(set) weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
