//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitleTextField.delegate = self
        noteContentTextView.delegate = self
        noteContentTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        noteContentTextView.layer.borderWidth = 1.0
        noteContentTextView.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let note = note {
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        }
        else {
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "Cancel" {
            }
                
                
            else if identifier == "Save" {
                let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
      
                if let note = note {
                    
                    let newNote = Note()
                
                    newNote.title = noteTitleTextField.text ?? ""
                    newNote.content = noteContentTextView.text ?? ""
                    RealmHelper.updateNote(note, newNote: newNote)
                    
                } else {
                    let note = Note()
                    note.title = noteTitleTextField.text ?? ""
                    note.content = noteContentTextView.text ?? ""
                    note.modificationTime = NSDate()
                    
                    RealmHelper.addNote(note)
                    
                }
                listNotesTableViewController.notes = RealmHelper.retrieveNote()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
