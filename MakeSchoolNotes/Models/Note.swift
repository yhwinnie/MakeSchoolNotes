//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Winnie Wen on 6/21/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
}