//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Winnie Wen on 6/22/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    static func addNote (note: Note) {
        let realm = try! Realm()
//        do {
//            let realm = try Realm()
//            
//        }
//        catch (error as NSError) {
//            print()
//        }
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func deleteNote (note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote (noteToBeUpdated: Note, newNote: Note) {
        // Can't use add because we want to update and not add
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdated.title = newNote.title
            noteToBeUpdated.content = newNote.content
            noteToBeUpdated.modificationTime = newNote.modificationTime
        }
    }
    
    static func retrieveNote () -> Results<Note>  {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
        
    }
}


