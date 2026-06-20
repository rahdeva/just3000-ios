import Foundation

extension Date {
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: self)
        if hour < 12 { return "Good morning" }
        if hour < 18 { return "Good afternoon" }
        return "Good evening"
    }

    var formattedDay: String {
        let f = DateFormatter()
        f.dateFormat = "EEEE, MMMM d"
        return f.string(from: self)
    }
}
