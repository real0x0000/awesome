//
//  Content.swift
//  Awesome
//
//  Created by Anuwat Sittichak on 8/8/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Content {
    let id: Int
    let name: String
    let type: String
    let cover: String
}

extension Content {
    
    static func parseJSON(_ js: JSON) -> Content {
        let id = js["id"].intValue
        let name = js["name"].stringValue
        let type = js["type"].stringValue
        let cover = js["cover"].stringValue
        return Content(id: id, name: name, type: type, cover: cover)
    }
    
}
