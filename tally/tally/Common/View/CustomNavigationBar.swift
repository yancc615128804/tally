//
//  CustomNavigationBar.swift
//  tally
//
//  Created by 李志敬 on 2019/3/21.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {

     // MARK: - Property
    
    var backBtnBlock: CommonBlock?
    var titleLabel: UILabel?
    var backBtn: UIButton?
    
    private var _title: String = ""
    var title: String{
        set{
            _title = newValue
            self.titleLabel?.text = _title
        }
        get{
            return _title
        }
    }
    
     // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - SetupUI
    
    private func setupUI(frame: CGRect) -> Void {
        
        self.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationHeight)
        
        let titleLabel: UILabel = UILabel.init()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = "卡宝·记账"
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(kStatusBarHeight)
            make.width.equalTo(200)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
        self.titleLabel = titleLabel
        
        let backBtn = UIButton.init(type: UIButton.ButtonType.custom)
        backBtn.setImage(UIImage.init(named: "返回"), for: UIControl.State.normal)
        backBtn.addTarget(self, action: #selector(backBtnAction(aBtn:)), for: UIControl.Event.touchUpInside)
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.height.equalTo(20)
            make.centerY.equalTo(titleLabel)
        }
        self.backBtn = backBtn
        
        let bottomLine = UIView.init()
        bottomLine.backgroundColor = UIColor.init(red: 220 / 255.0, green: 220 / 255.0, blue: 220 / 255.0, alpha: 1.0)
        self.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        
    }
    
     // MARK: - Responder
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if point.x < 60 && point.y < kNavigationHeight {
            return self.backBtn
        }
        return super.hitTest(point, with: event)
    }
    
     // MARK: - Instance
    
    static func getInstance(title: String?) -> CustomNavigationBar{
        let bar = CustomNavigationBar.init(frame: CGRect.zero)
        bar.title = title ?? ""
        return bar
    }
    
    static func getInstance(title: String?, leftBtn:@escaping CommonBlock) -> CustomNavigationBar{
        let bar = getInstance(title: title)
        bar.backBtnBlock = leftBtn
        return bar
    }
    
     // MARK: - BtnActions
    
    @objc func backBtnAction(aBtn: UIButton) -> Void {
        self.backBtnBlock?()
    }
    
}
