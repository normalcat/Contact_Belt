//
//  AddContactViewController.swift
//  Contact_Belt
//
//  Created by Chao-I Chen on 2/1/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var fnameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var lnameLabel: UILabel!
    
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var lnameText: UITextField!
    @IBOutlet weak var fnameText: UITextField!
    var fnameString: String?
    var lnameString: String?
    var numberString: String?
    var index: IndexPath?
    var show: Bool?
    
    weak var delegate: AddContactDelegate?
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        delegate?.itemSaved(by: self, with: fnameText.text!, with: lnameText.text!, with: numberText.text!, with: index)
    }
    
    @IBAction func canclePressed(_ sender: UIBarButtonItem) {
        delegate?.itemCancle(by: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index != nil{
            fnameText.text = fnameString
            lnameText.text = lnameString
            numberText.text = numberString
            if let x = show as? Bool{
                if x == false{
                    navigationItem.title = "Edit Contact"
                }else{
                    navigationItem.title = fnameString
                    fnameLabel.text = "Name:    " + fnameString! + " " + lnameString!
                    fnameLabel.sizeToFit()
                    lnameLabel.isHidden = true
                    fnameText.isHidden = true
                    lnameText.isHidden = true
                    numberText.isHidden = true
                    numberLabel.text = "Number: " + numberString!
                    numberLabel.sizeToFit()
                    cancelButton.title = ""
                    saveButton.title = "Done"
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
