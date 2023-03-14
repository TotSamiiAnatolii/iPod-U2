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
    
    fileprivate let seekDuration: Float64 = 10
    
    private var lastIndex: IndexPath = [0, 0]

    private var tracks: [ModelTrack] = [
        ModelTrack(nameTrack: "liam_m-i-know", namePerformer: "liam_m-i-know", nameAlbum: "liam_m-i-know", track: Sounds.track1, image: Images.kartinca)]
    
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

        self.navigationController?.navigationBar.isHidden = true

        twoView.tableView.delegate = self
        twoView.tableView.dataSource = self
        self.view.translatesAutoresizingMaskIntoConstraints = true
        setStartTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        parentControl.onAction = { type in
            self.switchButton(sender: type)
        }
    }
    
    private func searchIndexNextTrack(name: String) -> Int {
        
        return tracks.firstIndex {$0.nameTrack == name} ?? 0
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectTrackCell.identifire, for: indexPath) as! SelectTrackCell

        if tracks[indexPath.row].isSelected {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }

        cell.configureCell(text: tracks[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tracks[indexPath.row].isSelected  {
            cell.isSelected = true
           
        }
    }
}
extension SelectTrackViewController: PlayerIPodDelegate {
    func goToBackTrack(name: String) -> ModelTrack? {
        let indexgoToBackTrack = searchIndexNextTrack(name: name) - 1
        
        if indexgoToBackTrack >= 0 {
            return tracks[indexgoToBackTrack]
        }
        return nil
    }
    
    func forwardTrack(name: String) -> ModelTrack? {
        let indexForwardTrack = searchIndexNextTrack(name: name) + 1
        let trackIndexes = tracks.count - 1
        
        if indexForwardTrack < trackIndexes {
            return tracks[indexForwardTrack]
        }
        return nil
    }
    
    func fetchContTrack(name: String) -> (Int, Int) {
      let numberCurrentTrack = searchIndexNextTrack(name: name) + 1
        return (numberCurrentTrack, tracks.count)
    }
    
    
}
