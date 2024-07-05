//
//  ViewController.swift
//  FixCellInTableView
//
//  Created by 김동율 on 7/5/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var selectedIndexPath: IndexPath?
    var tableViewBottomConstraint: NSLayoutConstraint!
    let label = UILabel()
    let stickyView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 60
        self.view.addSubview(tableView)

        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableViewBottomConstraint,
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        //
        stickyView.translatesAutoresizingMaskIntoConstraints = false
        stickyView.backgroundColor = .blue
        view.addSubview(stickyView)
        NSLayoutConstraint.activate([
            stickyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            stickyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stickyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stickyView.heightAnchor.constraint(equalToConstant: tableView.rowHeight)
        ])
        
        //
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        stickyView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: stickyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: stickyView.centerYAnchor)
        ])

        stickyView.isHidden = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        cell.indexLabel.text = "Row \(indexPath.row)"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        label.text = "Row \(indexPath.row)"
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let selectedIndexPath = selectedIndexPath else { return }

        // rectForRow: 해당Cell의 Frame을 가져오는 함수.
        if let rectForCell = tableView.rectForRow(at: selectedIndexPath) as CGRect? {
            // convert: 변환하는 함수??. Cell의 좌표를 가져와 tableViewSuperView 좌표로 변환?Frame을 가져온다는거?
            let rectInTableView = tableView.convert(rectForCell, to: tableView.superview)
            let tableViewBottomOffset = tableView.contentOffset.y + tableView.frame.height
            
            if tableViewBottomOffset <= rectForCell.maxY {
                stickyView.isHidden = false
            } else {
                stickyView.isHidden = true
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        stickyView.isHidden = true
    }
    
}

