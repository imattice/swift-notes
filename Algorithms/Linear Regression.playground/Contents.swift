//Linear Regression
//  Create a line within a data set that is as close to each data point as possible


let carAge: [Double] = [10, 8, 3, 3, 2, 1]
let carPrice: [Double] = [500, 400 ,700, 8500, 11000, 10500]

//represent the straight line
var intercept = 0.0
var slope = 0.0

func predictedCarPrice(carAge: Double) -> Double {
    return intercept + slope * carAge
}

let numberOfCarAdvertsSeen = carPrice.count
let iterations = 2000
let alpha = 0.0001