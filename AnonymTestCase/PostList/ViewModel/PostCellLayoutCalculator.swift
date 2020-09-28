//
//  PostCellLayoutCalculator.swift
//  AnonymTestCase
//
//  Created by Anya on 25.09.2020.
//  Copyright © 2020 Anna Vondrukhova. All rights reserved.
//

import Foundation
import UIKit

class PostCellLayoutCalculator {
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, postImage: Image?, tags: String?) -> Sizes {
        
        let backgroundViewWidth = screenWidth

        //setting postTextFrame
        
        var postTextFrame = CGRect(origin: CGPoint(x: Constants.inset, y: Constants.postTextLabelTop),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = backgroundViewWidth - Constants.inset*2
            var height = text.height(width: width, font: Constants.postTextLabelFont)
            
            let limitedHeight = Constants.postTextLabelFont.lineHeight * Constants.postTextLinesLimit
            
            if height > limitedHeight {
                height = limitedHeight
            }
            
            postTextFrame.size = CGSize(width: width, height: height)
        }
        
        //setting postImageFrame
        
        let imageTop = postTextFrame.size == CGSize.zero ? Constants.postTextLabelTop : postTextFrame.maxY+Constants.inset
        
        var imageFrame = CGRect(origin: CGPoint(x: Constants.inset, y: imageTop),
                                     size: CGSize.zero)
        
        if let image = postImage {
            let imageHeight = image.size.height
            let imageWidth = image.size.width
            let ratio = imageHeight/imageWidth
            
            let imageAdaptedWidth = backgroundViewWidth - Constants.inset*2
            let imageAdaptedHeight = imageAdaptedWidth*ratio
            imageFrame.size = CGSize(width: imageAdaptedWidth, height: imageAdaptedHeight)
        }
        
        //setting tagsTextFrame
        let tagsTextTop = max(Constants.postTextLabelTop, postTextFrame.maxY+Constants.inset, imageFrame.maxY+Constants.inset)
        
        var tagsTextFrame = CGRect(origin: CGPoint(x: Constants.inset, y: tagsTextTop),
        size: CGSize.zero)
        
        if let tagsText = tags, !tagsText.isEmpty {
            
            let width = backgroundViewWidth - Constants.inset*2
            var height = tagsText.height(width: width, font: Constants.tagsLabelFont)
            
            let limitedHeight = Constants.tagsLabelFont.lineHeight * Constants.tagsLinesLimit
            
            if height > limitedHeight {
                height = limitedHeight
            }
            
            tagsTextFrame.size = CGSize(width: width, height: height)
        }
        
        //setting statsViewFrame
        let statsViewTop = max(postTextFrame.maxY, imageFrame.maxY, tagsTextFrame.maxY) + Constants.inset
        
        let statsViewFrame = CGRect(origin: CGPoint(x: Constants.statsViewHeight, y: statsViewTop),
                                     size: CGSize(width: backgroundViewWidth - Constants.inset*2, height: Constants.statsViewHeight))
        
        
        
        //setting totalHeight
        let totalHeight = statsViewFrame.maxY + Constants.inset
                
        return Sizes(postTextFrame: postTextFrame,
                     postImageFrame: imageFrame,
                     tagsTextFrame: tagsTextFrame,
                     statsViewFrame: statsViewFrame,
                     totalHeight: totalHeight)
        
    }
}
