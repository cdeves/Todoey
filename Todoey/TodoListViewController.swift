//
//  ViewController.swift
//  Todoey
//
//  Created by Caitlin Sedwick on 7/9/18.
//  Copyright © 2018 Caitlin Sedwick. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["find Mike", "buy Eggos", "destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
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
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
// MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //diagnostic
        //print(itemArray[indexPath.row])
        
        //add a checkmark when a cell is selected, or remove checkmark if cell was already selected
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
            self.itemArray.append(textField.text ?? "New Item")
            
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

