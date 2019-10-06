//
//  VideoChatController.swift
//  ScrapChat_iOS
//
//  Created by Jaiden Chicote on 21/9/19.
//  Copyright © 2019 Dream Team. All rights reserved.
//

import UIKit
import AgoraRtcEngineKit

class VideoChatController: UIViewController {
    
    @IBOutlet weak var localVideo: UIView!
    @IBOutlet weak var remoteVideo: UIView!
    @IBOutlet weak var remoteVideoMutedIndicator: UIImageView!
    @IBOutlet weak var localVideoMutedIndicator: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var localVideoMutedBg: UIView!
    
    //Constraint var
    var remoteTrail: NSLayoutConstraint?
    var remoteTop: NSLayoutConstraint?
    var remoteWidth: NSLayoutConstraint?
    var remoteHeight: NSLayoutConstraint?
    
    var localTrail: NSLayoutConstraint?
    var localTop: NSLayoutConstraint?
    var localWidth: NSLayoutConstraint?
    var localHeight: NSLayoutConstraint?
    
    //Constraint outlets
    @IBOutlet weak var collageTop: NSLayoutConstraint!
    @IBOutlet weak var clearCenterY: NSLayoutConstraint!
    @IBOutlet weak var saveCenterY: NSLayoutConstraint!
    @IBOutlet weak var toolBottom: NSLayoutConstraint!
    @IBOutlet weak var savePopY: NSLayoutConstraint!
    @IBOutlet weak var friendRequestY: NSLayoutConstraint!
    
    //ScrapBook View
    @IBOutlet weak var collageView: UIView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var toolButton: UIButton!
    @IBOutlet weak var savePopup: UIView!
    @IBOutlet weak var darkMask: UIView!
    var collageActive = false
    
    //Tool button labels
    @IBOutlet weak var toolLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var clearLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    
    var agoraKit: AgoraRtcEngineKit!
    var callRecipient: Person?
    var madeScrap = false
    var friends = FriendManager()
    var containerCollage: CollageViewController? = nil
    @IBOutlet weak var messageLabel: UILabel!
    
    var isRemoteVideoRender: Bool = true {
        didSet {
            remoteVideoMutedIndicator.isHidden = isRemoteVideoRender
            remoteVideo.isHidden = !isRemoteVideoRender
        }
    }
    
    var isLocalVideoRender: Bool = false {
        didSet {
            localVideoMutedIndicator.isHidden = isLocalVideoRender
        }
    }
    
