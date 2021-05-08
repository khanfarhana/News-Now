//
//  ViewController2.swift
//  Api_Task
//
//  Created by Farhana Khan on 11/04/21.
//

import UIKit
import AVFoundation


class DetailNewsVC: UIViewController {
    
    @IBOutlet weak var HeadingLb: UILabel!
    @IBOutlet weak var TimeLb: UILabel!
    @IBOutlet weak var newsDetail: UILabel!
    let synth = AVSpeechSynthesizer()
    var theUtterance = AVSpeechUtterance(string: "")
    var headingVar = ""
    var timeVar = ""
    var newVar = ""
    let pauseBBtn = UIBarButtonItem()
    let pauseBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = ""
        let backBtn = UIBarButtonItem()
        let backImg = UIButton()
        backImg.setImage(UIImage(named: "back.png"), for: .normal)
        backImg.addTarget(self, action: #selector(backPress), for: .touchUpInside)
        backBtn.customView = backImg
        self.navigationItem.leftBarButtonItem = backBtn
        
        let shareBBtn = UIBarButtonItem()
        let shareBtn = UIButton()
        shareBtn.setImage(UIImage(named: "share.png"), for: .normal)
        shareBtn.addTarget(self, action: #selector(sharePress), for: .touchUpInside)
        shareBBtn.customView = shareBtn
        
        
        pauseBtn.setImage(UIImage(named: "pause.png"), for: .normal)
        pauseBtn.addTarget(self, action: #selector(pausePress), for: .touchUpInside)
        pauseBBtn.customView = pauseBtn
        
        let speakerBBtn = UIBarButtonItem()
        let speakerBtn = UIButton()
        speakerBtn.setImage(UIImage(named: "speaker"), for: .normal)
        speakerBtn.addTarget(self, action: #selector(speakerPress), for: .touchUpInside)
        speakerBBtn.customView = speakerBtn
        
        self.navigationItem.rightBarButtonItems = [shareBBtn,pauseBBtn,speakerBBtn]
        HeadingLb.text = headingVar
        TimeLb.text = timeVar
        //newsDetail.text = newVar
        let data = Data(newVar.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            newsDetail.attributedText = attributedString
            TimeLb.textColor = UIColor.gray
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        self.navigationItem.title = "Read News"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if (synth.isSpeaking) {
            synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    @objc func backPress(){
        print("Back Press")
        self.navigationController?.popViewController(animated: true)
    }
    @objc func pausePress(){
        if (synth.isPaused) {
            pauseBtn.setImage(UIImage(named: "pause.png"), for: .normal)
            synth.continueSpeaking()
        }
        else if (synth.isSpeaking) {
            pauseBtn.setImage(UIImage(named: "play.png"), for: .normal)
            synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
        }
    }
    @objc func speakerPress(){
        
        // Getting text to read from the UITextView (textView).
        theUtterance = AVSpeechUtterance(string: "\(newVar)")
        theUtterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        theUtterance.rate = 0.5
        synth.speak(theUtterance)
        
    }
    @objc func sharePress(){
        //code for share action
        let urlString = URL(string: "https://apps.apple.com/us/app/id1535629801")!
        
        let linkToShare = [urlString]
        
        func delay(_ delay:Double, closure:@escaping ()->()) {
            let when = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
        }
        let activityController = UIActivityViewController(activityItems: linkToShare, applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    
}

