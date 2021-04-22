//
//  ToDoDetailTableViewController.swift
//  ToDo List
//
//  Created by Anika Nair on 4/8/21.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

@IBOutlet var titleTextField: UITextField!
@IBOutlet var isCompleteButton: UIButton!
@IBOutlet var dueDateLabel: UILabel!
@IBOutlet var dueDatePickerView: UIDatePicker!
@IBOutlet var notesTextView: UITextView!
    
@IBOutlet var saveButton: UIBarButtonItem!
 
 
func updateSaveButtonState() {
let text = titleTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
    }

func updateDueDateLabel(date: Date) {
dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
 }
            
override func viewDidLoad() {
super.viewDidLoad()
    
if let todo = todo {
    
navigationItem.title = "To-Do"
titleTextField.text = todo.title
isCompleteButton.isSelected = todo.isComplete
dueDatePickerView.date = todo.dueDate
notesTextView.text = todo.notes
}
 else {
     dueDatePickerView.date =
    Date().addingTimeInterval(24*60*60)
  }

updateDueDateLabel(date: dueDatePickerView.date)
    
updateSaveButtonState()
  
}
    
@IBAction func textEditingChanged(_ sender: UITextField) {
    updateSaveButtonState()
}

@IBAction func returnPressed(_ sender: UITextField) {
  titleTextField.resignFirstResponder()
}
 
@IBAction func isCompleteButtonTapped(_ sender: UIButton) {
 isCompleteButton.isSelected = !isCompleteButton.isSelected
 }
    
@IBAction func datePickerChanged(_ sender: UIDatePicker) {
 updateDueDateLabel(date: dueDatePickerView.date)

}

var isPickerHidden = true
let dateLabelIndexPath = IndexPath(row: 0, section: 1)
let datePickerIndexPath = IndexPath(row: 1, section: 1)
let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    
let normalCellHeight: CGFloat = 100
let largeCellHeight: CGFloat = 200

   
override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
    
    switch indexPath {

case datePickerIndexPath:
return isPickerHidden ? 0 :
    dueDatePickerView.frame.height
        
case notesTextViewIndexPath:
return largeCellHeight
    
default:
return normalCellHeight
    
    }

}
override func tableView(_ tableView: UITableView, didSelectRowAt
indexPath: IndexPath) {
if indexPath == dateLabelIndexPath {
    isPickerHidden = !isPickerHidden
    dueDateLabel.textColor = isPickerHidden ? .black :
    tableView.tintColor
    tableView.beginUpdates()
    tableView.endUpdates()
    }
}
var todo: ToDo?

override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
super.prepare(for: segue, sender: sender)
        
guard segue.identifier == "saveUnwind" else { return }
    let title = titleTextField.text!
    let isComplete = isCompleteButton.isSelected
    let dueDate = dueDatePickerView.date
    let notes = notesTextView.text

todo = ToDo(title: title,
    isComplete: isComplete, dueDate:dueDate, notes: notes)
    
    
    }
}




    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem


    // MARK: - Table view data source




    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



