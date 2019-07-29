//
//  PopUpWindow.swift
//  PopUpWindow
//
//  Created by Afsal's Macbook Pro on 29/07/2019.
//  Copyright © 2019 Afsal. All rights reserved.
//

import UIKit


class PopUpWindow: UIView {
    
    // MARK: - Properties
    
    var delegate: PopUpWindowDelegate?
    
    var showSuccessMessage: Bool? {
        didSet {
            guard let success = showSuccessMessage else { return }
            
            if success {
                self.checkLabel.text = "✓"
                self.checkLabel.textColor = UIColor.rgb(red: 147, green: 227, blue: 105)
                self.notificationLabel.text = "Sucess"
            } else {
                self.checkLabel.text = "x"
                self.checkLabel.textColor = UIColor.red
                self.notificationLabel.text = "Error"
            }
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainBlue()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let checkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 96)
        return label
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 24)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(checkLabel)
        checkLabel.centerY(inView: self, padding: -28)
        checkLabel.centerX(inView: self)
        
        addSubview(notificationLabel)
        notificationLabel.anchor(top: checkLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        notificationLabel.centerX(inView: self)
        
        addSubview(button)
        button.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, width: 0, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
}
