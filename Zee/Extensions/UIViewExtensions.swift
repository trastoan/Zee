//
//  UIViewExtensions.swift
//  Zee
//
//  Created by Yuri on 29/01/23.
//

import UIKit

extension UIView {
    func dropShadow(withOpacity opacity: Float = 0.2, radius: CGFloat = 5) {
        if !self.bounds.isEmpty && self.layer.shadowPath == nil {
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            self.layer.shadowOpacity = opacity
            self.layer.shadowRadius = radius
        }
    }
    
    func centerOn(view: UIView) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

