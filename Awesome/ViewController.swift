//
//  ViewController.swift
//  Awesome
//
//  Created by Anuwat Sittichak on 8/8/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import RxSwift
import UIKit

class ViewController: UIViewController {

    let vm = ViewModel()
    let disposeBag = DisposeBag()
    var contents: [Content] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        vm.rx_contents
            .subscribe(onNext: { [unowned self] in
                self.contents = $0
                self.tableView.reloadData()
            }).addDisposableTo(disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        vm.fetchContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as! ViewCell
        let content = contents[indexPath.row]
        cell.apply(content)
        return cell
    }
    
}

class ViewCell: UITableViewCell {
    
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var adsView: UIView!
    
    func apply(_ content: Content) {
        
    }
    
}
