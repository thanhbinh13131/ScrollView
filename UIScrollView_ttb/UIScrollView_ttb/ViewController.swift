//
//  ViewController.swift
//  UIScrollView_ttb
//
//  Created by TTB on 5/5/17.
//  Copyright © 2017 TTB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var activeTextField: UITextField?
    
    @IBOutlet weak var scrollView: UIScrollView!
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeTextField = textField
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillBeHidden:")), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func keyboardWillShow(_ sender: NSNotification) {
        
        // 1
        
        let userInfo: [AnyHashable : Any] = sender.userInfo!
        
        // 2
        let keyboardSize: CGSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]!) as AnyObject).cgRectValue.size
        
        let offset: CGSize = ((userInfo[UIKeyboardFrameEndUserInfoKey]!) as AnyObject).cgRectValue.size
        
        // 3
        if keyboardSize.height == offset.height {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                self.view.frame.origin.y -= keyboardSize.height
                
            })
            
        } else {
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                
                self.view.frame.origin.y += keyboardSize.height - offset.height
                
            })
        }
    }

    func keyboardDidShow(_ sender: NSNotification) {
        let userInfo: [AnyHashable : Any] = sender.userInfo!
        
        
        if let activeField = self.activeTextField, let kkeyboardSize: CGSize = ((userInfo[UIKeyboardFrameBeginUserInfoKey]!) as AnyObject).cgRectValue.size{
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kkeyboardSize.height, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect = self.view.frame
        aRect.size.height -= kkeyboardSize.height
        if (!aRect.contains(activeField.frame.origin)) {
            self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
        }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
}

