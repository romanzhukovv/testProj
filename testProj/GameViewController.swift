//
//  GameViewController.swift
//  testProj
//
//  Created by Анастасия Птах on 06.10.2021.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var NextDigit: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self](status, time) in
        guard let self = self else {return}
        self.timerLabel.text = "\(time)"
        self.updateInfoGame(width: status)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else {return}
        game.check(index:buttonIndex)
        
        updateUI()
    }
    
    private func setupScreen(){
        
        for index in game.items.indices{
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        NextDigit.text = game.nextItem?.title
    }
    
    private func updateUI(){
        for index in game.items.indices{
            buttons[index].isHidden = game.items[index].isFound
        }
        NextDigit.text = game.nextItem?.title
        
        updateInfoGame(width: game.status)                          //не понятно почему game.status
    }
    
    private func updateInfoGame(width status:StatusGame){
        switch status {
        case .start:
            statusLabel.text = "Game began!"
        case .win:
            statusLabel.text = "You win!"
        case .lose:
            statusLabel.text = "You lose!"
        }
    }
}
