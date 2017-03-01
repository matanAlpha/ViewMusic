//
//  ViewController.swift
//  ViewMusic
//
//  Created by admin on 1 Adar 5777.
//  Copyright © 5777 Matan alpha. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import MediaPlayer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNowPlayingTitles()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var nowPlayingArtist: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: UIButton) {
        MPMusicPlayerController.systemMusicPlayer().play()
    }

    @IBAction func pause(_ sender: UIButton) {
        MPMusicPlayerController.systemMusicPlayer().pause()
    }
    
    
    @IBAction func next(_ sender: UIButton) {
        MPMusicPlayerController.systemMusicPlayer().skipToNextItem()
        updateNowPlayingTitles()
    }
    
    @IBAction func prev(_ sender: UIButton) {
        MPMusicPlayerController.systemMusicPlayer().skipToPreviousItem()
        updateNowPlayingTitles()
    }
    
    func updateNowPlayingTitles()
    {
        nowPlayingTitle.text = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem?.title
        
        nowPlayingArtist.text = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem?.artist
        
    }
    
    @IBAction func viewMusic(_ sender: UIButton) {
        updateNowPlayingTitles()
//        print(AVAudioSession.sharedInstance().isOtherAudioPlaying)
//        print(AVAudioSession.sharedInstance().inputDataSource)
//        print(MPNowPlayingInfoCenter.default().nowPlayingInfo)
        print(MPMusicPlayerController.systemMusicPlayer())
    }
}

