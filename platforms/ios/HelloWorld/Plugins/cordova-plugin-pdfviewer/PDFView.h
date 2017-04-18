//
//  PDFView.h
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 17..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//
#define PAGE_INTERVAL 20
#import <UIKit/UIKit.h>
#import "PDFViewController.h"

@interface PDFView : UIView
@property (strong, nonatomic) id delegate;
@property CGPDFDocumentRef document;
@property size_t pageCount;
@property NSMutableArray* pageRefArr;
@end

@protocol PDFViewControllerDelegate <NSObject>

@optional
// 선택완료.
-(void)setScrollwidth:(float)width height:(float)height;
@end
