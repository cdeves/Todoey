//
//  ViewController.swift
//  Todoey
//
//  Created by Caitlin Sedwick on 7/9/18.
//  Copyright © 2018 Caitlin Sedwick. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "slay Demogorgon"
        itemArray.append(newItem3)
        
        //save items to the UserDefaults singleton.  This is bad.  Don't do it even if it looks like it works.
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //fix problem of checkmark appearing on recycled rows (part 2 of fix)
        //replace if/else for cell.accessoryType when item.done == true using a...
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
// MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //fix the problem of checkmark appearing on recycled rows (part 1 of fix)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        //reload the table view for each item to refresh checkmarks
        tableView.reloadData()
        
        //make the row unhighlight itself after it's been clicked
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // MARK - Add new items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //function variable to hold alert alertTextField data
        var textField = UITextField()
        //create an alert "Add New Todoey Item"...
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        //...that has an action "Add Item"
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
            //declare what will happen once the user clicks the add item button on our UIAlert
            
            //append item from alertTextField (below) to itemArray
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //add to defaults plist file so data can persist after app is e.g. force-quit
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //reload the Table View to display the new item
            self.tableView.reloadData()
        }
        //display the action with text field
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //extend the scope of alertTextField to the entire function so we can retrieve the contents of the alert text field
            textField = alertTextField
            
        }
        
        present(alert, animated: true, completion: nil)
        }
    

}

