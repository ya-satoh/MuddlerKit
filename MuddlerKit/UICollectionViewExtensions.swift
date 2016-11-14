//
//  UICollectionViewExtensions.swift
//  MuddlerKit
//
//  Created by Kosuke Matsuda on 2015/12/28.
//  Copyright © 2015年 Kosuke Matsuda. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func deselectRow() {
        if let indexPaths = self.indexPathsForSelectedItems {
            indexPaths.forEach { [weak self] (indexPath) -> Void in
                self?.deselectItem(at: indexPath, animated: true)
            }
        }
    }
}
