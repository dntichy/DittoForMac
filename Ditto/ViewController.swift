//
//  ViewController.swift
//  Ditto
//
//  Created by Dusan Tichy on 14/03/2020.
//  Copyright © 2020 dti. All rights reserved.
//

import Cocoa
import AppKit


class ViewController: NSViewController {
    
    
    @IBOutlet weak var tableView: NSTableView!
    
    @objc dynamic var myDataList = [ClipboardRecord]()
    @objc dynamic var sorts = [NSSortDescriptor]()
    @objc dynamic var filter: NSPredicate?
    
    @IBOutlet var arrayController: NSArrayController!
    
    
    override func viewDidLoad() {
//        myDataList.append(ClipboardRecord.init( desc : "xx", pasteBoardItemHash: ))
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPasteboardChanged), name: .NSPasteboardDidChange, object: nil)
        
        //        let smithPredicate = NSPredicate(format: "name = %@", "Chello3")
        //        filter = smithPredicate
        self.tableView.delegate = self;
        
    }
    
    var copyInvokedFromRowClicking = false
    
    @objc
    func onPasteboardChanged(_ notification: Notification) {
        
        if copyInvokedFromRowClicking == true {
            copyInvokedFromRowClicking = false
            return
        }
      
        guard let pb = notification.object as? NSPasteboard else { return }
        guard let items = pb.pasteboardItems else { return }
        
        if items.count > 1 {
            return
        }
        
        let storedDesc = items.first?.string(forType: .string)
        for el in myDataList {
            if el.desc == storedDesc! {
                return
            }
        }
        let storedHash = items.first?.hashValue
             for el in myDataList {
                 if el.pasteBoardItemHash == storedHash! {
                     return
                 }
             }
        
        let pasteBoardHashForItem = items.first?.hashValue
        
        let string = items.first?.string(forType: .string)
        let file = items.first?.data(forType: .fileContents)
        let picure = items.first?.data(forType: .tiff)
        
        if(string != nil){
            var clData = ClipboardRecord.init(desc: string!, pasteBoardItemHash: pasteBoardHashForItem!)
            clData.data = Data(string!.utf8)
            clData.type = ".string"
            
            myDataList.append(clData)
        }
        if(picure != nil){
            myDataList.append(ClipboardRecord.init( desc: picure!.description, pasteBoardItemHash: pasteBoardHashForItem!))
        }
        if(file  !=  nil){
            //best will be to go to location and copy
            myDataList.append(ClipboardRecord.init(desc: file!.description,pasteBoardItemHash: pasteBoardHashForItem!))
        }
    }
}


extension ViewController : NSTableViewDataSource{
    
    
}

extension ViewController: NSTableViewDelegate {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let selectedRow = tableView.selectedRow
        if selectedRow == -1 {return}
        
        print(arrayController.selectionIndex)
        
        let mySelectedData = arrayController.selectedObjects[0] as! ClipboardRecord
       
        let textToBeInserted = mySelectedData.desc
        
        copyStringToPasteboard(stringToCopy:  textToBeInserted)
    }
    
    
    
    func copyStringToPasteboard(stringToCopy:String){
        print("copying \(stringToCopy) to paste")
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        copyInvokedFromRowClicking = true;
        pasteboard.setString(stringToCopy, forType: NSPasteboard.PasteboardType.string)
    }
    
    //func copyFileToPasteboard(filename:String){
    //    print("copying \(filename) to paste")
    //    var pasteboard = NSPasteboard.general
    //    pasteboard.clearContents()
    //    pasteboard.writeFileContents(filename);
    //
    //    var gifData = NSData(contentsOfFile: filename);
    //    pasteboard.setData(gifData, forType: "com.compuserve.gif");
    //    pasteboard.setData(gifData, forType: String(kUTTypeGIF)); // crap! only copies the first frame. Worthless for us, the gif people
    //}
    
}


//extension ViewController: NSTableViewClickableDelegate{
//    func tableView(_ tableView: NSTableView, didClickRow row: Int, didClickColumn: Int) {
//
//    }
//}


////Just hokus pokus :)
//protocol NSTableViewClickableDelegate: NSTableViewDelegate {
//    func tableView(_ tableView: NSTableView, didClickRow row: Int, didClickColumn: Int)
//}
//
//extension NSTableView {
//
//
//    open override func mouseDown(with event: NSEvent) {
//        let localLocation = self.convert(event.locationInWindow, to: nil)
//        let clickedRow = self.row(at: localLocation)
//        let clickedColumn = self.column(at: localLocation)
//
//        super.mouseDown(with: event)
//
//        guard clickedRow >= 0, clickedColumn >= 0, let delegate = self.delegate as? NSTableViewClickableDelegate else {
//            return
//        }
//
//        delegate.tableView(self, didClickRow: clickedRow, didClickColumn: clickedColumn)
//    }
//}
