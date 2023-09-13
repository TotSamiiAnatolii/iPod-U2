//
//  PlayerViewController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

protocol PlayerViewProtocol {
    
    func setTrack(track: ModelTrack)
    
    func updateProgressTrack(model: ModelProgressTrack)
    
    func forwardTrack()
    
    func goToBackTrack()
}

final class PlayerViewController: UIViewController {
    
    private var model: ModelTrack {
        didSet {
            PlayerIPod.shared.replaceTrack(track: model.track)
            configureView(model: model)
        }
    }
    
    weak var parentControl: ContainerViewController?
    
    weak var delegate: PlayerIPodDelegate?
    
    fileprivate var playerView: PlayerView {
        guard let view = self.view as? PlayerView else { return PlayerView()}
        return view
    }
    
    override func loadView() {
        super.loadView()
        self.view = PlayerView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        parentControl?.onAction = {[weak self] type in
            guard let self = self else {
                return
            }
            self.switchButton(sender: type)
        }
        setTrack(track: model)
    }
    
    init(parentControl: ContainerViewController, model: ModelTrack) {
        self.parentControl = parentControl
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func switchButton(sender: ButtonPlayer)  {
        switch sender {
        case .menu:
            backSelectTrack()
        case .playPause:
            PlayerIPod.shared.statePlayer = PlayerIPod.shared.statePlayer == .play ? .pause : .play
        case .right:
            forwardTrack()
        case .left:
            goToBackTrack()
        case .select:
            backSelectTrack()
        case .forward:
            PlayerIPod.shared.buttonForwardSec()
        case .back:
            PlayerIPod.shared.buttonGoToBackSec()
        }
    }
    
    private func configureView(model: ModelTrack) {
        let modelView = ModelPlayTrackDisplay(
            countTrack: delegate?.fetchCountTrack(id: model.id) ?? (0, 0),
            nameTrack: model.nameTrack,
            namePerformer: model.namePerformer,
            nameAlbum: model.nameAlbum,
            imageTrack: model.image)
        
        playerView.configure(with: modelView)
    }
    
    private func backSelectTrack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PlayerViewController: PlayerViewProtocol {
    
    func setTrack(track: ModelTrack) {
        PlayerIPod.shared.setButtonTapSound(sound: model.track)
        configureView(model: model)
        
        PlayerIPod.shared.updateProgress {[weak self] modelProgress in
            guard let self = self else {
                return
            }
            
            self.updateProgressTrack(model: modelProgress)
            
            if modelProgress.endTrack {
                self.switchButton(sender: .right)
            }
        }
    }
    
    func forwardTrack() {
        guard let track = delegate?.forwardTrack(id: model.id) else {
            return
        }
        model = track
    }
    
    func goToBackTrack() {
        guard let track = delegate?.goToBackTrack(id: model.id) else {
            return
        }
        model = track
    }
    
    func updateProgressTrack(model: ModelProgressTrack) {
        playerView.updateProgressView(model: model)
    }
}
