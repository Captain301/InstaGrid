//
//  ViewController.swift
//  Instagrid
//
//  Created by rgrb on 14/01/2019.
//  Copyright © 2019 rgrb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnGridSelect1: GridSelect!
    @IBOutlet weak var btnGridSelect2: GridSelect!
    @IBOutlet weak var btnGridSelect3: GridSelect!
    
    @IBAction func btnGridSelectAct1(_ sender: Any) {
        userSelectButton(btn: btnGridSelect1)
    }
    @IBAction func btnGridSelectAct2(_ sender: Any) {
        userSelectButton(btn: btnGridSelect2)
    }
    @IBAction func btnGridSelectAct3(_ sender: Any) {
        userSelectButton(btn: btnGridSelect3)
    }
    
    func userSelectButton(btn: GridSelect){
        btnGridSelect1.style = .standard
        btnGridSelect2.style = .standard
        btnGridSelect3.style = .standard
        btn.style = .validate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    


}

