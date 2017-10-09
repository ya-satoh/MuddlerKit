//
//  UICollectionViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension Extension where Base: UICollectionView {
    public func deselectRow() {
        if let indexPaths = base.indexPathsForSelectedItems {
            indexPaths.forEach { indexPath in
                base.deselectItem(at: indexPath, animated: true)
            }
        }
    }
}
