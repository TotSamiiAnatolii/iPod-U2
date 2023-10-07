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

final class PlayerViewController: PlayerBaseViewController<PlayerView> {
    
    private var model: ModelTrack {
        didSet {
            PlayerIPod.shared.replaceTrack(track: model.track)
            configureView(model: model)
        }
    }
    
    private let mapper = Mapper()
    
    weak var delegate: PlayerIPodDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTrack(track: model)
        setupNavigationBar(letftItem: Images.play, header: ScreenTitle.player.rawValue)
    }
    
    init(parentControl: ContainerViewController, model: ModelTrack) {
        self.model = model
        super.init(parentControl: parentControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func switchButton(sender: ButtonPlayer)  {
        switch sender {
        case .menu:
            backSelectTrack()
        case .playPause:
            PlayerIPod.shared.statePlayer = PlayerIPod.shared.statePlayer == .play ? .pause : .play
            setStatePlayerNavBar(state: PlayerIPod.shared.statePlayer)
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
        let countTrack = delegate?.fetchCountTrack(id: model.id)
        let modelView = mapper.map(model: model, countTrack: countTrack)
        contentView.configure(with: modelView)
    }
    
    private func backSelectTrack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setStatePlayerNavBar(state: StatePlayer) {
        guard let navigationController = self.navigationController as? IPodNavigationController else { return }
        navigationController.setStatePlayer(state: state)
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
        contentView.updateProgressView(model: model)
    }
}
