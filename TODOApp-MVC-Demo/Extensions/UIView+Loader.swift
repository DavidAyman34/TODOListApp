//
//  UIView+Loader.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 11/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

extension UIView {
    
    func showLoader() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func hideLoader() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.color = .darkText
        activityIndicator.tintColor = .blue
        activityIndicator.center = self.center
        activityIndicator.style = .gray
        activityIndicator.tag = 333
        return activityIndicator
    }
}
