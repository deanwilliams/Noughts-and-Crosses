//
//  ViewController.swift
//  Noughts and Crosses
//
//  Created by Dean Williams on 13/09/2015.
//  Copyright © 2015 Codemonkeyism. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1 = noughts, 2 = crosses
    var activePlayer = 1
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameActive = true
    
    var winningCombos = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
    ]
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var winningLabel: UILabel!
    
    @IBOutlet var playAgainButton: UIButton!
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameActive = true
        
        var button = UIButton()
        for var i = 0; i < 9; i++ {
            button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, forState: UIControlState.Normal)
        }
        
        winningLabel.hidden = true
        playAgainButton.hidden = true;
        winningLabel.center = CGPointMake(winningLabel.center.x - 400, winningLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if gameState[sender.tag] == 0 && gameActive {
            var image = UIImage()
            
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                image = UIImage(named: "nought.png")!
                activePlayer = 2
            } else {
                image = UIImage(named: "cross.png")!
                activePlayer = 1
            }
            sender.setImage(image, forState: UIControlState.Normal)
            
            var gameWon = false
            
            for combination in winningCombos {
                if gameState[combination[0]] != 0
                    && gameState[combination[0]] == gameState[combination[1]]
                    && gameState[combination[1]] == gameState[combination[2]] {
                        gameWon = true
                        
                        var labelText = "Noughts have Won!"
                        if gameState[combination[0]] == 2 {
                            labelText = "Crosses have won!"
                        }
                        
                        winningLabel.text = labelText
                        winningLabel.hidden = false
                        playAgainButton.hidden = false

                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.winningLabel.center = CGPointMake(self.winningLabel.center.x + 400, self.winningLabel.center.y)
                            self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
                        })
                        gameActive = false
                }
            }
            
            if !gameWon {
                var movesLeft = false
                for state in gameState {
                    if state == 0 {
                        movesLeft = true
                        break
                    }
                }
                
                if !movesLeft {
                    winningLabel.text = "Stalemate!"
                    winningLabel.hidden = false
                    playAgainButton.hidden = false
                    
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.winningLabel.center = CGPointMake(self.winningLabel.center.x + 400, self.winningLabel.center.y)
                        self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x + 400, self.playAgainButton.center.y)
                    })
                    gameActive = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winningLabel.hidden = true
        playAgainButton.hidden = true;
        winningLabel.center = CGPointMake(winningLabel.center.x - 400, winningLabel.center.y)
        playAgainButton.center = CGPointMake(playAgainButton.center.x - 400, playAgainButton.center.y)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

