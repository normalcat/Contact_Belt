//
//  ViewController.swift
//  Contact_Belt
//
//  Created by Chao-I Chen on 2/1/18.
//  Copyright © 2018 Chao-I Chen. All rights reserved.
//

import UIKit
import CoreData

class ContactTableViewController: UITableViewController, AddContactDelegate{
    var show: Bool = false
    var Contacts: [Contact] = []
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func itemSaved(by controller: AddContactViewController, with fname: String, with lname: String, with number: String, with index: IndexPath?){
        if let idx = index {
            let cell = Contacts[idx.row]
            cell.fname = fname
            cell.lname = lname
            cell.number = number
        }else{
            let newItem = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedObjectContext) as! Contact
            newItem.fname = fname
            newItem.lname = lname
            newItem.number = number
        }
        
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        fetchAll()
        
        dismiss(animated: true, completion: nil)
    }
    
    func itemCancle(by controller: AddContactViewController){
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let half_dest = segue.destination as! UINavigationController
            let destination = half_dest.topViewController as! AddContactViewController
            destination.delegate = self
        
            if let indexPath = sender as? IndexPath{
                let contact = Contacts[indexPath.row]
                destination.fnameString = contact.fname
                destination.lnameString = contact.lname
                destination.numberString = contact.number
                destination.index = indexPath
                destination.show = self.show
                self.show = false
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showActionSheet(indexPath: indexPath)
    }
    
    func showActionSheet(indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let show = UIAlertAction(title: "Show", style: .default){ action in
            self.show = true
            self.performSegue(withIdentifier: "Edit", sender: indexPath)
        }
        
        let delete = UIAlertAction(title: "Delete", style: .destructive){ action in
            let cell = self.Contacts[indexPath.row]
            self.managedObjectContext.delete(cell)
            do{
                try self.managedObjectContext.save()
            }catch{
                print(error)
            }
            self.fetchAll()
        }
        
        let edit = UIAlertAction(title: "Edit", style: .default){ action in
            self.performSegue(withIdentifier: "Edit", sender: indexPath)
        }
        
        actionSheet.addAction(edit)
        actionSheet.addAction(show)
        actionSheet.addAction(delete)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let contact = Contacts[indexPath.row]
        
        cell.textLabel?.text = contact.fname! + " " + contact.lname!
        cell.detailTextLabel?.text = contact.number
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contacts.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func fetchAll(){
        Contacts.removeAll()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
      //  request.predicate = NSPredicate(format: "beat = %@", false as CVarArg)
        do{
            let result = try managedObjectContext.fetch(request)
            Contacts = result as! [Contact]
            tableView.reloadData()
        }
        catch{
            print("\(error)")
        }
        
    }
}

