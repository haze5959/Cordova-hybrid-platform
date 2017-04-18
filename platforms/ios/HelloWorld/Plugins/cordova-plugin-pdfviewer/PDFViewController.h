//
//  PDFViewController.h
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 17..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFViewController : UIViewController <UIScrollViewDelegate>
    
@property (strong, nonatomic) id delegate;
@property NSString *filePath;
+ (PDFViewController *)viewController;
    
@end

@protocol PDFViewerDelegate <NSObject>

@optional
// 선택완료.
- (void) closePlugin:(NSString *)temp;
@end
