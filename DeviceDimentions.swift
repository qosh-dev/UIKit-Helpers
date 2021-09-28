//
//  DeviceDimentions.swift
import Foundation
import UIKit

class Device {
    static let IpodTouch7 = CGSize(width: 320, height: 568)
    static let IphoneSE = CGSize(width: 320, height: 667)
    static let Iphone7 = CGSize(width: 375, height: 667)
    static let Iphone8 = CGSize(width: 375, height: 667)
    static let Iphone8Plus = CGSize(width: 414, height: 736)
    static let Iphone11 = CGSize(width: 414, height: 896)
    static let Iphone11Pro = CGSize(width: 375, height: 812)
    static let Iphone11ProMax = CGSize(width: 414, height: 896)
    static let Iphone12 = CGSize(width: 390, height: 844)
    static let Iphone12PRO = CGSize(width: 320, height: 667)
    static let Iphone12ProMax = CGSize(width: 926, height: 428)
    static let Iphone12Mini = CGSize(width: 375, height: 812)
    
    static let isMediumScreen = Device.isIphone8 || Device.isIphone8Plus
    static let isMedium2Screen =  Device.isIphoneSE || isIphone7
    static let isLargestScreen = Device.isIphone12Mini || Device.isIphone11 || Device.isIphone11ProMax || Device.isIphone12ProMax
    static let isLargeScreen = Device.isIphone11Pro || Device.isIphone12 || Device.isIphone12PRO
    
    static let isLargeScreen2  =  Device.isIphone11 || Device.isIphone11Pro || Device.isIphone11ProMax || Device.isIphone12PRO || Device.isIphone12ProMax
    
    static let isIpodTouch7     = deviceIs(IpodTouch7)
    static let isIphoneSE       = deviceIs(IphoneSE)
    static let isIphone7        = deviceIs(Iphone7)
    static let isIphone8        = deviceIs(Iphone8)
    static let isIphone8Plus    = deviceIs(Iphone8Plus)
    static let isIphone11       = deviceIs(Iphone11)
    static let isIphone11Pro    = deviceIs(Iphone11Pro)
    static let isIphone11ProMax = deviceIs(Iphone11ProMax)
    static let isIphone12       = deviceIs(Iphone12)
    static let isIphone12PRO    = deviceIs(Iphone12PRO)
    static let isIphone12ProMax = deviceIs(Iphone12ProMax)
    static let isIphone12Mini   = deviceIs(Iphone12Mini)
    
    static func deviceIs(_ size : CGSize) -> Bool {
        UIScreen.main.bounds.size == size || UIScreen.main.bounds.size == .init(width: size.height, height: size.width)
    }
    
    enum Dimention {
        var bool : Bool {
            switch self {
            case .IpodTouch7: return deviceIs(Device.IpodTouch7)
            case .IphoneSE: return deviceIs(Device.IphoneSE)
            case .Iphone7: return deviceIs(Device.Iphone7)
            case .Iphone8: return deviceIs(Device.Iphone8)
            case .Iphone8Plus: return deviceIs(Device.Iphone8Plus)
            case .Iphone11: return deviceIs(Device.Iphone11)
            case .Iphone11Pro: return deviceIs(Device.Iphone11Pro)
            case .Iphone11ProMax: return deviceIs(Device.Iphone11ProMax)
            case .Iphone12: return deviceIs(Device.Iphone12)
            case .Iphone12PRO: return deviceIs(Device.Iphone12PRO)
            case .Iphone12ProMax: return deviceIs(Device.Iphone12ProMax)
            case .Iphone12Mini: return deviceIs(Device.Iphone12Mini)
            case .MediumScreen: return deviceIs(Device.Iphone8) || deviceIs(Device.Iphone8Plus)
            case .Medium2Screen: return deviceIs(Device.IphoneSE) || deviceIs(Device.Iphone7)
            case .LargestScreen: return deviceIs(Device.Iphone12Mini) || deviceIs(Device.Iphone11) || deviceIs(Device.Iphone11ProMax) || deviceIs(Device.Iphone12ProMax)
            case .LargeScreen: return deviceIs(Device.Iphone11Pro) || deviceIs(Device.Iphone12) || deviceIs(Device.Iphone12PRO)
            case .other : return false
            }
        }
        case IpodTouch7
        case IphoneSE
        case Iphone7
        case Iphone8
        case Iphone8Plus
        case Iphone11
        case Iphone11Pro
        case Iphone11ProMax
        case Iphone12
        case Iphone12PRO
        case Iphone12ProMax
        case Iphone12Mini
        case MediumScreen
        case Medium2Screen
        case LargestScreen
        case LargeScreen
        case other
        
    }
}

extension UIViewController{
    var backBtnTopOffset : CGFloat {
        let res = Device.isLargestScreen || Device.isLargeScreen ?
            traitCollection.verticalSizeClass == .compact ?
                UIApplication.shared.windows[0].safeAreaInsets.top + 15 :
                UIApplication.shared.windows[0].safeAreaInsets.top  :
            30
        return res
    }
}
