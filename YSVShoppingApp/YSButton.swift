import UIKit
class YSButton: UIButton {
    var hue: CGFloat {
        get {
            return self.hue
            // TODO: add getter implementation
        }
        set(hue) {
            self.hue = hue
            self.setNeedsDisplay()
        }
    }
    var saturation: CGFloat {
        get {
            return self.saturation
            // TODO: add getter implementation
        }
        set(saturation) {
            self.saturation = saturation
            self.setNeedsDisplay()
        }
    }
    
    
    var brightness: CGFloat {
        get {
            return self.brightness
            // TODO: add getter implementation
        }
        set(brightness) {
            self.brightness = brightness
            self.setNeedsDisplay()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
     
        
            self.isOpaque = false
            self.backgroundColor = UIColor.clear
            self.hue = 0.5
            self.saturation = 0.5
            self.brightness = 0.5
        
    }
    

    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: 1.0)
        context.setFillColor(color.cgColor)
        context.fill(self.bounds)
    }
}
