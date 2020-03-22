//
//  Record.swift
//  Ditto
//
//  Created by Dusan Tichy on 21/03/2020.
//  Copyright © 2020 dti. All rights reserved.
//

import Cocoa

class Record: NSObject {
       var firstName:String = ""
       var lastName:String = ""
       
       class func createPerson(fName:String, lName:String)->Record{
           let person = Record()
           person.firstName = fName
           person.lastName = lName
           return person
           
       }
}
