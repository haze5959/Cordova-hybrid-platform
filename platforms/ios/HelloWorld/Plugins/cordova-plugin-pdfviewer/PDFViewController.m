//
//  PDFViewController.m
//  bizMOB3_OQ_Project
//
//  Created by 권오규 on 2017. 3. 17..
//  Copyright © 2017년 MOBILE C&C. All rights reserved.
//

#import "PDFViewController.h"
#import "PDFView.h"

@interface PDFViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property PDFView *pdfView;

@property NSMutableArray* pagePos;
@property int currentPageNum;

@end

@implementation PDFViewController

- (void)viewDidLoad {
    //스크롤 드레그 감속도 조절
    [self.scrollView setDecelerationRate:0];
    //PDF뷰가 그려질 뷰 생성
    self.pdfView = [PDFView alloc];
    self.pdfView.delegate = self;
    //화면에 나타날 페이지
    self.currentPageNum = 1;
    //PDF 파일 경로
    const char *fileName = [self.filePath UTF8String];
    
    CFStringRef path;
    CFURLRef url;
    size_t count;
    
    //PDF 관련 네이티브 라이브러리를 이용하기 위해 CF라이브러리의 스트링으로 바꿔줘야한다
    path = CFStringCreateWithCString (NULL, fileName, kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    CGPDFDocumentRef document = CGPDFDocumentCreateWithURL (url);
    self.pdfView.document = document;
    CFRelease(url);
    
    //총 페이지 수 반환
    count = CGPDFDocumentGetNumberOfPages (document);
    self.pdfView.pageCount = count;
    //전체 페이지 수의 높이를 합산
    float allPDFHeight = -PAGE_INTERVAL * 2;
    if (count == 0) {
        NSLog(@"`%s' 적어도 한 페이지는 필요합니다.", fileName);
    }else{
        //PDF전체 페이지에서 각각의 페이지의 레퍼런스를 넣을 배열
        self.pdfView.pageRefArr = [[NSMutableArray alloc]init];
        //페이지를 넘기기를 할 때 각 페이지의 위치를 넣을 배열
        self.pagePos = [[NSMutableArray alloc]init];
        
        //각각의 페이지의 높이를 계산하여 전체 페이지의 높이를 구한다.
        for (int i = 1; i <= count; i++) {
            CGPDFPageRef page = CGPDFDocumentGetPage (document, i);
            [self.pdfView.pageRefArr addObject:(__bridge id _Nonnull)(page)];
            
            //각각의 페이지의 높이를 구하는 로직
            CGRect mediaRect = CGPDFPageGetBoxRect (page, kCGPDFMediaBox);
            float realHeightSize = mediaRect.size.height * (self.scrollView.frame.size.width / mediaRect.size.width);
            allPDFHeight += (realHeightSize + PAGE_INTERVAL);
            NSNumber *pageSpot = [NSNumber numberWithFloat:(allPDFHeight - PAGE_INTERVAL)];
            [self.pagePos addObject:pageSpot];
        }
    }
    //PDF뷰어의 높이만 큼 스크롤 할 수 있게
    [self setScrollwidth:self.scrollView.frame.size.width height:allPDFHeight];
    self.pdfView = [self.pdfView initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, allPDFHeight)];
    //PDF뷰어의 백그라운드 색상
    [self.pdfView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.scrollView addSubview:self.pdfView];
    //현제 몇 페이지를 보고 있나 보여줄 라벨
    self.pageLabel.text = [NSString stringWithFormat:@"page %d/%lu",1, (unsigned long)self.pagePos.count];
    [super viewDidLoad];
}

#pragma mark - 생성자
+ (PDFViewController *)viewController {
    
    PDFViewController *viewController = [[PDFViewController alloc]
                                         initWithNibName:@"PDFViewController"
                                         bundle:nil];
    return viewController;
}

#pragma mark - PDF레퍼런스를 만들어주고 페이지 수 계산, 크기 계산 해주는 것

#pragma mark - 스크롤뷰 딜리게이트
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.pdfView;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    for (int i = 0; i < self.pagePos.count; i++) {
        if(scrollView.contentOffset.y < ([[self.pagePos objectAtIndex:i]floatValue] - 100)){
            self.currentPageNum = (i + 1);
            self.pageLabel.text = [NSString stringWithFormat:@"page %d/%lu",self.currentPageNum ,(unsigned long)self.pagePos.count];
            break;
        }
    }
    
    if (scrollView.contentOffset.y >= scrollView.contentSize.height) {
        self.currentPageNum = self.pagePos.count;
        self.pageLabel.text = [NSString stringWithFormat:@"page %d/%lu",self.currentPageNum ,(unsigned long)self.pagePos.count];
    }
}

#pragma mark - 스크롤뷰 컨텐츠 높이 조절
-(void)setScrollwidth:(float)width height:(float)height{
    self.scrollView.contentSize = CGSizeMake(width, height);
    
}

#pragma mark - Cancel 버튼
- (IBAction)touchCancel:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate closePlugin:@"test"];
}

#pragma mark - 페이지 좌 우 넘기기 버튼
- (IBAction)rightBtn:(id)sender {
    if(self.currentPageNum != self.pagePos.count){
        self.scrollView.zoomScale = 1.0f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, [self.pagePos[self.currentPageNum - 1] floatValue]);
        self.currentPageNum += 1;
        self.pageLabel.text = [NSString stringWithFormat:@"page %d/%lu",self.currentPageNum ,(unsigned long)self.pagePos.count];
    }
}

- (IBAction)leftBtn:(id)sender {
    if(self.currentPageNum != 1){
        self.scrollView.zoomScale = 1.0f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, [self.pagePos[self.currentPageNum - 2] floatValue] + ([self.pagePos[self.currentPageNum - 2] floatValue] - [self.pagePos[self.currentPageNum - 1] floatValue]));
        self.currentPageNum -= 1;
        self.pageLabel.text = [NSString stringWithFormat:@"page %d/%lu",self.currentPageNum ,(unsigned long)self.pagePos.count];
    }
}

@end
