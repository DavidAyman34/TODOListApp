//
//  Loader.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 12/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit


class ActivityIndicator {
    private init() {}
    
    //1
    static let shared = ActivityIndicator()
    
    //2
    let activityLabel = UILabel(frame: CGRect(x: 19, y: 0, width: 0, height: 0))
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: -5, y: 0, width: 20, height: 20))
    let activityView = UIView()
    
    func animateActivity(title: String, view: UIView, navigationItem: UINavigationItem) {
        //3
        guard navigationItem.titleView == nil else { return }
        
        //4
        activityIndicator.style = .gray
        activityLabel.text = title
        
        //5
        activityLabel.sizeToFit()
        
        //6
        let xPoint = view.frame.midX
        let yPoint = navigationItem.accessibilityFrame.midY
        let widthForActivityView = activityLabel.frame.width + activityIndicator.frame.width
        activityView.frame = CGRect(x: xPoint , y: yPoint, width: widthForActivityView, height: 30)
        
        activityLabel.center.y = activityView.center.y
        activityIndicator.center.y = activityView.center.y
        
        //7
        activityView.addSubview(activityIndicator)
        activityView.addSubview(activityLabel)
        
        //8
        navigationItem.titleView = activityView
        activityIndicator.startAnimating()
    }
    
    //9
    func stopAnimating(navigationItem: UINavigationItem) {
        activityIndicator.stopAnimating()
        navigationItem.titleView = nil
    }
}
