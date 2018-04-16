//
//  TitleLabel.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/11/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class MovieTitleLabel: UILabel {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
   /* // Override -intrinsicContentSize: for Auto layout code
    override var intrinsicContentSize: CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
    
    // Override -sizeThatFits: for Springs & Struts code
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSizeThatFits = super.sizeThatFits(size)
        let width = superSizeThatFits.width + padding.left + padding.right
        let heigth = superSizeThatFits.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }*/

}
