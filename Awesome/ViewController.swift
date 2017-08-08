//
//  ViewController.swift
//  Awesome
//
//  Created by Anuwat Sittichak on 8/8/2560 BE.
//  Copyright © 2560 Anuwat Sittichak. All rights reserved.
//

import RxSwift
import SDWebImage
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
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class ViewCell: UITableViewCell {
    
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var adsView: UIView!
    @IBOutlet weak var adsImageView: UIImageView!
    
    func apply(_ content: Content) {
        switch content.type {
        case "ads":
            adsView.isHidden = false
            trackView.isHidden = true
            videoView.isHidden = true
            adsImageView.sd_setImage(with: URL(string: "\(content.cover)"))
        case "track":
            adsView.isHidden = true
            trackView.isHidden = false
            videoView.isHidden = true
            trackTitle.text = content.name
            trackImageView.sd_setImage(with: URL(string: "\(content.cover)"))
        case "video":
            adsView.isHidden = true
            trackView.isHidden = true
            videoView.isHidden = false
            videoImageView.sd_setImage(with: URL(string: "\(content.cover)"))
        default: break
        }
    }
    
}
