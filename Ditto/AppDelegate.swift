//
//  AppDelegate.swift
//  Ditto
//
//  Created by Dusan Tichy on 14/03/2020.
//  Copyright © 2020 dti. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

      var timer: Timer!
      let pasteboard: NSPasteboard = .general
      var lastChangeCount: Int = 0

    func applicationDidFinishLaunching(_ aNotification: Notification) {
       timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (t) in
                   if self.lastChangeCount != self.pasteboard.changeCount {
                       self.lastChangeCount = self.pasteboard.changeCount
                       NotificationCenter.default.post(name: .NSPasteboardDidChange, object: self.pasteboard)
                   }
               }
    }
   
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
          timer.invalidate()
    }


}
extension NSNotification.Name {
       public static let NSPasteboardDidChange: NSNotification.Name = .init(rawValue: "pasteboardDidChangeNotification")
   }
