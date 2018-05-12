//
//  cat_con_detVC.swift
//  Music Library
//
//  Created by Sayed Abdo on 4/28/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import Alamofire

class cat_con_detVC: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    var titlename = ""
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titlelabel: UILabel!
    var arrayofnames : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofimages : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    var arrayofurl : [String] = []{
        didSet{
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        titlelabel.text = titlename
        // Do any additional setup after loading the view.
        let user_get_url = "http://team-space.000webhostapp.com/index.php/api/cat/con"
        Alamofire.request(user_get_url).responseJSON { response in
            let result = response.result
            print("the result is : \(result.value)")
            if let arrayOfDic = result.value as? [Dictionary<String, AnyObject>] {
                for aDic in arrayOfDic{
                    print(aDic["name"])
                    self.arrayofnames.append(aDic["name"] as! String)
                    self.arrayofimages.append(aDic["image_url"] as! String)
                    self.arrayofurl.append(aDic["url"] as! String)
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayofnames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "English movie cell") as? cat_con_detcell else { return UITableViewCell()
        }
        
        
        let catPictureURL = URL(string: arrayofimages[indexPath.row])!
        // Creating a session object with the default configuration.
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            print(">>>>>>")
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        print("qqqqqqqqq")
                        cell.cat_image.image = image
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
        cell.cat_name.text = arrayofnames[indexPath.row] as! String
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "playvideo") as! playvideo
        nextViewController.videoname =  arrayofnames[indexPath.row] as! String
        nextViewController.videourl =  arrayofurl[indexPath.row] as! String
        
        self.present(nextViewController, animated:true, completion:nil)
    }
    
}
