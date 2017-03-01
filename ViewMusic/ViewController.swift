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

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateNowPlayingTitles()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //let query = MPMediaQuery.albums()
    
    @IBOutlet weak var nowPlayingTitle: UILabel!
    @IBOutlet weak var nowPlayingArtist: UILabel!
    
    @IBOutlet weak var queryForSongs: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var playedImage: UIImageView!
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
        var cSize = CGSize(width: 120, height: 120)
        
        playedImage.image = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem?.artwork?.image(at: cSize)
        
        
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
    
    @IBAction func setQ(_ sender: UIButton) {
        let query = MPMediaQuery.songs()
        // always need to filter out songs that aren't present
        var isPresent = MPMediaPropertyPredicate(value:queryForSongs.text,
                                                 forProperty:MPMediaItemPropertyTitle,
                                                 comparisonType:.contains)
        query.addFilterPredicate(isPresent)
        MPMusicPlayerController.systemMusicPlayer().setQueue(with: query)
    }
    
    
    @IBAction func viewMusic(_ sender: UIButton) {
        updateNowPlayingTitles()
//        print(AVAudioSession.sharedInstance().isOtherAudioPlaying)
//        print(AVAudioSession.sharedInstance().inputDataSource)
//        print(MPNowPlayingInfoCenter.default().nowPlayingInfo)
        
        MPMusicPlayerController.systemMusicPlayer().beginGeneratingPlaybackNotifications()
        
        
        let query = MPMediaQuery.songs()
        // always need to filter out songs that aren't present
        var isPresent = MPMediaPropertyPredicate(value:queryForSongs.text,
                                                 forProperty:MPMediaItemPropertyTitle,
                                                 comparisonType:.contains)
        query.addFilterPredicate(isPresent)
        guard let items = query.items else {return} //
        print(items)
        print(MPMusicPlayerController.systemMusicPlayer())
        
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(now_playing_item_changed),
            name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: nil)
    }
    
    func now_playing_item_changed(_ notification: Notification){
        updateNowPlayingTitles()
    }
}

