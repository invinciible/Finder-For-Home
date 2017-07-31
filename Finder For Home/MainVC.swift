//
//  ViewController.swift
//  Finder For Home
//
//  Created by Tushar Katyal on 30/07/17.
//  Copyright © 2017 Tushar Katyal. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController ,UITableViewDelegate,UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var segmentedView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // generateTestData()
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
    
    
    func attemptFetch(){
        
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        // entity to request the data from 
        let dateSort = NSSortDescriptor(key: "createdOn", ascending: false)
        // which data to fetch first and how to sort it
        
        fetchRequest.sortDescriptors = [dateSort]
        
       let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller = controller
        
        do {
            
            try controller.performFetch()
        }
        catch let err as NSError{
            print(err)
        }
        
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
    func generateTestData(){
        
        let item = Item(context: context)
        item.name = "mobile"
        item.location = "bedroom"
        item.locationDetail = "on the refrigerator"
        
        let item2 = Item(context: context)
        item2.name = "mobile"
        item2.location = "bedroom"
        item2.locationDetail = "on the refrigerator"
        
        let item3 = Item(context: context)
        item3.name = "mobile"
        item3.location = "bedroom"
        item3.locationDetail = "on the refrigerator"
        
        let item4 = Item(context: context)
        item4.name = "mobile"
        item4.location = "bedroom"
        item4.locationDetail = "on the refrigerator"
        
        ad.saveContext()
    }
    
    
    
    
    
    
    
    
    
    
    
}

