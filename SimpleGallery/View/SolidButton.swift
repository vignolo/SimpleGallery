//
//  FormButton.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 04/09/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class SolidButton: UIButton {
    
    var cornerRadius: CGFloat = 5.0
    var color: UIColor? = UIColor(templateColor: .pink)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    func configureView() {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.masksToBounds = true
        
        self.backgroundColor = self.color
    }
}
