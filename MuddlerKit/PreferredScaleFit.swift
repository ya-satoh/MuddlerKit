//
//  PreferredScaleFit.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2016/12/29.
//  Copyright © 2016年 Kosuke Matsuda. All rights reserved.
//

import UIKit

// Adjusts preferred scale to superview's frame when added to superview
// Mainly used that there are UILabels in UITableViewCell.
//
// override didMoveToSuperview and call adjustsPreferredScaleToFitWidth
public protocol PreferredScaleFit {
    func adjustsPreferredScaleToFitWidth()
}

public extension PreferredScaleFit where Self: UIView {
    func adjustsPreferredScaleToFitWidth() {
        if let s = superview, frame != s.frame {
            frame.size.width = s.frame.width
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}
