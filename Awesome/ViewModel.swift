//
//  ViewModel.swift
//  Awesome
//
//  Created by Anuwat Sittichak on 8/8/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift
import SwiftyJSON

class ViewModel {

    let rx_contents: BehaviorSubject<[Content]> = BehaviorSubject(value: [])
    
    func fetchContents() {
        Alamofire.request("http://www.anop72.info/api/seed.json")
            .responseData { resp in
                let json = JSON(resp.result.value!)
                let contents = json.map { (_, js) in Content.parseJSON(js) }
                self.rx_contents.onNext(contents)
            }
    }
    
}
