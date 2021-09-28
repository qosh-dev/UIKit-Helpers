//
//  Constrainst.swift

import Foundation
import UIKit

extension Array  where Element == NSLayoutConstraint {
    func activate(){
        self.forEach { (constrain) in
            constrain.isActive = true
        }
    }
    
    func deactivate(){
        self.forEach { (constrain) in
            constrain.isActive = false
        }
    }
}

extension UIView {
    
    enum ViewAngle{
        case leading(const : CGFloat)
        case top(const : CGFloat)
        case trailing(const : CGFloat)
        case bottom(const : CGFloat)
    }
    enum ViewSize {
        case height(const : CGFloat)
        case width(const : CGFloat)
    }
    
    struct LayoutGuide {
        var leadingAnchor: NSLayoutXAxisAnchor
        var trailingAnchor: NSLayoutXAxisAnchor
        var leftAnchor: NSLayoutXAxisAnchor
        var rightAnchor: NSLayoutXAxisAnchor
        var topAnchor: NSLayoutYAxisAnchor
        var bottomAnchor: NSLayoutYAxisAnchor
        var widthAnchor: NSLayoutDimension
        var heightAnchor: NSLayoutDimension
        var centerXAnchor: NSLayoutXAxisAnchor
        var centerYAnchor: NSLayoutYAxisAnchor
        
        static func getFrom(_ obj : NSObject) -> LayoutGuide? {
            if let view = obj as? UIView {
                return LayoutGuide(
                   leadingAnchor  : view.leadingAnchor,
                   trailingAnchor : view.trailingAnchor,
                   leftAnchor     : view.leftAnchor,
                   rightAnchor    : view.rightAnchor,
                   topAnchor      : view.topAnchor,
                   bottomAnchor   : view.bottomAnchor,
                   widthAnchor    : view.widthAnchor,
                   heightAnchor   : view.heightAnchor,
                   centerXAnchor  : view.centerXAnchor,
                   centerYAnchor  : view.centerYAnchor
                )
            }
            if let val = obj as? UILayoutGuide {
                return LayoutGuide(
                    leadingAnchor  : val.leadingAnchor,
                    trailingAnchor : val.trailingAnchor,
                    leftAnchor     : val.leftAnchor,
                    rightAnchor    : val.rightAnchor,
                    topAnchor      : val.topAnchor,
                    bottomAnchor   : val.bottomAnchor,
                    widthAnchor    : val.widthAnchor,
                    heightAnchor   : val.heightAnchor,
                    centerXAnchor  : val.centerXAnchor,
                    centerYAnchor  : val.centerYAnchor
                )
            }
            return nil
        }
    }
    
    
    func centerOnParent() -> Array<NSLayoutConstraint> {
        return [
            centerYAnchor.constraint(equalTo: superview!.centerYAnchor),
            centerXAnchor.constraint(equalTo: superview!.centerXAnchor)
        ]
    }
    
    func getLayoutGuide(_ ignoreSaveArea : Bool = false) -> LayoutGuide { LayoutGuide.getFrom( ignoreSaveArea ? self.safeAreaLayoutGuide : self )!}
    
    func stretch(On view : UIView, ignoreSaveArea : Bool = false, angles : Array<ViewAngle>? = nil) -> Array<NSLayoutConstraint> {
        let sups = view.getLayoutGuide(ignoreSaveArea)
        var res = Array<NSLayoutConstraint>()
        if let angles = angles {
            angles.forEach { (angle) in
                switch angle{
                case .leading(let val):
                    res.append(self.leadingAnchor.constraint(
                                equalTo: sups.leadingAnchor,
                                constant: val ))
                case .top(let val):
                    res.append(self.topAnchor.constraint(
                                equalTo: sups.topAnchor,
                                constant: val ))
                case .bottom(let val):
                    res.append(self.bottomAnchor.constraint(
                                equalTo: sups.bottomAnchor,
                                constant: val ))
                case .trailing(let val):
                    res.append(self.trailingAnchor.constraint(
                                equalTo: sups.trailingAnchor,
                                constant: val ))
                }
            }
        } else {
            res.append(
                contentsOf: [
                    self.topAnchor.constraint(equalTo: sups.topAnchor),
                    self.leadingAnchor.constraint(equalTo: sups.leadingAnchor),
                    self.bottomAnchor.constraint(equalTo: sups.bottomAnchor),
                    self.trailingAnchor.constraint(equalTo: sups.trailingAnchor)
                ]
            )
        }
        return res
    }
    
