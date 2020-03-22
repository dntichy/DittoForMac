//
//  MyData.swift
//  Ditto
//
//  Created by Dusan Tichy on 22/03/2020.
//  Copyright © 2020 dti. All rights reserved.
//

import Cocoa

class ClipboardRecord: NSObject {
    internal init(id: Int, desc: String) {
   
        self.id = id;
        self.desc = desc
        
        self.type = ""
        self.data = Data.init()
    }
        
        @objc var desc: String
        @objc var id: Int
        
        @objc var data: Data
        @objc var type: String
}
