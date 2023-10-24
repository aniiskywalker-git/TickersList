//
//  LoadingView.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import UIKit

class LoadingView {

    internal static var spinner: UIActivityIndicatorView?

    static func show() {
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .large
                window.addSubview(spinner)

                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }
}
