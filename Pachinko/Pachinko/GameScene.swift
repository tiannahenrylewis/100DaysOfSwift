//
//  GameScene.swift
//  Pachinko
//
//  Created by Tianna Henry-Lewis on 2019-05-11.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var ballCountLabel: SKLabelNode!
    var boxCountLabel: SKLabelNode!

    var boxes =  [SKNode]()
    var ballColours = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballPurple" ]

    var ballsAvailable = 5 {
        didSet {
            ballCountLabel.text = "\(ballsUsed) / \(ballsAvailable)"
        }
    }
    var ballsUsed = 0 {
        didSet {
            ballCountLabel.text = "\(ballsUsed) / \(ballsAvailable)"
        }
    }
    var boxesToPlace = 10 {
        didSet {
            boxCountLabel.text = "\(boxesPlaced) / \(boxesToPlace)"
        }
    }
    var boxesPlaced = 0 {
        didSet {
            boxCountLabel.text = "\(boxesPlaced) / \(boxesToPlace)"
        }
    }


    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var editingMode: Bool = true {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)

        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)

        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        editLabel.horizontalAlignmentMode = .left
        addChild(editLabel)

        ballCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballCountLabel.text = "\(ballsUsed) / \(ballsAvailable)"
        ballCountLabel.horizontalAlignmentMode = .center
        ballCountLabel.position = CGPoint(x: 512, y: 700)
        addChild(ballCountLabel)

        boxCountLabel = SKLabelNode(fontNamed: "Chalkduster")
        boxCountLabel.text = "\(boxesPlaced) / \(boxesToPlace)"
        boxCountLabel.position = CGPoint(x: 80, y: 650)
        boxCountLabel.horizontalAlignmentMode = .left
        addChild(boxCountLabel)

        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))

        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        let objects = nodes(at: location)

//        if objects.contains(editLabel) {
//            editingMode.toggle()
//        } else {
//            if editingMode {
//                //create a box of random size with a random rotation
//                let size = CGSize(width: Int.random(in: 32...128), height: 16)
//                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
//                box.zRotation = CGFloat.random(in: 0...3)
//                box.position = location
//                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
//                box.physicsBody?.isDynamic = false
//                box.name = "box"
//                addChild(box)
//                boxes.append(box)
//                print(boxes)
//            } else {
//                ballsUsed += 1
//                //create a ball
//                if ballsUsed <= ballsAvailable {
//                    let randomNumber = Int.random(in: 0...6)
//                    let ball = SKSpriteNode(imageNamed: ballColours[randomNumber])
//                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
//                    ball.physicsBody?.restitution = 0.4
//                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
//                    //ball.position = location
//                    ball.position = CGPoint(x: location.x, y: 680)
//                    ball.name = "ball"
//                    addChild(ball)
//                } else {
//                    let ac = UIAlertController(title: "Game Over", message: "You have run out of balls.", preferredStyle: .alert)
//                    ac.addAction(UIAlertAction(title: "Restart", style: .default))
//                    //present(ac, animated: true)
//                    self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)
//
//                    resetGame()
//                }
//            }
//        }

        //MARK: - Start Game in Edit Mode
        //User has to place 10 boxes before they can start dropping balls

        if boxesPlaced < boxesToPlace {
            //create a box of random size with a random rotation
            let size = CGSize(width: Int.random(in: 32...128), height: 16)
            let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
            box.zRotation = CGFloat.random(in: 0...3)
            box.position = location
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.name = "box"
            addChild(box)
            boxes.append(box)

            //increment boxesPlaced integer by one
            boxesPlaced += 1
        } else {
            ballsUsed += 1

            if ballsUsed <= ballsAvailable {
                let randomNumber = Int.random(in: 0...6)
                let ball = SKSpriteNode(imageNamed: ballColours[randomNumber])
                ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                ball.physicsBody?.restitution = 0.4
                ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                //ball.position = location
                ball.position = CGPoint(x: location.x, y: 680)
                ball.name = "ball"
                addChild(ball)
            } else {
                let ac = UIAlertController(title: "Game Over", message: "You have run out of balls.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default))
                //present(ac, animated: true)
                self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)

                resetGame()
            }

        }
    }

    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }

    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode

        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }

        slotBase.position = position
        slotGlow.position = position

        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false

        addChild(slotBase)
        addChild(slotGlow)

        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }

    func collision(between ball: SKNode, object: SKNode) {
        //if the object identifier is "good" (ie. the good slotBases)
        if object.name == "good" {
            //destory ball object
            destroy(ball: ball)
            //increment score by 1
            score += 1
            //add another ball to players available balls
            ballsAvailable += 1
        //If the object identifier is "bad" (ie. the bad slotBases)
        } else if object.name == "bad" {
            //destory ball object
            destroy(ball: ball)
            //decrease the score by 1
            if score > 0 {
                score -= 1
            }
        }
    }

    func collide(with box: SKNode, with ball: SKNode) {
        if box.name == "box" {
            //destory box object
            destoryBox(box: box)
            boxesPlaced -= 1
        }
    }

    func destroy (ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
    }

    func destoryBox (box: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = box.position
            addChild(fireParticles)
        }
        box.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }

        if nodeA.name == "box" {
            collide(with: nodeA, with: nodeB)
        } else if nodeB.name == "box" {
            collide(with: nodeB, with: nodeA)
        }
    }

    @objc func resetGame() {
        //reset the number of available balls to five
        ballsAvailable = 5

        //reset the number of balls used to 0
        ballsUsed = 0

        //reset the number of boxes to place
        boxesToPlace = 0

        //remove all the SKNodes in the boxes array from the scene
        removeChildren(in: boxes)

        //clear the boxes array
        boxes.removeAll()

        //reset score to 0
        score = 0
    }

    //Not currently being implemented.
    func checkObstacles() {
        if boxesPlaced == 0 {
            let ac = UIAlertController(title: "You Won", message: "You cleared the obstacles before running out of balls.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default))
            self.view?.window?.rootViewController?.present(ac, animated: true, completion: nil)

            resetGame()
        }
    }

}
