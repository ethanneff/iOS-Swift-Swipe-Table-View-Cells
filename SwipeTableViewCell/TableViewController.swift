//
//  TableViewController.swift
//  swipecell
//
//  Created by Ethan Neff on 1/29/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  // MARK: properties
  var original = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen"]
  var items: Array<String> = []
  var itemsCount: Int = 0
  
  // MARK: load
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.contentInset = UIEdgeInsetsZero
    tableView.separatorInset = UIEdgeInsetsZero
    tableView.layoutMargins = UIEdgeInsetsZero
    
    reload()
  }
  
  // MARK: buttons
  @IBAction func reload(sender: AnyObject) {
    reload()
  }
  @IBAction func add(sender: AnyObject) {
    add()
  }
  
  // MARK: table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemsCount
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    // create
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? MCSwipeTableViewCell
    if cell == nil {
      cell = MCSwipeTableViewCell(style: .Subtitle, reuseIdentifier: "cell")
    }
    
    // setup
    cell!.separatorInset = UIEdgeInsetsZero
    cell!.layoutMargins = UIEdgeInsetsZero
    cell!.selectionStyle = .None
    cell!.textLabel?.text = items[indexPath.row]
    cell!.detailTextLabel?.text = "details..."
    cell?.detailTextLabel?.textColor = .lightGrayColor()
    cell!.defaultColor = .lightGrayColor()
    cell!.firstTrigger = 0.25;
    cell!.secondTrigger = 0.50;
    
    // listeners
    cell!.setSwipeGestureWithView(UIImageView(image: UIImage(named: "check")!), color: .greenColor(), mode: .Exit, state: .State1, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
      print("check")
      self.deleteCell(cell: cell)
    })
    
    cell!.setSwipeGestureWithView(UIImageView(image: UIImage(named: "cross")!), color: .redColor(), mode: .Exit, state: .State2, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
      print("cross")
      self.deleteCell(cell: cell)
    })
    
    cell!.setSwipeGestureWithView(UIImageView(image: UIImage(named: "clock")!), color: .purpleColor(), mode: .Exit, state: .State3, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
      print("clock")
      self.deleteCell(cell: cell)
    })
    
    cell!.setSwipeGestureWithView(UIImageView(image: UIImage(named: "list")!), color: .brownColor(), mode: .Exit, state: .State4, completionBlock: { (cell: MCSwipeTableViewCell!, state: MCSwipeTableViewCellState!, mode: MCSwipeTableViewCellMode!) -> Void in
      print("list")
      self.deleteCell(cell: cell)
    })
    
    return cell!
  }
  
  // MARK: helper methods
  func add() {
    tableView.beginUpdates()
    itemsCount++;
    items.insert(String(Int64(NSDate().timeIntervalSince1970 * 1000)), atIndex: 0)
    tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
    tableView.endUpdates()
  }
  
  func reload() {
    tableView.beginUpdates()
    items = original
    itemsCount = original.count
    tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
    tableView.endUpdates()
  }
  
  func deleteCell(cell cell: MCSwipeTableViewCell) {
    tableView.beginUpdates()
    itemsCount--;
    items.removeAtIndex(items.indexOf((cell.textLabel?.text)!)!)
    tableView.indexPathForCell(cell)
    tableView.deleteRowsAtIndexPaths([self.tableView.indexPathForCell(cell)!], withRowAnimation: .Fade)
    tableView.endUpdates()
  }
}
