import UIKit

var greeting = "Hello, playground"
/*
public class Subscription {
    public var type: String
    public var user: User?
    
    public init(type: String, user: User? = nil) {
        self.type = type
        self.user = user
    }
}

public class User {
    public var name: String
    public var subscriptions: Array<Subscription>
    
    public init(name: String) {
        self.name = name
        self.subscriptions = []
    }
}

#if !RunTests

var usr = User(name: "John Doe")
var sub = Subscription(type: "Cellphone", user: usr)

usr.subscriptions.append(sub)
print(usr)

#endif */


let sq = DispatchQueue(label: "Serail Queue")

sq.async {
    print("In serial-1")
    sq.sync {
        print("In serial-2")
    }
}






