//
//  WebKitViewController.swift
//  DeveloperHit
//
//  Created by Yang Li on 08/11/2017.
//  Copyright © 2017 Yang LI. All rights reserved.
//

import UIKit

class WebKitViewController: UIViewController, UIWebViewDelegate {
  let webView = UIWebView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.frame = self.view.frame
    webView.delegate = self
    self.view.addSubview(webView)

    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
    rightSwipe.direction = .right
    view.addGestureRecognizer(rightSwipe)
  }
  
  @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
    self.dismiss(animated: true, completion: nil)
  }
}
