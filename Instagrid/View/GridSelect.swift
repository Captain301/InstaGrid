//
//  GridSelect.swift
//  Instagrid
//
//  Created by rgrb on 14/01/2019.
//  Copyright © 2019 rgrb. All rights reserved.
//

import UIKit

class GridSelect: UIButton {
    
    enum Style {
        case standard, validate
    }
    
    let valid = UIImage(named: "validate")
    let standard = UIImage(named: "standard")
    
    private func setStyle(_ style: Style){
        switch style {
        case .standard:
            self.setBackgroundImage(valid, for: .normal)
        case .validate:
            self.setBackgroundImage(standard, for: .normal)
        }
    }
    
    var style:Style = .standard {
        didSet {
            setStyle(style)
        }
    }

}
