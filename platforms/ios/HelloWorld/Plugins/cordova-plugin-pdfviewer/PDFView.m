//
//  PDFView.m
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 17..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();

    //페이지를 그린다
    for (int i = 0; i < self.pageCount; i++) {
        CGPDFPageRef page = (__bridge CGPDFPageRef)(self.pageRefArr[i]);
        MyDrawPDFPageInRect(context, page, kCGPDFMediaBox, rect, (i + 1));
    }
    
    CGPDFDocumentRelease (self.document);
}

#pragma mark - PDF 페이지 그리는 로직
void MyDrawPDFPageInRect (CGContextRef context,
                          CGPDFPageRef page,
                          CGPDFBox box,
                          CGRect rect,
                          int pageNum)
{
    CGContextSaveGState (context);// 2
    CGRect mediaRect = CGPDFPageGetBoxRect (page, box);
    CGContextScaleCTM(context, (rect.size.width / mediaRect.size.width), (rect.size.width / mediaRect.size.width));
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -mediaRect.origin.x, -mediaRect.origin.y);
    
    CGContextTranslateCTM(context, 0, (mediaRect.size.height + PAGE_INTERVAL) * -pageNum);  //페이지 간의 간격을 합산하여 옮긴다.
    CGContextTranslateCTM(context, 0, PAGE_INTERVAL); //맨 위의 간격도 있기 때문에 전체적으로 올린 것
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetRenderingIntent(context, kCGRenderingIntentDefault);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, mediaRect);
    CGContextDrawPDFPage (context, page);
    
    CGContextRestoreGState (context);
}


@end
