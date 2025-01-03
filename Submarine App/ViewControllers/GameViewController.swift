//
//  ViewController.swift
//  Submarine App
//
//  Created by Sasha on 3.01.25.
//

import UIKit

final class GameViewController: UIViewController {

    //MARK: Private Outlets
    private let backgroundOcean = UIImageView()
    private let seabed = UIImageView()
    private let rockInOcean = UIImageView()
    private let submarine = UIImageView()
    private var timer = Timer()
    private lazy var ship = addShip(image: ships.randomElement() ?? "")

    //MARK: Private Properties
    private let ships: [String] = [
        "1ship1",
        "1ship2",
        "1ship3",
        "1ship3",
        "1ship4",
        "1ship5"
    ]

    private let sizeHeightScreen = UIScreen.main.bounds.height
    private let sizeWidthScreen = UIScreen.main.bounds.width

    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI()
    }


}

//MARK: Private Methods
private extension GameViewController {

    //MARK: Update UI
    func updateUI() {
        configureBackground()
        configureSubmarine()
        configureSeabed()

        createShipOnTimer()
    }


    //MARK: Configure UI
    func configureBackground() {
        backgroundOcean.image = ._1Background
        backgroundOcean.adjustsImageSizeForAccessibilityContentSizeCategory = true
        backgroundOcean.translatesAutoresizingMaskIntoConstraints = false
        backgroundOcean.clipsToBounds = true

        view.addSubview(backgroundOcean)
        constraintsBackground()
    }

    func configureSeabed() {
        seabed.image = ._1Bottom
        seabed.adjustsImageSizeForAccessibilityContentSizeCategory = true
        seabed.translatesAutoresizingMaskIntoConstraints = false
        seabed.clipsToBounds = true

        view.addSubview(seabed)
        constraintsSeabed()
    }

    func configureSubmarine() {
        submarine.image = ._1Submarine
        submarine.adjustsImageSizeForAccessibilityContentSizeCategory = true
        submarine.translatesAutoresizingMaskIntoConstraints = false
        submarine.clipsToBounds = true

        view.addSubview(submarine)
        constraintsSubmarine()
    }


//MARK: Actions
    func createShipOnTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 50, repeats: true) { _ in
                self.createShip()
            }
            timer.fire()
        }

    func createShip() {
        let newShip = addShip(image: ships.randomElement() ?? "")
        newShip.adjustsImageSizeForAccessibilityContentSizeCategory = true
        newShip.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newShip)

        view.layoutIfNeeded()

        newShip.frame.size = CGSize(width: 400, height: 300)
        newShip.frame.origin.x = view.bounds.width

        NSLayoutConstraint.activate([
            newShip.centerYAnchor.constraint(equalTo: backgroundOcean.topAnchor)
        ])

        UIView.animate(withDuration: 20.0, delay: 0, options: .curveLinear) {
            newShip.frame.origin.x = -newShip.frame.width
        } completion: { _ in

            newShip.removeFromSuperview()
            if self.timer.isValid {
                self.createShip()
            }
        }


    }




    //MARK: UI Helper

    func addShip(image: String) -> UIImageView {
        {
            $0.image = UIImage(named: image)
            $0.contentMode = .scaleToFill
            $0.adjustsImageSizeForAccessibilityContentSizeCategory = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true

            return $0
        }(UIImageView())
    }


//MARK: Constraints
    func constraintsBackground() {
        NSLayoutConstraint.activate([
            backgroundOcean.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            backgroundOcean.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundOcean.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundOcean.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func constraintsSubmarine() {
        NSLayoutConstraint.activate([
            submarine.centerYAnchor.constraint(equalTo: backgroundOcean.centerYAnchor),
            submarine.leadingAnchor.constraint(equalTo: backgroundOcean.leadingAnchor, constant: 10)
        ])
    }

    func constraintsSeabed() {
        NSLayoutConstraint.activate([
            seabed.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            seabed.leadingAnchor.constraint(equalTo: backgroundOcean.leadingAnchor),
            seabed.trailingAnchor.constraint(equalTo: backgroundOcean.trailingAnchor)
        ])
    }



}



#Preview {
   let view = GameViewController()
    view
}
