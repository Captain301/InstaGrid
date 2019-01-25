//
//  GridSelect.swift
//  Instagrid
//
//  Created by rgrb on 14/01/2019.
//  Copyright © 2019 rgrb. All rights reserved.
//

import UIKit

class GridChoiceButton: UIButton {
    
    enum States {
        case standard, selected
    }
    
    let select = UIImage(named: "validate")
    let standard = UIImage(named: "standard")
    
    func changeState(_ states: States){
        switch states {
        case .standard:
            self.setBackgroundImage(standard, for: .normal)
        case .selected:
            self.setBackgroundImage(select, for: .normal)
        }
    }

}