    var isStartCalling: Bool = true {
        didSet {
            if isStartCalling {
                micButton.isSelected = false
            }
            micButton.isHidden = !isStartCalling
            cameraButton.isHidden = !isStartCalling
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collageView.layer.cornerRadius = 20
        collageView.layer.masksToBounds = true
        collageView.alpha = 0
        createButton.layer.cornerRadius = 20
        savePopup.layer.cornerRadius = 20
        toolBottom.constant = -300
        savePopY.constant = 800
        
        clearLabel.alpha = 0
        saveLabel.alpha = 0
        toolLabel.alpha = 1
        savePopup.alpha = 0
        
        //REMOTE VIEW constraints
        remoteVideo.translatesAutoresizingMaskIntoConstraints = false
        
        remoteTrail = remoteVideo.rightAnchor.constraint(equalTo: view.rightAnchor)
        remoteTop = remoteVideo.topAnchor.constraint(equalTo: view.topAnchor)
        remoteWidth = remoteVideo.widthAnchor.constraint(equalToConstant: view.frame.width)
        remoteHeight = remoteVideo.heightAnchor.constraint(equalToConstant: view.frame.height)
        
        remoteTrail?.isActive = true
        remoteTop?.isActive = true
        remoteWidth?.isActive = true
        remoteHeight?.isActive = true
        
        //LOCAL VIEW constraints
        localVideo.translatesAutoresizingMaskIntoConstraints = false
        
        localTrail = localVideo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        localTop = localVideo.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        localWidth = localVideo.widthAnchor.constraint(equalToConstant: view.frame.width * 0.2)
        localHeight = localVideo.heightAnchor.constraint(equalToConstant: (view.frame.width * 0.2) / 1.3)
        
        localTrail?.isActive = true
        localTop?.isActive = true
        localWidth?.isActive = true
        localHeight?.isActive = true
        
        //INITIALISE VIDEO
        initializeAgoraEngine()
        setupVideo()
        setupLocalVideo()
        //setChannelProfile()
        //setClientRole()
        joinChannel()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CollageViewController {
            self.containerCollage = vc
        }
    }
    
    func initializeAgoraEngine() {
        // init AgoraRtcEngineKit
        agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
    }
    
    func setupVideo() {
        // In simple use cases, we only need to enable video capturing
        // and rendering once at the initialization step.
        // Note: audio recording and playing is enabled by default.
        agoraKit.enableVideo()
        
        // Set video configuration
        // Please go to this page for detailed explanation
        agoraKit.setVideoEncoderConfiguration(AgoraVideoEncoderConfiguration(size: AgoraVideoDimension640x360,
                                                                             frameRate: .fps15,
                                                                             bitrate: AgoraVideoBitrateStandard,
                                                                             orientationMode: .adaptative))
    }
    
    func setupLocalVideo() {
        // This is used to set a local preview.
        // The steps setting local and remote view are very similar.
        // But note that if the local user do not have a uid or do
        // not care what the uid is, he can set his uid as ZERO.
        // Our server will assign one and return the uid via the block
        // callback (joinSuccessBlock) after
        // joining the channel successfully.
        localVideoMutedBg.isHidden = true
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupLocalVideo(videoCanvas)
    }
    
    func setChannelProfile() {
        
        //agoraKit.setChannelProfile(.liveBroadcasting)
    }
    
    func setClientRole() {
        //agoraKit.setClientRole(.broadcaster)
    }
    
    func joinChannel() {
        // Ensure that this method is called from the native side to interoperate with the Web SDK.
        //agoraKit.enableWebSdkInteroperability(true)
        // Set audio route to speaker
        agoraKit.setDefaultAudioRouteToSpeakerphone(true)
        
        // 1. Users can only see each other after they join the
        // same channel successfully using the same app id.
        // 2. One token is only valid for the channel name that
        // you use to generate this token.
        agoraKit.joinChannel(byToken: Token, channelId: "chatBeeDemo", info: nil, uid: 0) { [unowned self] (channel, uid, elapsed) -> Void in
            // Did join channel "demoChannel1"
            self.isLocalVideoRender = true
            //self.logVC?.log(type: .info, content: "did join channel")
        }
        
        isStartCalling = true
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func leaveChannel() {
        // leave channel and end chat
        agoraKit.leaveChannel(nil)
        
        isRemoteVideoRender = false
        isLocalVideoRender = false
        //isStartCalling = false
        UIApplication.shared.isIdleTimerDisabled = false
        //self.logVC?.log(type: .info, content: "did leave channel")
    }
    
    @IBAction func didClickHangUpButton(_ sender: UIButton) {
        
        if (containerCollage?.checkCollage())! > 1 {
            releasePopup()
        } else {
            var isThere = false
            for person in FriendManager.friendArray {
                if callRecipient?.name == person.name {
                    isThere = true
                }
            }
            if isThere == true {
                sender.isSelected.toggle()
                if sender.isSelected {
                    leaveChannel()
                }
                self.performSegue(withIdentifier: "unwindToHome", sender: self)
            } else {
               releaseFriendRequest()
            }
        }
    }
    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        //sender.setImage(UIImage(named: "mic_pressed"), for: UIControl.State.normal)
        // mute local audio
        agoraKit.muteLocalAudioStream(sender.isSelected)
    }
    
    @IBAction func didClickSwitchCameraButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        agoraKit.switchCamera()
    }
    
