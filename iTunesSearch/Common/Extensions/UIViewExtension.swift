//
//  UIViewExtension.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIView {

    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    func showActivityIndicator() {
        DispatchQueue.main.async {
            let progressView = MBProgressHUD.showAdded(to: self, animated: true)
            progressView.animationType = .zoomIn
            progressView.areDefaultMotionEffectsEnabled = true
            progressView.backgroundView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
            progressView.bezelView.blurEffectStyle = .regular// this fixed the white color shift
            progressView.bezelView.backgroundColor = UIColor.label.withAlphaComponent(0.7)
            progressView.contentColor = .white

        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self, animated: true)
        }
    }

}
