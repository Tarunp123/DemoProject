//
//  ViewController.swift
//  DemoProject
//
//  Created by Tarun Prajapati on 21/02/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ModelDelegate {

    @IBOutlet weak var tableView: UITableView?
    private var model: Model!
    private let rowHeightInPotraitMode : CGFloat = 150
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startingPoint()
        
    }


    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.tableView?.reloadData()
    }
    

    private func startingPoint(){
        
        //Setup Tableview
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = self.rowHeightInPotraitMode
        
        //Setup Model
        if self.model == nil{
            self.model = Model()
            self.model.delegate = self
        }
        self.model.getPosts()
  
    }
    
    
    
    //MARK:- TableView DataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.totalNumberOfPosts
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? CustomTVC) ?? CustomTVC()
        
        cell.imgView?.image = UIImage(named: "placeholderImg")
        
        if let post = self.model.getPostAtIndex(indexPath.row){
            //If post found -> Configure Cell
            cell.imgView?.loadImageFromURL(post.imageURL ?? "", forRowAtIndex: indexPath.row)
            cell.label?.text = post.title
            if self.traitCollection.verticalSizeClass == .Regular{
                //Potrait Mode
                cell.label?.numberOfLines = 2
            }else if self.traitCollection.verticalSizeClass == .Compact{
                //Landscape Mode
                cell.label?.numberOfLines = 1
            }
        }else{
            
            cell.label?.text = ""
        }
        return cell
    }
    
    
    //MARK:- Model Delegate Methods
    func modelDidFinishDownlaodingData(model: Model) {
        self.tableView?.reloadData()
    }
    
    func model(model: Model, DidEncounterError errorMsg: String) {
        print(errorMsg)
    }
    
}

