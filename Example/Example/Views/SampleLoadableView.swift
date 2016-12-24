//
//  SampleLoadableView.swift
//  Example
//
//  Created by Kosuke Matsuda on 2016/12/24.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit
import MuddlerKit

final class SampleLoadableView: UIView, NibLoadableView {

    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private(set) weak var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        loadContentViewFromNib()
        contentView.backgroundColor = UIColor.orange
        label.text = "This view conforms NibLoadableView."
    }
}
