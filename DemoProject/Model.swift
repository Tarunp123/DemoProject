//
//  Model.swift
//  DemoProject
//
//  Created by Tarun Prajapati on 22/02/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation

protocol ModelDelegate: class {
    func modelDidFinishDownlaodingData(model: Model)
    func model(model: Model, DidEncounterError errorMsg: String)
}



class Model{

    private let jsonFileName = "Sample"
    
    private var posts = [Post]()
    
    var totalNumberOfPosts : Int{
        get{
            return self.posts.count
        }
    }
    
    var delegate: ModelDelegate?

    
    
    func getPosts(){
        //Load JSON File
        if let jsonFileURL = NSBundle.mainBundle().pathForResource(self.jsonFileName, ofType: "json"){
            do{
                //Get file data
                let jsonData = try NSData(contentsOfFile: jsonFileURL, options: .DataReadingMappedIfSafe)
                
                //convert to json
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as! [String: AnyObject]
                
                //Extract all the data and convert into Posts
                if let postsArray = jsonObject["posts"] as? Array<[String: AnyObject]>, let imgURL = jsonObject["image"] as? String{
                    
                    for postIndex in 0..<postsArray.count{
                        let aPost = Post(id: postsArray[postIndex]["id"] as! Int, title: postsArray[postIndex]["title"] as! String, imageURL: imgURL)
                        self.posts.append(aPost)
                    }
                    
                    //Inform Delegate that json is successfully parsed and return
                    self.delegate?.modelDidFinishDownlaodingData(self)
                    
                    return
                }
                
            }catch{
                //Exception
                self.delegate?.model(self, DidEncounterError: "Could not open or parse the specified file!")
                return
            }
            
        }else{
            //File not found
            self.delegate?.model(self, DidEncounterError: "Could not find the specified file!")
            return
        }
        
        //Some other error occurred.
        self.delegate?.model(self, DidEncounterError: "Error!")
    }
    
        
    
    
    func getPostAtIndex(index: Int) -> Post? {
        return self.posts[index] ?? nil
    }
    

}
