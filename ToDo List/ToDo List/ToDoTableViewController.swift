//
//  ToDoTableViewController.swift
//  ToDo List
//
//  Created by Anika Nair on 4/7/21.
//

import UIKit

class ToDoTableViewController: UITableViewController,ToDoCellDelegate {
    
func checkmarkTapped(sender: ToDoCell) {
        
if let indexPath = tableView.indexPath(for: sender) {
var todo = todos[indexPath.row]
 todo.isComplete = !todo.isComplete
todos[indexPath.row] = todo
tableView.reloadRows(at: [indexPath], with: .automatic)
    
 ToDo.saveToDos(todos)
        }
    }
    
var todos = [ToDo]()
    
override func viewDidLoad() {
    
navigationItem.leftBarButtonItem = editButtonItem
    
    super.viewDidLoad()
    
if let savedToDos = ToDo.loadToDos() {
    
        todos = savedToDos
                }

           else  {
                todos = ToDo.loadSampleToDos()
            }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

     guard let cell = tableView.dequeueReusableCell(withIdentifier:
        "ToDoCellIdentifier") as? ToDoCell
     
     else {

        fatalError("Could not dequeue a cell")
        
     }
    cell.delegate = self
        
    let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.isCompleteButton.isSelected = todo.isComplete
        
    return cell
   
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath)
       -> Bool {
     return true
      
    }
    
   // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
           if editingStyle == .delete {
                todos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                ToDo.saveToDos(todos)
            }
    }
    
    

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

    
@IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
    
guard segue.identifier == "saveUnwind" else { return }
let sourceViewController = segue.source as!
    ToDoDetailTableViewController

if let todo = sourceViewController.todo {
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      todos[selectedIndexPath.row] = todo
        
tableView.reloadRows(at: [selectedIndexPath],
                with: .none)
        
    }
    else {
            let newIndexPath = IndexPath(row: todos.count,
                section: 0)
        
todos.append(todo)
 tableView.insertRows(at: [newIndexPath],
                with: .automatic)
      }
}
  ToDo.saveToDos(todos)
}

    override func prepare (for segue: UIStoryboardSegue, sender:
Any?) {
    if segue.identifier == "EditToDo",
   let navController = segue.destination as? UINavigationController,
  let todoDetailTableViewController = navController.topViewController as?
     ToDoDetailTableViewController {
  let indexPath = tableView.indexPathForSelectedRow!
    let selectedToDo = todos[indexPath.row]
       todoDetailTableViewController.todo = selectedToDo
        
           }
   }
    

}


