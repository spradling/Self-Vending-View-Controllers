import UIKit

// to be shared, all modules can implement their own enumerated storyboards
// but should all offer the below functionality for them
protocol StoryboardVendor: RawRepresentable where RawValue == String {
    
    var bundle: Bundle? { get }
    
}

extension StoryboardVendor {
    
    var storyboard: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: bundle)
        
    }
    
    func initial<T: UIViewController>(_ type: T.Type) -> T? {
        return storyboard.instantiateInitialViewController() as? T
        
    }
    
    func viewController<T: UIViewController>(_ type: T.Type, id: String?) -> T? {
        guard let id = id else {
            return initial(type)
        }
        
        return storyboard.instantiateViewController(withIdentifier: id) as? T
        
    }
    
}

protocol NibVendor: StoryboardVendor {
    // Usually this will be 0, but configurable in case one xib houses multiple nibs
    var nibIndex: Int { get }
    
}

extension NibVendor {
    
    var nibIndex: Int { return 0 }
    
    func viewController<T: UIViewController>(_ type: T.Type) -> T? {
        
        return T(nibName: rawValue, bundle: bundle)
        
    }
    
    var nib: UINib {
        
        return UINib(nibName: rawValue, bundle: bundle)
        
    }
    
    func view<T: UIView>(withOwner: Any?) -> T? {
        
        return nib.instantiate(withOwner: withOwner).filter({ $0 is T.Type })[nibIndex] as? T
        
    }
    
}


// This is meant to clear up ambiguity between VCs that
// live in storyboards and those that are loaded from
// nibs. Without an enum, all VCs would have to provide
// both a storyboard ID and a xib ID, one of which
// would be invalid.
//
// This could be improved by adding capability for a
// simpler implementation of SelfVendingViewController,
// for those modules in which ViewControllers will always
// only come from storyboards, or always only xibs.
enum ViewSourceType<S: StoryboardVendor, N: NibVendor> {
    
    case storyboard(S, id: String?)
    case storyboardWhereInitial(S)
    case nib(N)
    
}

// Enumerated storyboards only gets us so far, and still requires a lot of
// Investigation at implementation time to know where each viewController
// lives in what storyboard. So, we should tie that knowledge to the VC itself
protocol SelfVendingViewController where Self: UIViewController {
    
    associatedtype StoryboardType: StoryboardVendor
    associatedtype NibType: NibVendor
    
    typealias Source = ViewSourceType<StoryboardType, NibType>
    
    static var viewSource: Source? { get }
    
}

// non-overridable methods in protocol extension, keep implementation simple
extension SelfVendingViewController {
    
    static var viewController: Self? {
        
        guard let source = viewSource else { return nil }
        switch source {
        case .nib(let nib):
            return nib.viewController(self)
        case .storyboardWhereInitial(let board):
            return board.initial(self)
        case .storyboard(let board, let id):
            return board.viewController(self, id: id)
        }
        
    }
    
    static var viewControllerInNavigationController: UINavigationController? {
        // just a quick convenience method, we do a lot of this on-site
        // currently when instantiating view controllers
        //
        // also most of our storyboard clutter is NavControllers, it's
        // good to reinforce that we don't really need them there
        guard let vc = viewController else { return nil }
        return UINavigationController(rootViewController: vc)
        
    }
    
}

// simply enumerates the storyboards available in the module
// using loyalty module as an example, the idea is that each
// module will get its own one of these. Would be nice to
// have a base class implementation of StoryboardVendor to
// share, ideas welcome (tricky b/c you can't subclass enums)
enum LoyaltyStoryboard: String, StoryboardVendor {
    
    case contactUs      = "HotelContactUs"
    case callUs         = "CallUs"
    case accountAlert   = "AccountAlert"
    case honorsCard     = "AccountHonorsCard"
    case accountChanges = "AccountChanges"
    case accountHome    = "AccountHome"
    case pointsActivity = "AccountPointsActivity"
    case myAccount      = "HotelMyAccount"
    case honorsMeter    = "HHonorsMeter"
    case favorites      = "MyAccountFavorites"
    
    var bundle: Bundle? {
        return nil
    }
    
}

// Metaclass for the module is only really used to set up the typealias, so
// that subclass VCs will be constrained to using this module's storyboard enum.
// It's entirely possible to omit this step, but then each concrete VC
// would be responsible for defining its own Storyboard and Nib enum sources
class LoyaltyViewController: UIViewController, SelfVendingViewController {
    
    typealias StoryboardType = LoyaltyStoryboard
    typealias NibType = LoyaltyNibs
    
    class var viewSource: Source? { return nil }
    
}

// Concrete class inherits from the Module's ViewController class, and
// all we have to define here is the storyboard and viewID where
// this VC lives
class SomeSpecificViewController: LoyaltyViewController {
    
    static var loadAsInitialVC: Bool = true // complication for extra credit
    
    override class var viewSource: Source? {
        if loadAsInitialVC {
            return .storyboardWhereInitial(.accountHome)
        } else {
            return .storyboard(.accountHome, id: "I aM a StOrYBoArD iDeNtIfIeR") }
    }
    
}

// Ex. how it works with a nib-based VC
class SomeNibLoadingViewController: LoyaltyViewController {
    
    override class var viewSource: Source? { return .nib(.whatever) }
    
}

//
// NOW WE TRY THE NIB VIEWS
//


// example set of nib names, very similar
// in function to LoyaltyStoryboard
enum LoyaltyNibs: String, NibVendor {
    
    case whatever
    case whateverElse
    
    var bundle: Bundle? {
        return Bundle.main
    }
    
    var nib: UINib {
        return UINib(nibName: rawValue, bundle: bundle)
    }
    
    func firstView<T: UIView>() -> T? {
        return nib.instantiate(withOwner: nil).first as? T
    }
    
}

// same deal as SelfVendingViewController: this
// protocol does the processing of key identifiers
// into a view -- this one is simpler because we
// a UIView is only ever going to come from a nib
// (not a storyboard)
protocol SelfVendingView where Self: UIView {
    
    associatedtype NibType: NibVendor
    
    static var nibName: NibType? { get }
    
}

extension SelfVendingView {
    
    static var view: Self? {
        return view(withOwner: nil)
    }
    
    static func view(withOwner owner: Any?) -> Self? {
        return nibName?.view(withOwner: owner)
    }
    
    static var nib: UINib? {
        return nibName?.nib
    }
    
}

// Example view implementation
// This section is lacking a `ModuleView` metaclass,
// which just shows that in both cases it is optional
class SomeSpecificNibBasedView: UIView, SelfVendingView {
    
    typealias NibType = LoyaltyNibs
    
    class var nibName: LoyaltyNibs? { return .whatever }
    
}


protocol someProtocol {
    static var identifier: String { get }
}

extension someProtocol {
    static var identifier: String { return String(describing: Self.self) }
    
    static func staticPrintIdentifier() {
        print(identifier)
    }
    
    func printIdentifier() {
        print(Self.identifier)
    }
}

class genericClass: someProtocol {}
class specialClass: someProtocol {
    class var identifier: String { return "the special one" }
}


print(genericClass.identifier)
print(specialClass.identifier)

genericClass.staticPrintIdentifier()
specialClass.staticPrintIdentifier()

genericClass().printIdentifier()
specialClass().printIdentifier()

