//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }
    

  override func viewDidLoad() {
    super.viewDidLoad()
    notes = RealmHelper.retrieveNote()

  }
    

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        let row = indexPath.row
        
        let note = notes[row]
        
        cell.noteTitleLabel.text = note.title
        
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        cell.notesLabel.text = note.content
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retrieveNote()
            //tableView.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                
                let indexPath = tableView.indexPathForSelectedRow!
                let note = notes[indexPath.row]
                
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                
                displayNoteViewController.note = note
                
            }
            else if identifier == "addNote" {
            }
        }
    }
    
    
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
}