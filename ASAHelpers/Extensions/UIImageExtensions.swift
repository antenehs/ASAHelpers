//
//  UIImageExtension.swift
//  ASAHelpers
//
//  Created by Anteneh Sahledengel on 5/1/17.
//  Copyright © 2017 Anteneh Sahledengel. All rights reserved.
//

import UIKit

extension UIImage {
    public func asa_resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func asa_resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return asa_resized(toSize: canvasSize)
    }
    
    public func asa_resized(toSize size: CGSize) -> UIImage? {
        let canvasSize = size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func asa_addMargin(withInsets inset: UIEdgeInsets) -> UIImage? {

        let finalSize = CGSize(width: size.width + inset.left + inset.right, height: size.height + inset.top + inset.bottom)
        let finalRect = CGRect(origin: CGPoint(x:0, y:0), size: finalSize)
        
        UIGraphicsBeginImageContextWithOptions(finalSize, false, scale)
        
        let ctx = UIGraphicsGetCurrentContext()
        UIColor.clear.setFill()
        ctx!.fill(finalRect)
        
        let pictureOrigin = CGPoint(x: inset.left, y: inset.top)
        let pictureRect = CGRect(origin: pictureOrigin, size: size)
        
        draw(in: pictureRect)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        
        defer { UIGraphicsEndImageContext() }
        
        return finalImage
    }
    
    public func asa_addMargin(withuniformInsetSize size: CGFloat) -> UIImage? {
        return asa_addMargin(withInsets: UIEdgeInsets(top: size, left: size, bottom: size, right: size))
    }
    
    public func asa_addCircleBackground(with color: UIColor, andImageSize size: CGSize, andInset inset: CGPoint, andOffset offset: CGPoint) -> UIImage {
        let rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let ctx: CGContext? = UIGraphicsGetCurrentContext()
        UIColor.clear.setFill()
        ctx?.fill(rect)
        
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: rect.size.width / 2)
        ctx?.setFillColor(color.cgColor)
        bezierPath.fill()
        bezierPath.addClip()
        
        var pictureRect: CGRect = rect.insetBy(dx: CGFloat(inset.x), dy: CGFloat(inset.y))
        pictureRect = pictureRect.offsetBy(dx: CGFloat(offset.x), dy: CGFloat(offset.y))
        
        draw(in: pictureRect)
        let finalImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }
    
    public func asa_imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func asa_imageWithSize(size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData = newImage!.pngData()
        guard let data = imageData else {return self}
        return UIImage(data: data)!
    }
    
    public func asa_imageWithImageOnTop(decalImage: UIImage) -> UIImage {
        let fullSize = CGSize(width: fmax(size.width, decalImage.size.width), height: fmax(size.height, decalImage.size.height))
        UIGraphicsBeginImageContextWithOptions(fullSize, false, scale)
        
        draw(at: CGPoint(x: floor((fullSize.width - size.width))/2, y: floor((fullSize.width - size.width))/2))
        decalImage.draw(at: CGPoint(x: floor((fullSize.width - decalImage.size.width))/2, y: floor((fullSize.width - decalImage.size.width))/2))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func asa_sizeOfAttributeString(str: NSAttributedString, maxWidth: CGFloat) -> CGSize {
        let size = str.boundingRect(with: CGSize(width: maxWidth, height: 1000), options:(NSStringDrawingOptions.usesLineFragmentOrigin), context:nil).size
        return size
    }
    
    public func asa_imageFromString(text: String, font: UIFont, maxWidth: CGFloat, color: UIColor) -> UIImage {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraph.alignment = .center // potentially this can be an input param too, but i guess in most use cases we want center align
        
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.paragraphStyle:paragraph])
        
        let size = asa_sizeOfAttributeString(str: attributedString, maxWidth: maxWidth)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        attributedString.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func asa_gradient(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: [1.0, 1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 1.0], locations: [0.0, 0.99], count: 2)
        
        context!.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: size.height), options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        let gradImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return gradImage!
    }
    
    public func asa_masked(with maskImage: UIImage) -> UIImage? {
        let imgRef = self.cgImage!
        let maskImageRef = maskImage.cgImage
        
        guard let maskRef = maskImageRef else { return nil}
        
        let actualMask = CGImage(maskWidth: maskRef.width,
                                 height: maskRef.height,
                                 bitsPerComponent: maskRef.bitsPerComponent,
                                 bitsPerPixel: maskRef.bitsPerPixel,
                                 bytesPerRow: maskRef.bytesPerRow,
                                 provider: maskRef.dataProvider!, decode: nil, shouldInterpolate: false)
        
        guard let masked = imgRef.masking(actualMask!) else { return nil }
        
        return UIImage(cgImage: masked, scale: scale, orientation: imageOrientation)
    }
    
    //Fixes image orientation. Can be used when the orientation of an image taken from the camera is rotated
    // http://stackoverflow.com/a/27775741/4166920
    public func asa_normalizedImage() -> UIImage {
        
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)
        
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    // drawing lines
    public class func asa_dottedLineImage(withFrame rect: CGRect, andColor fillColor: UIColor?) -> UIImage {
        let isVertical: Bool = rect.size.width < rect.size.height
        
        let rectHeight: CGFloat = rect.size.height
        let rectWidth: CGFloat = rect.size.width
        
        let lineThickness: CGFloat = isVertical ? rectWidth : rectHeight
        
        let startPoint = CGPoint(x: CGFloat(lineThickness / (isVertical ? 2 : 1)), y: CGFloat(lineThickness / (isVertical ? 1 : 2)))
        let endPoint = CGPoint(x: CGFloat(rectWidth / (isVertical ? 2 : 1)), y: CGFloat(rectHeight / (isVertical ? 1 : 2)))
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineThickness
        
        let dashes: [CGFloat] = [path.lineWidth * 0, path.lineWidth * 2]
        path.setLineDash(dashes, count: 2, phase: 0)
        
        path.lineCapStyle = CGLineCap.round
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rectWidth, height: rectHeight), false, 2)
        if let color = fillColor {
            color.setStroke()
        }
        
        path.stroke()
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public class func asa_dashedLineImage(withFrame rect: CGRect, andColor fillColor: UIColor?) -> UIImage {
        let isVertical: Bool = rect.size.width < rect.size.height
        
        let rectHeight: CGFloat = rect.size.height
        let rectWidth: CGFloat = rect.size.width
        
        let lineThickness: CGFloat = isVertical ? rectWidth : rectHeight
        
        let startPoint = CGPoint(x: CGFloat(lineThickness / (isVertical ? 2 : 1)), y: CGFloat(lineThickness / (isVertical ? 1 : 2)))
        let endPoint = CGPoint(x: CGFloat(rectWidth / (isVertical ? 2 : 1)), y: CGFloat(rectHeight / (isVertical ? 1 : 2)))
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineThickness
        
        let dashes: [CGFloat] = [path.lineWidth, path.lineWidth * 2]
        path.setLineDash(dashes, count: 2, phase: 0)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rectWidth, height: rectHeight), false, 2)
        if let color = fillColor {
            color.setStroke()
        }
        
        path.stroke()
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func asa_dashedRoundedLineImage(withFrame rect: CGRect, andColor fillColor: UIColor?) -> UIImage {
        let isVertical: Bool = rect.size.width < rect.size.height
        
        let rectHeight: CGFloat = rect.size.height
        let rectWidth: CGFloat = rect.size.width
        
        let lineThickness: CGFloat = isVertical ? rectWidth : rectHeight
        
        let startPoint = CGPoint(x: CGFloat(lineThickness / (isVertical ? 2 : 1)), y: CGFloat(lineThickness / (isVertical ? 1 : 2)))
        let endPoint = CGPoint(x: CGFloat(rectWidth / (isVertical ? 2 : 1)), y: CGFloat(rectHeight / (isVertical ? 1 : 2)))
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineThickness
        
        let dashes: [CGFloat] = [path.lineWidth, path.lineWidth * 2]
        path.setLineDash(dashes, count: 2, phase: 0)
        path.lineCapStyle = .round
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: rectWidth, height: rectHeight), false, 2)
        if let color = fillColor {
            color.setStroke()
        }
        
        path.stroke()
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