    func stretchToParent(ignoreSaveArea : Bool = false, angles : Array<ViewAngle>? = nil) -> Array<NSLayoutConstraint> {
        let sups = superview!.getLayoutGuide(ignoreSaveArea)
        var res = Array<NSLayoutConstraint>()
        if let angles = angles {
            angles.forEach { (angle) in
                switch angle{
                case .leading(let val):
                    res.append(self.leadingAnchor.constraint(
                                equalTo: sups.leadingAnchor,
                                constant: val ))
                case .top(let val):
                    res.append(self.topAnchor.constraint(
                                equalTo: sups.topAnchor,
                                constant: val ))
                case .bottom(let val):
                    res.append(self.bottomAnchor.constraint(
                                equalTo: sups.bottomAnchor,
                                constant: val ))
                case .trailing(let val):
                    res.append(self.trailingAnchor.constraint(
                                equalTo: sups.trailingAnchor,
                                constant: val ))
                }
            }
        } else {
            res.append(
                contentsOf: [
                    self.topAnchor.constraint(equalTo: sups.topAnchor),
                    self.leadingAnchor.constraint(equalTo: sups.leadingAnchor),
                    self.bottomAnchor.constraint(equalTo: sups.bottomAnchor),
                    self.trailingAnchor.constraint(equalTo: sups.trailingAnchor)
                ]
            )
        }
        return res
    }
}

extension UIView {
    /// Returns a constraint based on the anchor you selected, value and parent of the current view
    func leadingAnchor(_ offsetFromSuperview : CGFloat = 0, ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: offsetFromSuperview)
        } else {
            return leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor, constant: offsetFromSuperview)
        }
    }
    /// Returns a constraint based on the anchor you selected, value and parent of the current view
    func trailingAnchor(_ offsetFromSuperview : CGFloat = 0, ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: offsetFromSuperview)
        }
        return trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor, constant: offsetFromSuperview)
        
    }
    /// Returns a constraint based on the anchor you selected, value and parent of the current view
    func topAnchor(_ offsetFromSuperview : CGFloat = 0, ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return topAnchor.constraint(equalTo: superview!.topAnchor, constant: offsetFromSuperview)
        }
        return topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor, constant: offsetFromSuperview)
    }
    /// Returns a constraint based on the anchor you selected, value and parent of the current view
    func bottomAnchor(_ offsetFromSuperview : CGFloat = 0, ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: offsetFromSuperview)
        }
        return bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor, constant: offsetFromSuperview)
    }
    
    /// Returns a constraint const which you set
    func heightAnchor(_ const : CGFloat = 0) -> NSLayoutConstraint{
        heightAnchor.constraint(equalToConstant: const)}
    /// Returns a constraint const which you set
    func widthAnchor(_ const : CGFloat = 0) -> NSLayoutConstraint{
        widthAnchor.constraint(equalToConstant: const)}
    /// Returns a constraint based on the angle you selected, value and parent of the current view
    func centerYAnchor(_ offsetFromSuperview : CGFloat = 0, ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return centerYAnchor.constraint(equalTo: superview!.centerYAnchor, constant: offsetFromSuperview)
        }
        return centerYAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.centerYAnchor, constant: offsetFromSuperview)
    }
    /// Returns a constraint based on the angle you selected, value and parent of the current view
    func centerXAnchor(_ offsetFromSuperview : CGFloat = 0,ignoreSaveArea : Bool = true) -> NSLayoutConstraint{
        if ignoreSaveArea {
            return centerXAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.centerXAnchor, constant: offsetFromSuperview)
        }
        return centerXAnchor.constraint(equalTo: superview!.centerXAnchor, constant: offsetFromSuperview)
        
    }
    
}


extension UIView {
    //// Compare as second operand
    func leadingAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutXAxisAnchor> { AxisAnchorC(anchor: leadingAnchor, const: const) }
    /// Compare as second operand
    func leadingAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutXAxisAnchor> { AxisAnchorM(anchor: leadingAnchor, mult: mult) }
    
    /// Compare as second operand
    func trailingAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutXAxisAnchor> { AxisAnchorC(anchor: trailingAnchor, const: const) }
    /// Compare as second operand
    func trailingAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutXAxisAnchor> { AxisAnchorM(anchor: trailingAnchor, mult: mult)}
    
    /// Compare as second operand
    func topAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutYAxisAnchor> { AxisAnchorC(anchor: topAnchor, const: const) }
    /// Compare as second operand
    func topAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutYAxisAnchor> { AxisAnchorM(anchor: topAnchor, mult: mult) }
    
