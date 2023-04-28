//
//  SelectTrackViewController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackViewController: UIViewController {
    
    fileprivate var parentControl: ContainerViewController
    
    fileprivate var twoView: SelectTrackView {
        guard let view = self.view as? SelectTrackView else { return SelectTrackView()}
        return view
    }
    
    private let heightForRowAt: CGFloat = 30
    
    private var lastIndex: IndexPath = [0, 0]
    
    private var tracks: [ModelTrack] = [
        ModelTrack(id: UUID(), nameTrack: "liam_m-i-know", namePerformer: "liam_m-i-know", nameAlbum: "liam_m-i-know", track: Sounds.track1, image: Images.liammiknow)]
    
    private var arrayCell: [ModelSelectTrackCell] = [] {
        didSet {
            twoView.tableView.reloadData()
        }
    }
    
    private func map(model: [ModelTrack]) -> [ModelSelectTrackCell] {
        
        return model.map { track in
            return ModelSelectTrackCell(trackName: track.nameTrack)
        }
    }
    
    init(parentControl: ContainerViewController) {
        self.parentControl = parentControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = SelectTrackView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        self.navigationController?.navigationBar.isHidden = true
        
        twoView.tableView.delegate = self
        twoView.tableView.dataSource = self
        arrayCell = map(model: tracks)
        setStartTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parentControl.onAction = { type in
            self.switchButton(sender: type)
        }
    }
    
    private func searchIndexNextTrack(id: UUID) -> Int {
        return tracks.firstIndex {$0.id == id} ?? 0
    }
    
    private func setStartTrack() {
        tracks[lastIndex.row].isSelected = true
        twoView.tableView.selectRow(at: lastIndex, animated: true, scrollPosition: .top)
    }
    
    private func preparationForTransition() {
        let playerVC = PlayerViewController(parentControl: parentControl, model: tracks[lastIndex.row])
        playerVC.delegate = self
        navigationController?.pushViewController(playerVC, animated: true)
    }
    
    private func selectGoToBackTrack() {
        
        let indexNextCell = lastIndex.row - 1
        
        if indexNextCell >= 0  {
            PlayerAppSounds.shared.setSounds(url: PlayerAppSounds.click)
            tracks[lastIndex.row].isSelected = false
            
            lastIndex.row = indexNextCell
            
            tracks[lastIndex.row].isSelected = true
            
            twoView.tableView.selectRow(at: lastIndex, animated: true, scrollPosition: .middle)
        }
    }
    
    private func selectNextTrack() {
        
        let indexNextCell = lastIndex.row + 1
        
        let trackIndexes = tracks.count - 1
        
        if indexNextCell <= trackIndexes {
            PlayerAppSounds.shared.setSounds(url: PlayerAppSounds.click)
            tracks[lastIndex.row].isSelected = false
            
            lastIndex.row = indexNextCell
            
            tracks[lastIndex.row].isSelected = true
            twoView.tableView.selectRow(at: lastIndex, animated: true, scrollPosition: .middle)
        }
    }
    
    private func switchButton(sender: ButtonPlayer)  {
        switch sender {
        case .menu:
            preparationForTransition()
            
        case .playPause:
            PlayerIPod.shared.statePlayer = PlayerIPod.shared.statePlayer == .play ? .pause : .play
            
        case .right:
            selectNextTrack()
            
        case .left:
            selectGoToBackTrack()
            
        case .select:
            preparationForTransition()
            
        case .forward:
            selectNextTrack()
            
        case .back:
            selectGoToBackTrack()
        }
    }
}
extension SelectTrackViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectTrackCell.identifire, for: indexPath) as? SelectTrackCell else {
            return UITableViewCell()
        }
        
        switch tracks[indexPath.row].isSelected {
        case true:
            cell.isSelected = true
        case false:
            cell.isSelected = false
        }
        cell.configure(with: arrayCell[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tracks[indexPath.row].isSelected  {
            cell.isSelected = true
        }
    }
}
extension SelectTrackViewController: PlayerIPodDelegate {
    
    func goToBackTrack(id: UUID) -> ModelTrack? {
        let indexgoToBackTrack = searchIndexNextTrack(id: id) - 1
        
        if indexgoToBackTrack >= 0 {
            return tracks[indexgoToBackTrack]
        }
        return nil
    }
    
    func forwardTrack(id: UUID) -> ModelTrack? {
        let indexForwardTrack = searchIndexNextTrack(id: id) + 1
        let trackIndexes = tracks.count - 1
        
        if indexForwardTrack <= trackIndexes {
            return tracks[indexForwardTrack]
        }
        return nil
    }
    
    func fetchCountTrack(id: UUID) -> (Int, Int) {
        let numberCurrentTrack = searchIndexNextTrack(id: id) + 1
        return (numberCurrentTrack, tracks.count)
    }
}
