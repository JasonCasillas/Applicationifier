//
//  TeamSelectionTableViewController.swift
//  Applicationifier
//
//  Created by Jason Casillas on 4/17/16.
//  Copyright © 2016 TWNH. All rights reserved.
//

import UIKit

class TeamSelectionTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func selectedTeamsArray() -> [String] {
        var selectedTeamsArray:[String]! = []
        if let selectedRowIndexPaths = tableView.indexPathsForSelectedRows {
            for indexPath:NSIndexPath in selectedRowIndexPaths {
                let selectedTeamIdentifier:String! = tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier
                selectedTeamsArray.append(selectedTeamIdentifier)
            }
        }

        return selectedTeamsArray
    }
}
