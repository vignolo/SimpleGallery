//
//  TextButton.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 04/09/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class TextButton: UIButton {
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
        self.setTitleColor(self.color, for: .normal)
    }
}
