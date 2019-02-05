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
    let standard1 = UIImage(named: "Boutton1")
    let standard2 = UIImage(named: "Boutton2")
    let standard3 = UIImage(named: "Boutton3")
    
    func changeState(_ states: States, Btn: Int){
        switch states {
        case .standard:
            if Btn == 1 { self.setBackgroundImage(standard1, for: .normal) }
            if Btn == 2 { self.setBackgroundImage(standard2, for: .normal) }
            if Btn == 3 { self.setBackgroundImage(standard3, for: .normal) }
        case .selected:
            self.setBackgroundImage(select, for: .normal)
        }
    }

}
