import Foundation

func call(after: Double, callback: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        callback()
    }
}

typealias Callback = () -> ()
