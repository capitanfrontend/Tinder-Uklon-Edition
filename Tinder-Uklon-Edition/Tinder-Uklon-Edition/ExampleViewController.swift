// MIT License
//
// Copyright (c) 2017 Joni Van Roost
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import VerticalCardSwiper

class ExampleViewController: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource {

    @IBOutlet private var cardSwiper: VerticalCardSwiper!

    private var driversDemoData: [Driver] = [
        Driver(name: "Nikolay", rating: "⭐️⭐️⭐️⭐️⭐️", carModel: "Zaporozhets 2021", imageLabel: "Driver1", discription: "My cell: +380953456785;\n email: nikolay.driver@uklon.com"),
        Driver(name: "Sophia", rating: "⭐️⭐️⭐️⭐️⭐️", carModel: "Hyundai Elantra", imageLabel: "Driver2", discription: "My cell: +380956758691;\n email: sophia.shumel@uklon.com" ),
        Driver(name: "Oleh", rating: "⭐️⭐️⭐️", carModel: "Toyota Camry", imageLabel: "Driver6", discription: "My cell: +38095789895;\n email: taxi.driver2@uklon.com"),
        Driver(name: "Anastasia", rating: "⭐️⭐️⭐️⭐️⭐️", carModel: "Tesla Model 3", imageLabel: "Driver3", discription: "My cell: +380954568777;\n email: ana.lagno@uklon.com"),
        Driver(name: "Vanessa", rating: "⭐️⭐️⭐️⭐️", carModel: "Woltwagen Tuareg", imageLabel: "Driver9", discription: "My cell: +360788789895;\n email: van.drive@uklon.com"),
        Driver(name: "John", rating: "⭐️⭐️⭐️⭐️⭐️", carModel: "Audi Q8", imageLabel: "Driver4", discription: "Winter is coming"),
        Driver(name: "Samuel", rating: "⭐️⭐️⭐️", carModel: "Honda", imageLabel: "Driver7", discription: "My cell: +306788789895;\n email: sam.driver@uklon.com"),
        Driver(name: "Daniel", rating: "⭐️⭐️⭐️⭐️⭐️", carModel: "Peugeot 406", imageLabel: "Driver5", discription: "My cell: +336788789895;\n email: taxi.driver@uklon.com"),
        Driver(name: "Sam", rating: "⭐️⭐️⭐️⭐️", carModel: "BMW 1999", imageLabel: "Driver8", discription: "My cell: +336548789895;\n email: taxi.driver1@uklon.com")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        cardSwiper.delegate = self
        cardSwiper.datasource = self

        // register cardcell for storyboard use
        cardSwiper.register(nib: UINib(nibName: "ExampleCell", bundle: nil), forCellWithReuseIdentifier: "ExampleCell")
        cardSwiper.reloadData()
    }

    @IBAction func pressRemoveCards(_ sender: UIBarButtonItem) {
        // remove the first 5 (or less) cards
        var indexesToRemove: [Int] = []
        for i in (0...4).reversed() where i < driversDemoData.count {
            driversDemoData.remove(at: i)
            indexesToRemove.append(i)
        }
        cardSwiper.deleteCards(at: indexesToRemove)
    }

    @IBAction func pressAddCards(_ sender: UIBarButtonItem) {
        let d1 = Driver()
        let d2 = Driver()
        let d3 = Driver()
        let d4 = Driver()
        let d5 = Driver()
        driversDemoData.insert(d1, at: 0)
        driversDemoData.insert(d2, at: 1)
        driversDemoData.insert(d3, at: 2)
        driversDemoData.insert(d4, at: 3)
        driversDemoData.insert(d5, at: 4)

        cardSwiper.insertCards(at: [0, 1, 2, 3, 4])
    }

    @IBAction func pressScrollUp(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex - 1, animated: true)
        }
    }

    @IBAction func pressLeftButton(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Left)
        }
    }

    @IBAction func pressRightButton(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.swipeCardAwayProgrammatically(at: currentIndex, to: .Right)
        }
    }

    @IBAction func pressScrollDown(_ sender: UIBarButtonItem) {
        if let currentIndex = cardSwiper.focussedCardIndex {
            _ = cardSwiper.scrollToCard(at: currentIndex + 1, animated: true)
        }
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {

        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "ExampleCell", for: index) as? ExampleCardCell {
            let contact = driversDemoData[index]
            cardCell.setRandomBackgroundColor()
            cardCell.driverLbl.text = "Driver: " + contact.name
            cardCell.ratingLbl.text = "Rating: \(contact.rating )"
            cardCell.carModel.text = "Car model: " + contact.carModel
            cardCell.discription.text = contact.discription
            cardCell.driverImage.image = UIImage(named: contact.imageLabel)
            return cardCell
        }
        return CardCell()
    }

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return driversDemoData.count
    }

    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        if index < driversDemoData.count {
            driversDemoData.remove(at: index)
        }
    }

    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }
}
