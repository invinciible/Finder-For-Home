//
//  ViewController.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 30/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController ,UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate , UISearchBarDelegate {

    @IBOutlet weak var segmentedView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        attemptFetch()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    
    func configureCell(cell: ItemCell, indexPath : NSIndexPath){
      let item = controller.object(at: indexPath as IndexPath)
        
        cell.configureCell(item: item)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126 // setting the height for each cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objc = controller.fetchedObjects, objc.count > 0 {
            
            let item = objc[indexPath.row]
            
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
            
        }
    }
    
    // to pass the data from the selected table cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            
            if let destination = segue.destination as? ItemAddVC {
               
                if let item = sender as? Item {
                    
                    destination.ItemToEdit = item
                }
            }
        }
    }
    func attemptFetch(){
        
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        // entity to request the data from 
        let dateSort = NSSortDescriptor(key: "createdOn", ascending: false)
        let NameSort = NSSortDescriptor(key: "name", ascending: true)
        // which data to fetch first and how to sort it
        
        if segmentedView.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [dateSort]
        }
        else {
            if segmentedView.selectedSegmentIndex == 1 {
                fetchRequest.sortDescriptors = [NameSort]
            }
        }
        
       let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try controller.performFetch()
        }
        catch let err as NSError{
            print(err)
        }
        
    }
    
    @IBAction func SegmentChangePressed(_ sender: Any) {
        attemptFetch()
        tableView.reloadData()
    }
    
    
    // notifies reciever that the controller is about to start fectching updates
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    // notifies reciever tha the controller has finished the one or more changes
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
        switch(type) {
        case.insert:
            if let indexpath = newIndexPath {
                tableView.insertRows(at: [indexpath], with: .fade)
            }
           break
        case.delete :
            if let indexpath = indexPath {
                tableView.deleteRows(at: [indexpath], with: .fade)
            }
            break
        case.update :
            if let indexpath = indexPath {
                let cell = tableView.cellForRow(at: indexpath) as! ItemCell
                configureCell(cell: cell, indexPath: indexpath as NSIndexPath)
            }
            break
        case.move:
            if let indexpath = indexPath {
                tableView.deleteRows(at: [indexpath], with: .fade)
            }
            if let indexpath = newIndexPath {
                tableView.insertRows(at: [indexpath], with: .fade)
            }
            break
        }
        
    }
 
    
    
    
    
    
    
    
    
    
    
    
}

