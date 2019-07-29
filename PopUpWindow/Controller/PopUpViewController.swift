//
//  PopUpViewController.swift
//  PopUpWindow
//
//  Created by Afsal's Macbook Pro on 29/07/2019.
//  Copyright © 2019 Afsal. All rights reserved.
//

import UIKit


class PopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    var success = true
    
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        
        view.delegate = self
        view.layer.cornerRadius = 5
        view.alpha = 1
        return view
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Pop Up Window", for: .normal)
        button.setTitleColor(.mainBlue(), for: .normal)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .mainBlue()
        configureViewComponents()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.addSubview(button)
        button.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width - 32, height: 50)
        button.centerX(inView: self.view)
        button.centerY(inView: self.view, padding: 0)
        
        self.view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        visualEffectView.alpha = 0
    }
    
    // MARK: - Selectors

    @objc func handleShowPopUp() {
        
        self.view.addSubview(self.popUpWindow)
        
        self.popUpWindow.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width - 64, height: self.view.frame.width - 64)
        self.popUpWindow.centerX(inView: self.view)
        self.popUpWindow.centerY(inView: self.view, padding: -40)
        
        success = !success 
        self.popUpWindow.showSuccessMessage = success
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = .identity
        }
    }
}

extension PopUpViewController: PopUpWindowDelegate {
    
    func handleDismissal() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
        }
    }
}