    /// Compare as second operand
    func bottomAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutYAxisAnchor> { AxisAnchorC(anchor: bottomAnchor, const: const) }
    /// Compare as second operand
    func bottomAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutYAxisAnchor> { AxisAnchorM(anchor: bottomAnchor, mult: mult) }
    
    /// Compare as second operand
    func heightAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutDimension> { AxisAnchorC(anchor: heightAnchor, const: const) }
    /// Compare as second operand
    func heightAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutDimension> { AxisAnchorM(anchor: heightAnchor, mult: mult) }
    
    /// Compare as second operand
    func widthAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutDimension> { AxisAnchorC(anchor: widthAnchor, const: const) }
    /// Compare as second operand
    func widthAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutDimension> { AxisAnchorM(anchor: widthAnchor, mult: mult) }
    
    /// Compare as second operand
    func centerYAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutYAxisAnchor> { AxisAnchorC(anchor: centerYAnchor, const: const) }
    /// Compare as second operand
    func centerYAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutYAxisAnchor> { AxisAnchorM(anchor: centerYAnchor, mult: mult) }
    
    /// Compare as second operand
    func centerXAnchor(const : CGFloat) -> AxisAnchorC<NSLayoutXAxisAnchor> { AxisAnchorC(anchor: centerXAnchor, const: const) }
    /// Compare as second operand
    func centerXAnchor(mult : CGFloat) -> AxisAnchorM<NSLayoutXAxisAnchor> { AxisAnchorM(anchor: centerXAnchor, mult: mult) }
    
}

struct AxisAnchorC<T:AnyObject>{
    var anchor : NSLayoutAnchor<T>
    var const : CGFloat
}

struct AxisAnchorM<T:AnyObject>{
    var anchor : NSLayoutAnchor<T>
    var mult : CGFloat
}

protocol easyConstrain : class, Comparable{
    associatedtype Anchor =  Self where Anchor : AnyObject
    ///Returns constrain based on given anchors
    static func == (lhs: Self, rhs: Anchor) -> NSLayoutConstraint
    ///Returns constrain based on given anchors
    static func == (lhs: Self, rhs: AxisAnchorC<Anchor>) -> NSLayoutConstraint
    ///Returns constrain based on given anchors
    static func >= (lhs: Self, rhs: Anchor) -> NSLayoutConstraint
    ///Returns constrain based on given anchors
    static func >= (lhs: Self, rhs: AxisAnchorC<Anchor>) -> NSLayoutConstraint
    ///Returns constrain based on given anchors
    static func <= (lhs: Self, rhs: Anchor) -> NSLayoutConstraint
    ///Returns constrain based on given anchors
    static func <= (lhs: Self, rhs:  AxisAnchorC<Anchor>) -> NSLayoutConstraint
}

extension easyConstrain {
    public static func < (lhs: Self, rhs: Self) -> Bool { false }
    
    static func == (lhs: Self, rhs: Self) -> NSLayoutConstraint {
        return (lhs as! NSLayoutAnchor<Self>).constraint(equalTo: (rhs as! NSLayoutAnchor<Self>))
    }
    
    static func == (lhs: Self, rhs: AxisAnchorC<Self>) -> NSLayoutConstraint{
        return (lhs as! NSLayoutAnchor<Self>).constraint(equalTo: rhs.anchor,constant: rhs.const)
    }
    
    static func >= (lhs: Self, rhs: Self) -> NSLayoutConstraint {
        return (lhs as! NSLayoutAnchor<Self>).constraint(greaterThanOrEqualTo: rhs as! NSLayoutAnchor<Self>)
    }
    
    static func >= (lhs: Self, rhs: AxisAnchorC<Self>) -> NSLayoutConstraint {
        return (lhs as! NSLayoutAnchor<Self>).constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.const)
    }
    
    static func <= (lhs: Self, rhs: Self) -> NSLayoutConstraint {
        return (lhs as! NSLayoutAnchor<Self>).constraint(lessThanOrEqualTo: rhs as! NSLayoutAnchor<Self>)
    }
    static func <= (lhs: Self, rhs:  AxisAnchorC<Self>) -> NSLayoutConstraint {
        return (lhs as! NSLayoutAnchor<Self>).constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.const)
    }
}

extension NSLayoutXAxisAnchor : easyConstrain {}
extension NSLayoutYAxisAnchor : easyConstrain {}
extension NSLayoutDimension   : easyConstrain {
    public static func == (lhs: NSLayoutDimension, const : CGFloat) -> NSLayoutConstraint { lhs.constraint(equalToConstant: const) }
}
