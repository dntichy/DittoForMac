//
//  MyData.swift
//  Ditto
//
//  Created by Dusan Tichy on 22/03/2020.
//  Copyright © 2020 dti. All rights reserved.
//

import Cocoa

class ClipboardRecord: NSObject {
    internal init(desc: String, pasteBoardItemHash: Int) {
        
        self.id = ClipboardRecord.count
        ClipboardRecord.count += 1
        
        self.desc = desc
        
        self.type = ""
        self.data = Data.init()
        self.pasteBoardItemHash = pasteBoardItemHash
        self.date = NSDate()
    }
    
    @objc var desc: String
    @objc var id: Int
    @objc var data: Data
    @objc var type: String
    @objc var date: NSDate
    @objc var pasteBoardItemHash: Int
    @objc static var count : Int = 0;
}
