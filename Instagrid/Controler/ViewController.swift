//
//  ViewController.swift
//  Instagrid
//
//  Created by rgrb on 14/01/2019.
//  Copyright © 2019 rgrb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
        formatButtonSize(btn: btnGrid1, x: 8, y: 156, w: 138, h: 136)
        formatButtonSize(btn: btnGrid2, x: 154, y: 156, w: 138, h: 136)
        formatButtonSize(btn: btnGrid3, x: 8, y:8, w: 284, h: 140)
        userSelectButton(btn: btnGridSelect1)
        refreshButtonTitle()
    }
    
    func startParameter(){
        btnGrid4.isHidden = true
        formatButtonSize(btn: btnGrid1, x: 10, y: 8, w: 138, h: 140)
        formatButtonSize(btn: btnGrid3, x: 8, y: 156, w: 284, h: 136)
        formatButtonSize(btn: btnGrid2, x: 154, y: 8, w: 138, h: 140)
        userSelectButton(btn: btnGridSelect2)
        refreshButtonTitle()
    }
    
    @IBAction func btnGridSelectAct2(_ sender: Any) {
        btnGrid4.isHidden = true
        formatButtonSize(btn: btnGrid1, x: 10, y: 8, w: 138, h: 140)
        formatButtonSize(btn: btnGrid3, x: 8, y: 156, w: 284, h: 136)
        formatButtonSize(btn: btnGrid2, x: 154, y: 8, w: 138, h: 140)
        userSelectButton(btn: btnGridSelect2)
        refreshButtonTitle()
    }
    @IBAction func btnGridSelectAct3(_ sender: Any) {
        btnGrid4.isHidden = false
        formatButtonSize(btn: btnGrid1, x: 8, y: 8, w: 138, h: 140)
        formatButtonSize(btn: btnGrid2, x: 154, y: 8, w: 138, h: 140)
        formatButtonSize(btn: btnGrid3, x: 8, y: 156, w: 138, h: 136)
        formatButtonSize(btn: btnGrid4, x: 154, y: 156, w: 138, h: 136)
        userSelectButton(btn: btnGridSelect3)
        refreshButtonTitle()
    }
    
    func userSelectButton(btn: GridChoiceButton){
        btnGridSelect1.changeState(.standard)
        btnGridSelect2.changeState(.standard)
        btnGridSelect3.changeState(.standard)
        btn.changeState(.selected)
    }
    
    func refreshButtonTitle(){
        if btnGrid1.imageAssigned == false{btnGrid1.setTitle("+", for: .normal)}
        if btnGrid2.imageAssigned == false{btnGrid2.setTitle("+", for: .normal)}
        if btnGrid3.imageAssigned == false{btnGrid3.setTitle("+", for: .normal)}
        if btnGrid4.imageAssigned == false{btnGrid4.setTitle("+", for: .normal)}
    }
    
    func chooseImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo srouce", message: "choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
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
    
    func newButtonBackground(img: UIImage, btn: GridButton){
        btn.setBackgroundImage(img, for: .normal)
        btn.setTitle("", for: .normal)
        btn.imageAssigned = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        newButtonBackground(img: image, btn: currentImageButton)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //decalred gesture recognizer on GridView
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGridView(_:)))
        GridView.addGestureRecognizer(panGestureRecognizer)
    }
    
    //switch for different state of gesture
    @objc func dragGridView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformGridViewWith(gesture: sender)
        case .ended, .cancelled:
            afterDragGridView()
        default:
            break
        }
    }
    
    //Change Y position to GridView
    private func transformGridViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: GridView)
        GridView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
    }
    
    // réinitialized old UIview (GridView) position and shared image.
    private func afterDragGridView() {
        GridView.transform = CGAffineTransform(translationX: 0, y: 0)
        sharedGridImage()
    }
    
    // use this function to execute a screenshot of GridView and transform this UIView to UIImage for shared this.
    private func recupGridImage(view: UIView) -> UIImage{
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    // function for shared UIImage to application/Library or other.
    private func sharedGridImage(){
        let image = recupGridImage(view: GridView)
        let items = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    


}

