//
//  AddContactDelegate.swift
//  Contact_Belt
//
//  Created by Chao-I Chen on 2/1/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import Foundation

protocol AddContactDelegate: class {
    func itemSaved(by controller: AddContactViewController, with fname: String, with lname: String, with number: String, with index: IndexPath?)
    func itemCancle(by controller: AddContactViewController)
}
