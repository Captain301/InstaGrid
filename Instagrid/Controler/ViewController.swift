//
//  ViewController.swift
//  Instagrid
//
//  Created by rgrb on 14/01/2019.
//  Copyright © 2019 rgrb. All rights reserved.
//

// bug details: when view jump to -1000 the view is hidden but when i move view in -200 she is no hidden end execute animation correctly.

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var InstagridLabel: UILabel!
    @IBOutlet weak var directionToSwipe: UILabel!
    @IBOutlet weak var textForDirection: UILabel!
    
    @IBOutlet weak var GridView: UIView!
    var currentImageButton: GridButton!
    required init?(coder aDecoder: NSCoder) {
        self.currentImageButton = btnGrid2
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var btnGridSelect1: GridChoiceButton!
    @IBOutlet weak var btnGridSelect2: GridChoiceButton!
    @IBOutlet weak var btnGridSelect3: GridChoiceButton!
    
    @IBOutlet weak var btnGrid1: GridButton!
    @IBOutlet weak var btnGrid2: GridButton!
    @IBOutlet weak var btnGrid3: GridButton!
    @IBOutlet weak var btnGrid4: GridButton!
    
    
    func formatButtonSize(btn: GridButton, x: CGFloat ,y: CGFloat ,w: CGFloat ,h: CGFloat){
            btn.frame.size.width = w
            btn.frame.size.height = h
            btn.frame.origin.x = x
            btn.frame.origin.y = y
    }
    
    @IBAction func btnGridSelectAct1(_ sender: Any) {
        btnGrid4.isHidden = true
        formatButtonSize(btn: btnGrid1, x: 8, y: 129, w: 113, h: 113)
        formatButtonSize(btn: btnGrid2, x: 129, y: 129, w: 113, h: 113)
        formatButtonSize(btn: btnGrid3, x: 8, y:8, w: 234, h: 113)
        userSelectButton(btn: btnGridSelect1, btnInt: 1)
        refreshButtonTitle(gridButton: btnGrid1)
    }
    
    func startParameter(){
        GridView.isHidden = false
        btnGrid4.isHidden = true
        formatButtonSize(btn: btnGrid1, x: 8, y: 8, w: 113, h: 113)
        formatButtonSize(btn: btnGrid3, x: 8, y: 129, w: 234, h: 113)
        formatButtonSize(btn: btnGrid2, x: 129, y: 8, w: 113, h: 113)
        userSelectButton(btn: btnGridSelect2, btnInt: 2)
    }
    
    @IBAction func btnGridSelectAct2(_ sender: Any) {
        btnGrid4.isHidden = true
        formatButtonSize(btn: btnGrid1, x: 8, y: 8, w: 113, h: 113)
        formatButtonSize(btn: btnGrid3, x: 8, y: 129, w: 234, h: 113)
        formatButtonSize(btn: btnGrid2, x: 129, y: 8, w: 113, h: 113)
        userSelectButton(btn: btnGridSelect2, btnInt: 2)
        refreshButtonTitle(gridButton: btnGrid2)
    }
    @IBAction func btnGridSelectAct3(_ sender: Any) {
        btnGrid4.isHidden = false
        formatButtonSize(btn: btnGrid1, x: 8, y: 8, w: 113, h: 113)
        formatButtonSize(btn: btnGrid2, x: 129, y: 8, w: 113, h: 113)
        formatButtonSize(btn: btnGrid3, x: 8, y: 129, w: 113, h: 113)
        formatButtonSize(btn: btnGrid4, x: 129, y: 129, w: 113, h: 113)
        userSelectButton(btn: btnGridSelect3, btnInt: 3)
        refreshButtonTitle(gridButton: btnGrid3)
    }
    
    func userSelectButton(btn: GridChoiceButton, btnInt: Int){
        btnGridSelect1.changeState(.standard, Btn: 1)
        btnGridSelect2.changeState(.standard, Btn: 2)
        btnGridSelect3.changeState(.standard, Btn: 3)
        btn.changeState(.selected, Btn: btnInt)
        
    }
    
    func refreshButtonTitle(gridButton: GridButton){
        if gridButton.imageAssigned == false{btnGrid1.setTitle("+", for: .normal)}
    }
    
    // UIActivityControler apear for user select his image
    private func chooseImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    

    // When iphone orientation change -> label change
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.directionToSwipe.text = "<"
                self.textForDirection.text = "swipe left for shared"
            } else {
                self.directionToSwipe.text = "^"
                self.textForDirection.text = "swipe up for shared"
            }
        })
    }
    
    @IBAction func buttonAddImage1(_ sender: Any) {
        chooseImage()
        currentImageButton = btnGrid1
    }
    @IBAction func buttonAddImage2(_ sender: Any) {
        chooseImage()
        currentImageButton = btnGrid2
    }
    @IBAction func buttonAddImage3(_ sender: Any) {
        chooseImage()
        currentImageButton = btnGrid3
    }
    @IBAction func buttonAddImage4(_ sender: Any) {
        chooseImage()
        currentImageButton = btnGrid4
    }
    
    // re-assign new background on GridButton with user image selected
    private func newButtonBackground(img: UIImage, btn: GridButton){
        let mainImageView = UIImageView(image:img)
        mainImageView.contentMode = .scaleAspectFit
        print("assignation d'image")
        btn.setBackgroundImage(mainImageView.image, for: .normal)
        print("image assigner")
        btn.setTitle("", for: .normal)
        btn.imageAssigned = true
    }
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        newButtonBackground(img: image, btn: currentImageButton)
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if UIApplication.shared.statusBarOrientation.isLandscape {
            self.directionToSwipe.text = "<"
            self.textForDirection.text = "swipe left for shared"
        } else {
            self.directionToSwipe.text = "^"
            self.textForDirection.text = "swipe up for shared"
        }
        
        startParameter()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGridView(_:)))
        GridView.addGestureRecognizer(panGestureRecognizer)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear((GridView != nil))
        print("========== DidAppear ===============")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear((GridView != nil))
        print("========== DidDisappear ============")
    }
    
    // method when user drag GridView to left or top, if is landscape or portrait
    @objc func dragGridView(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: GridView)
        let Y = translation.y
        let X = translation.x
        
        switch sender.state {
            
        case .began, .changed:
            if UIApplication.shared.statusBarOrientation.isLandscape {
                if  X < 0 {
                    GridView.transform = CGAffineTransform(translationX: X, y: 0)
                } else {
                    print("Pas de changement")
                }
            } else { // portrait
                if  Y < 0 {
                    GridView.transform = CGAffineTransform(translationX: 0, y: Y)
                } else {
                    print("Pas de changement")
                }
            }
            
        case .ended,.cancelled:
            if UIApplication.shared.statusBarOrientation.isLandscape {
                if  X < 0 {
                    GridView.transform = CGAffineTransform(translationX: 0, y: Y - 100)
                    sharedGridImage()
                } else {
                    print("Pas de changement")
                }
            } else {
                if  Y < 0 {
                    sharedGridImage()
                } else {
                    print("Pas de changement")
                }
            }
            
        default:
            break
        }
        
    }
    
    private func gridViewDragTop(){
        if UIApplication.shared.statusBarOrientation.isLandscape {
            GridView.transform = CGAffineTransform(translationX: -1000, y: 0)
        } else {
            GridView.transform = CGAffineTransform(translationX: 0, y: -1000)
        }
    }
    
    private func gridViewDragBot(){
        if UIApplication.shared.statusBarOrientation.isLandscape {
            GridView.transform = CGAffineTransform(translationX: -500, y: 0)
            GridView.transform = CGAffineTransform(translationX: -400, y: 0)
            GridView.transform = CGAffineTransform(translationX: -300, y: 0)
            GridView.transform = CGAffineTransform(translationX: -200, y: 0)
            GridView.transform = CGAffineTransform(translationX: -100, y: 0)
            GridView.transform = CGAffineTransform(translationX: 0, y: 0)
        } else {
            GridView.transform = CGAffineTransform(translationX: 0, y: -500)
            print("Acte")
            GridView.transform = CGAffineTransform(translationX: 0, y: -400)
            print("Acte")
            GridView.transform = CGAffineTransform(translationX: 0, y: -300)
            print("Acte")
            GridView.transform = CGAffineTransform(translationX: 0, y: -200)
            print("Acte")
            GridView.transform = CGAffineTransform(translationX: 0, y: -100)
            print("Acte")
            GridView.transform = CGAffineTransform(translationX: 0, y: 0)
            print("Acte")
        }
    }
    
    // screen GridView for sharing image
    private func recupGridImage(view: UIView) -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    // shared image to user selected application
    private func sharedGridImage(){
        let image = recupGridImage(view: GridView)
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
        
        ac.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.GridView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}

