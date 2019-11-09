//
//  ButtonDesign.swift
//  Crime Reporting
//
//  Created by Kashif Rizwan on 7/17/19.
//  Copyright © 2019 Kashif Rizwan. All rights reserved.
//

import UIKit

@IBDesignable class ButtonDesign: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        styleButton()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        styleButton()
    }
    
    func styleButton() {
        layer.cornerRadius = frame.size.height / 2
    }

}
