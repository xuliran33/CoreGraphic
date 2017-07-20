//
//  SimpleBezierPath.swift
//  UIbezierPath
//
//  Created by 徐丽然 on 2017/7/17.
//  Copyright © 2017年 xuliran. All rights reserved.
//

import UIKit
import QuartzCore

let pi:Float = 3.1415
func degress_to_radians(degree: Float) -> Float {
    return pi * degree / 180.0
}
class SimpleBezierPathView: UIView {
    
    override func awakeFromNib() {
        // 横竖屏配置, 在xib情况下可能有用, 不过没有验证
        self.contentMode = .redraw
    }
    
    override func draw(_ rect: CGRect) {
//        self.drawSqur()
//        self.drawSquarLine()
//        self.drawOval()
//        self.drawpolygon()
//        self.draw1()
//        self.draw2()
//        self.draw3()
//        self.draw4()
        self.draw5()
        self.backgroundColor = UIColor.white
        self.drawRadialGradienwithRect(rect: CGRect(x: 120, y: 510, width: 60, height: 60))
        self.drawingLinearGradient(startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 50, y: 50))
    }
    
    /**
     * CoreGraphics绘制--线性渐变
     */
    func drawingLinearGradient(startPoint: CGPoint, endPoint: CGPoint) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientColors = [UIColor.white.cgColor, UIColor.lightGray.cgColor,UIColor.purple.cgColor]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: [0,0.5,1])
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        context?.restoreGState()
    }
    
    /**
     * CoreGraphic绘制--渐变色
     */
    func drawRadialGradienwithRect(rect: CGRect) {
        // 色彩范围的容器
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientColors = [UIColor.white.cgColor, UIColor.black.cgColor]
        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: [0.5, 0.95,1])
        let startCenter = CGPoint(x: rect.midX, y: rect.midY)
        let radius = max(rect.height, rect.width)
        context?.drawRadialGradient(gradient!, startCenter: startCenter, startRadius: 0, endCenter: startCenter, endRadius: radius, options: .drawsBeforeStartLocation)
    }
    /**
     * CoreGraphics绘图--矩形
     */
    func draw5() {
        // 获取画布
        let ctx = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: 80, y: 400, width: 160, height: 60)
        let color = UIColor.lightGray.cgColor
        ctx?.setFillColor(color)
        ctx?.fill(rectangle)
        self.draw6(x: 160, y: 230, ctx: ctx!)
        self.draw7(x: 60, y: 160)
        self.draw7(x: 200, y: 160)
        self.drawTriangle()
        self.drawQuadCurve()
        self.drawQuadCurve2()
    }
    /**
     * CoreGraphic绘制--弧线2
     */
    func drawQuadCurve2() {
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.move(to: CGPoint(x: 170, y: 170))
        ctx?.addCurve(to: CGPoint(x: 160, y: 290), control1: CGPoint(x: 160, y: 250), control2: CGPoint(x: 230, y: 250))
        ctx?.setLineWidth(10)
        ctx?.setStrokeColor(UIColor.brown.cgColor)
        ctx?.strokePath()
        
    }
    
    /**
     * CoreGraphics绘制--弧线1
     */
    func drawQuadCurve() {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.move(to: CGPoint(x: 50, y: 130))
        ctx?.addQuadCurve(to: CGPoint(x: 25, y: 170), control: CGPoint(x: 0, y: 100))
        
        ctx?.move(to: CGPoint(x: 270, y: 130))
        
        ctx?.addQuadCurve(to: CGPoint(x: 295, y: 170), control: CGPoint(x: 320, y: 100))
        ctx?.setLineWidth(10)
        ctx?.setStrokeColor(UIColor.brown.cgColor)
        
//        ctx?.setShadow(offset: CGSize(width: 0, height: 0), blur: 0)
        ctx?.strokePath()
    }
    /**
     * Coregraphics绘制多边形
     */
    func drawTriangle() {
        let ctx = UIGraphicsGetCurrentContext()
//        ctx?.beginPath()
        ctx?.addLines(between: [CGPoint(x: CGFloat(160), y: CGFloat(40)), CGPoint(x: CGFloat(190), y: CGFloat(80)), CGPoint(x: CGFloat(130), y: CGFloat(80))])
//        ctx?.move(to: CGPoint(x: CGFloat(160), y: CGFloat(40)))
//        ctx?.move(to: CGPoint(x: CGFloat(190), y: CGFloat(80)))
//        ctx?.move(to: CGPoint(x: CGFloat(130), y: CGFloat(80)))
//        ctx?.closePath()
//        print("==========%@", ctx)
        ctx?.setFillColor(UIColor.black.cgColor)
        ctx?.fillPath()
    }
    /**
     * coreGraphic绘制--圆
     */
    func draw6(x: CGFloat, y: CGFloat, ctx: CGContext) {
//        let ctx = UIGraphicsGetCurrentContext()
        
        ctx.addArc(center: CGPoint(x: x, y: y), radius: 150, startAngle: 0, endAngle: (CGFloat)(2 * M_PI), clockwise: true)
        
        ctx.setShadow(offset: CGSize(width: 10, height: 10), blur: 20.0, color: UIColor.gray.cgColor)
        ctx.setFillColor(UIColor.yellow.cgColor)
        ctx.fillPath()
        
    }
    
    /**
     * coreGraphic绘制--椭圆
     */
    func draw7(x: CGFloat, y: CGFloat) {
        let ctx = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: x, y: y, width: 60, height: 30);
        ctx?.addEllipse(in: rectangle)
        ctx?.setFillColor(UIColor.green.cgColor)
        ctx?.fillPath()
        
    }
    
    /**
     * 曲线组合
     */
    func draw4() {
        let size = self.bounds.size
        // 边距
        let margin: CGFloat = 10
        // 半径
        let radius = rintf(Float(min(size.height - margin, size.width - margin)) / 4)
        var xOfset: CGFloat, yOfset: CGFloat
        
        let offset = rintf(Float(size.height - size.width) / 2)
        if (offset > 0) {
            // 长 > 宽
            xOfset = CGFloat(rintf(Float(margin / 2)))
            yOfset = CGFloat(offset)
        }else {
            // 宽 > 长
            xOfset = -(CGFloat)(offset)
            yOfset = CGFloat(rintf(Float(margin / 2)))
        }
        
        UIColor.green.setFill()
        
        let aPath = UIBezierPath()
        
        aPath.addArc(withCenter: CGPoint(x: (CGFloat(radius * 2) + xOfset), y: (CGFloat(radius) + yOfset)), radius: CGFloat(radius), startAngle: -(CGFloat)(M_PI), endAngle: 0, clockwise: true)
        aPath.addArc(withCenter: CGPoint(x: (CGFloat(radius * 3) + xOfset), y: (CGFloat(radius * 2) + yOfset)), radius: CGFloat(radius), startAngle: -(CGFloat)(M_PI / 2), endAngle: (CGFloat)(M_PI / 2), clockwise: true)
        
        aPath.addArc(withCenter: CGPoint(x: xOfset + CGFloat(2 * radius), y: yOfset + CGFloat(3 * radius)), radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        aPath.addArc(withCenter: CGPoint(x: xOfset + CGFloat(radius), y: yOfset + CGFloat(2 * radius)), radius: CGFloat(radius), startAngle: (CGFloat)(M_PI / 2), endAngle: -(CGFloat)(M_PI / 2), clockwise: true)
        aPath.close()
        aPath.fill()
    }
    
    /**
     * 绘制第二种贝塞尔曲线
     */
    func draw3() {
        let color = UIColor.green
        color.set()
        
        let aPath = UIBezierPath()
        
        aPath.lineWidth = 5.0
        aPath.lineJoinStyle = .round
        aPath.lineCapStyle = .round
        
        aPath.move(to: CGPoint(x: 5, y: 80))
        aPath.addCurve(to: CGPoint(x: 155, y: 80), controlPoint1: CGPoint(x: 80, y: 0), controlPoint2: CGPoint(x: 110, y: 100))
        
        aPath.stroke()
    }
    
    /**
     * 绘制第一种贝塞尔曲线
     */
    func draw2() {
        let color = UIColor.green
        color.set()
        
        let aPath = UIBezierPath()
        
        aPath.lineWidth = 5.0
        aPath.lineCapStyle = .round
        aPath.lineJoinStyle = .round
        aPath.move(to: CGPoint(x: 20, y: 100))
        aPath.addQuadCurve(to: CGPoint(x: 120, y: 100), controlPoint: CGPoint(x: 70, y: 0))
        aPath.stroke()
    }
    
    /**
     * 绘制一段弧度
     */
    func draw1() {
        let color = UIColor.green
        color.set()
        
        let aPath = UIBezierPath(arcCenter: CGPoint(x: 80, y: 80), radius: 75, startAngle: 0, endAngle: CGFloat(degress_to_radians(degree: 135)), clockwise: true)
        aPath.lineWidth = 5.0
        aPath.lineCapStyle = .round
        aPath.lineJoinStyle = .round
//        aPath.close()
        aPath.stroke()
//        aPath.fill()
    }
    
    /**
     * 绘制多边形
     */
    func drawpolygon() {
        let color = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1);
        color.set()
        let aPath = UIBezierPath()
        aPath.lineWidth = 5.0
        aPath.lineCapStyle = .round
        aPath.lineJoinStyle = .round
        aPath.move(to: CGPoint(x: 100.0, y: 0.0))
        aPath.addLine(to: CGPoint(x: 200.0, y: 40.0))
        aPath.addLine(to: CGPoint(x: 160, y: 140))
        aPath.addLine(to: CGPoint(x: 40.0, y: 140))
        aPath.addLine(to: CGPoint(x: 0.0, y: 40.0))
        aPath.close()
        aPath.stroke()
        // 填充
        aPath.fill()
    }
    
    /**
     * 绘制矩形
     */
    func drawSqur() {
        UIColor.green.setFill()
        UIRectFill(CGRect(x: 20, y: 20, width: 100, height: 50))
        
    }
    
    /**
     * 绘制矩形框
     */
    func drawSquarLine() {
        let color = UIColor.green
        color.set()
        let aPath = UIBezierPath(rect: CGRect(x: 20, y: 20, width: 100, height: 50))
        aPath.lineWidth = 8.0
        // 设置线条拐角为圆角
        aPath.lineCapStyle = .round
        // 终点处理
        aPath.lineJoinStyle = .round
        aPath.stroke()

    }
    /**
     * 绘制圆或椭圆
     */
    func drawOval() {
        let color = UIColor.green
        color.set()
        // 椭圆
//        let aPath = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 100, height: 50))
        // 圆
        let aPath = UIBezierPath(ovalIn: CGRect(x: 20, y: 20, width: 100, height: 100))
        aPath.lineWidth = 8.0
        // 设置线条拐角为圆角
        aPath.lineCapStyle = .round
        // 终点处理
        aPath.lineJoinStyle = .round
        aPath.stroke()
    }

}
