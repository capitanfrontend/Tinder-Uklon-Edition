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
        Driver(name: "Nikolay", rating: 10, carModel: "Zaporozhets 2021", carImageName: "Car1", imageLabel: "Driver1", discription: "Довезу на шулявку за 40 грн"),
        Driver(name: "Sophia", rating: 10, carModel: "Hyundai Elantra", carImageName: "Car2", imageLabel: "Driver2", discription: "Таксую больше 5 лет, быстро и комфортно Соня" ),
        Driver(name: "Anastasia", rating: 10, carModel: "Tesla Model 3", carImageName: "Car3", imageLabel: "Driver3", discription: "Таксую шо батя"),
        Driver(name: "John", rating: 10, carModel: "Audi Q8", carImageName: "Car4", imageLabel: "Driver4", discription: "Зима близко"),
        Driver(name: "Daniel", rating: 100, carModel: "Peugeot 406", carImageName: "Car5", imageLabel: "Driver5", discription: "Таксую шо батя")
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
            cardCell.ratingLbl.text = "Rating: \(contact.rating )" + "/10"
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
