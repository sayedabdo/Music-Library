//
//  playvideo.swift
//  Music Library
//
//  Created by Sayed Abdo on 4/28/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit

class playvideo: UIViewController {
    var videourl : String!
    var videoname = ""
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var titleLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       //webView.loadHTMLString(partyRock.videoURL, baseURL: nil)
        // Do any additional setup after loading the view.
        titleLbl.text = videoname
        webView.loadHTMLString(videourl, baseURL: nil)
       // let myURL : NSURL = NSURL(string: videourl)!
      //  let myURLRequest : NSURLRequest = NSURLRequest(URL: myURL)
        //self.webView.loadRequest(myURLRequest)
       //  webView.loadHTMLString(myURL, baseURL: nil)
     //   webView.
    }

}
