//
//  Message.swift
//  ParseChat
//
//  Created by Tianyu Liang on 3/4/18.
//  Copyright © 2018 Tianyu Liang. All rights reserved.
//

import Foundation
import Parse

class Message: PFObject, PFSubclassing {
  @NSManaged var user: PFUser
  @NSManaged var text: String
    
    /* Needed to implement PFSubclassing interface */
    class func parseClassName() -> String {
        return "Message"
    }
    


}

