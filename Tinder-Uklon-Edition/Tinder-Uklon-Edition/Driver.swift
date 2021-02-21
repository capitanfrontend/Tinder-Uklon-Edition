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

import Foundation

internal class Driver {

    let name: String
    let rating: Int
    let carModel: String
    let carImageLabel: String
    let imageLabel: String
    let discription: String

    init(name: String, rating: Int, carModel: String, carImageName: String, imageLabel: String, discription: String) {
        self.name = name
        self.rating = rating
        self.carModel = carModel
        self.carImageLabel = carImageName
        self.imageLabel = imageLabel
        self.discription = discription
    }
    
    init() {
        self.name = "Default User"
        self.rating = 5
        self.carModel = "Reno Logan"
        self.carImageLabel = "Car5"
        self.imageLabel = "Driver4"
        self.discription = "..."
    }
}