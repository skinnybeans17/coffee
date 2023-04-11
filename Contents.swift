import UIKit

struct BobaTea {
  var tea: TeaType
  let sweetness: Int
  let hasBoba: Bool
  let milkOption: MilkOption
}

var typeOfTea = TeaType.chai

enum TeaType : String{
    case black = "black"
    case oolong = "oolong"
    case lavender = "lavender"
    case chai = "chai"
}

print(typeOfTea.rawValue)

var milkOption = MilkOption.oat

enum MilkOption : Int{
    case oat
    case whole
    case almond
}

print(milkOption.rawValue)

struct Order {
  var boba: BobaTea
  let customer: Customer

  func printDescription(){
    print("\(customer.firstName) ordered \(boba.tea) boba tea, \(boba.sweetness)% sweetness, \(boba.hasBoba ? "with boba" : "no boba") and \(boba.milkOption) milk")
  }
}

class Customer {
  var firstName: String
  var lastName: String

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

enum OrderFullfilment {
  case success(message: String)
  case error(message: String)
}

func createOrder(withTea tea: TeaType, sweetness level:Int, forCustomer customer: Customer, includeBoba hasBoba: Bool, withMilk milk: MilkOption) -> Order{
    let boba = BobaTea(tea: tea, sweetness: level, hasBoba: hasBoba, milkOption: milk)
    let order = Order(boba: boba, customer: customer)
    return order
}

func makeOrder(order: Order) -> OrderFullfilment {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    if hour < 17 && hour > 9{
        return .success(message: "You can pick up your order in 30 min")
    }else{
        return .error(message: "We are closed, try tomorrow")
    }
}

let newcustomer = Customer(firstName: "Monica", lastName: "Geller")

if let tea = TeaType.init(rawValue: "black"), let milk = MilkOption.init(rawValue: 0){
    let newOrder = createOrder(withTea: tea, sweetness: 25, forCustomer: newcustomer, includeBoba: true, withMilk: milk)
    newOrder.printDescription()

    let orderResult = makeOrder(order: newOrder)

    switch orderResult {
    case .success(let message):
      print("Order result: \(message)")
    case .error(let message):
      print("Order result: \(message)")
    }
}