    @IBAction func didClickVideoMuteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        agoraKit.muteLocalVideoStream(sender.isSelected)
        localVideo.isHidden = sender.isSelected
        localVideoMutedBg.isHidden = !sender.isSelected
        localVideoMutedIndicator.isHidden = !sender.isSelected
    }
    
    //collage actions
    @IBAction func buttonRender(_ sender: Any) {
        
        if collageActive == false {
            
            createButton.backgroundColor = #colorLiteral(red: 0.09410236031, green: 0.09412645549, blue: 0.09410081059, alpha: 1)
            createButton.tintColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)
            createLabel.text = "Close"
            
            //remoteView resize
            remoteTrail?.constant = -40
            remoteTop?.constant = 40
            remoteWidth?.constant = view.frame.width * 0.2
            remoteHeight?.constant = (view.frame.width * 0.2) / 1.3
            
            //localView resize
            localWidth?.constant = view.frame.width * 0.08
            localHeight?.constant = (view.frame.width * 0.08) / 1.3
            
            //animate CollageView
            collageTop.constant = 0
            toolBottom.constant = 15
            
            UIView.animate(withDuration: 0.3) {
                self.collageView.alpha = 1
                self.view.layoutIfNeeded()
            }
            collageActive = true
            
        } else {
            createButton.backgroundColor = #colorLiteral(red: 1, green: 0.7993489356, blue: 0, alpha: 1)
            createButton.tintColor = #colorLiteral(red: 0.09410236031, green: 0.09412645549, blue: 0.09410081059, alpha: 1)
            createLabel.text = "Create"
            
            //remoteView resize
            remoteTrail?.constant = 0
            remoteTop?.constant = 0
            remoteWidth?.constant = view.frame.width
            remoteHeight?.constant = view.frame.height
            
            //localView resize
            localTrail?.constant = -40
            localTop?.constant = 40
            localWidth?.constant = view.frame.width * 0.2
            localHeight?.constant = (view.frame.width * 0.2) / 1.3

            //animate CollageView
            collageTop.constant = -1500
            toolBottom.constant = -300
            
            UIView.animate(withDuration: 0.3) {
                self.collageView.alpha = 0
                self.view.layoutIfNeeded()
            }
            collapseTools()
            collageActive = false

            toolButton.isSelected = false
        }
    }
    
    @IBAction func toggleTools(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        print(sender.isSelected)
        
        if toolButton.isSelected == true {
            clearCenterY.constant = -120
            saveCenterY.constant = -125
            UIView.animate(withDuration: 0.3) {
                self.clearLabel.alpha = 1
                self.saveLabel.alpha = 1
                self.toolLabel.alpha = 0
                self.view.layoutIfNeeded()
            }
        } else {
            collapseTools();
        }
    }
    
    @IBAction func triggerSave(_ sender: Any) {
        releasePopup()
    }
    
    @IBAction func triggerDecline(_ sender: Any) {
        retractPopup()
    }
    
    @IBAction func addFriend(_ sender: Any) {
        //friends.friendArray.insert(callRecipient!, at: 2)
        print(FriendManager.friendArray.count)
        FriendManager.friendArray.insert(callRecipient!, at: 0)
        print(FriendManager.friendArray.count)
    }
    
    @IBAction func saveCollage(_ sender: Any) {
       
        UIGraphicsBeginImageContext(collageView.frame.size)
        collageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let scrapObj = ScrapObject(collage: image!, date: Date(), partner: callRecipient!)
        LocalScrapManager.scraps.append(scrapObj)
        print(LocalScrapManager.scraps.count)
        retractPopup()
        containerCollage?.clearTheBoard()
        
    }
    
    @IBAction func clearCollage(_ sender: Any) {
        containerCollage?.clearTheBoard()
    }
    
    func releasePopup() {
        savePopY.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.savePopup.alpha = 1
            self.darkMask.alpha = 0.8
        }
    }
    
    func retractPopup() {
        savePopY.constant = 800
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.savePopup.alpha = 0
            self.darkMask.alpha = 0
        }
    }
    
    func releaseFriendRequest() {
        messageLabel.text = "Would you like to add \(callRecipient!.name) as your friend?"
        friendRequestY.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.darkMask.alpha = 0.8
            self.view.layoutIfNeeded()
        })
    }
    
    func collapseTools() {
        clearCenterY.constant = 0
        saveCenterY.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.clearLabel.alpha = 0
            self.saveLabel.alpha = 0
            self.toolLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    
}

extension VideoChatController: AgoraRtcEngineDelegate {
    // first remote video frame
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        isRemoteVideoRender = true
        
        // Only one remote video view is available for this
        // tutorial. Here we check if there exists a surface
        // view tagged as this uid.
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteVideo
        videoCanvas.renderMode = .hidden
        agoraKit.setupRemoteVideo(videoCanvas)
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid:UInt, reason:AgoraUserOfflineReason) {
        isRemoteVideoRender = false
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted:Bool, byUid:UInt) {
        isRemoteVideoRender = !muted
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
        //logVC?.log(type: .warning, content: "did occur warning, code: \(warningCode.rawValue)")
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
        //logVC?.log(type: .error, content: "did occur error, code: \(errorCode.rawValue)")
    }
}

