//
//  WBErrorNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBErrorNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"
#import "WBRedGradientView.h"

@interface WBErrorNoticeView ()
@property (nonatomic) UIWindow* window;
@end

@implementation WBErrorNoticeView

+ (WBErrorNoticeView *)errorNoticeInViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message
{    
    WBErrorNoticeView* notice = [[WBErrorNoticeView alloc] initWithViewController:viewController title:title];
    notice.message = message;
    notice.sticky = NO;
    
    return notice;
}

- (void)show
{
    CGRect f = [[UIScreen mainScreen] bounds];
    f.origin.y = f.size.height - 100;
    f.size.height = 100;
    
    self.window = [[UIWindow alloc] initWithFrame:f];
    self.window.backgroundColor = [UIColor clearColor];
    _window.clipsToBounds = NO;
    
    UIViewController* vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor clearColor];
    vc.view.clipsToBounds = NO;
    
    _window.rootViewController = vc;
    _window.windowLevel = UIWindowLevelStatusBar;
    [_window makeKeyAndVisible];
    _window.hidden = NO;
    
    self.alpha = 0.9;
    
    // Obtain the screen width
    CGFloat viewWidth = self.view.bounds.size.width;
    
    // Locate the images
    NSString *path = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"NoticeView.bundle"];
    NSString *noticeIconImageName = [path stringByAppendingPathComponent:@"notice_error_icon.png"];
    
    // Make and add the title label
    float titleYOrigin = 10.0;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55.0, titleYOrigin, viewWidth - 70.0, 16.0)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = self.title;
    self.titleLabel.alpha = 0;
    
    // Make the message label
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.messageLabel.font = [UIFont systemFontOfSize:15.0];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.textColor = [UIColor whiteColor];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel.text = self.message;
    
    // Calculate the number of lines it'll take to display the text
    NSInteger numberOfLines = [[self.messageLabel lines]count];
    self.messageLabel.numberOfLines = numberOfLines;
    CGFloat messageLabelHeight = self.messageLabel.frame.size.height;
    
    CGRect r = self.messageLabel.frame;
    r.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height;
    
    float noticeViewHeight = 0.0;
    double currOsVersion = [[[UIDevice currentDevice]systemVersion]doubleValue];
    
    if (currOsVersion >= 6.0f)
    {
//        noticeViewHeight = messageLabelHeight;
    }
    else
    {
        // Now we can determine the height of one line of text
        r.size.height = self.messageLabel.frame.size.height * numberOfLines;
        r.size.width = viewWidth - 70.0;
//        self.messageLabel.frame = r;
        
        // Calculate the notice view height
        noticeViewHeight = 10.0;
        if (numberOfLines > 1) {
            noticeViewHeight += ((numberOfLines - 1) * messageLabelHeight);
        }
    }
    
    // Add some bottom margin for the notice view
    noticeViewHeight += 30.0;
    
    // Make sure we hide completely the view, including its shadow
//    float hiddenYOrigin = self.slidingMode == WBNoticeViewSlidingModeDown ? -noticeViewHeight - 20.0: self.view.bounds.size.height;
    
    // Make and add the notice view
    self.gradientView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0f, viewWidth-20, noticeViewHeight + 10.0)];
    
    self.gradientView.backgroundColor = (self.color)?self.color:[UIColor colorWithRed:225.0f/255.0f green:98.0f/255.0f blue:89.0f/255.0f alpha:1];
    
    self.gradientView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.gradientView.layer.shadowRadius = 5.0f;
    self.gradientView.layer.shadowOpacity = 0.8;
    self.gradientView.layer.shadowOffset = CGSizeMake(2, 2);
    self.gradientView.alpha = 0.0f;
    [vc.view addSubview:self.gradientView];
    
    self.messageLabel.frame = self.gradientView.bounds;
    
    // Make and add the icon view
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 10.0, 20.0, 30.0)];
    iconView.image = [UIImage imageWithContentsOfFile:noticeIconImageName];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.alpha = 0;
    [self.gradientView addSubview:iconView];
    
    // Add the title label
    [self.gradientView addSubview:self.titleLabel];
    
    self.gradientView.tag = 9001;
    
    // Add the message label
    [self.gradientView addSubview:self.messageLabel];
    
    // Add the drop shadow to the notice view
//    CALayer *noticeLayer = self.gradientView.layer;
//    noticeLayer.shadowColor = [[UIColor blackColor]CGColor];
//    noticeLayer.shadowOffset = CGSizeMake(0.0, 3);
//    noticeLayer.shadowOpacity = 0.50;
//    noticeLayer.masksToBounds = NO;
//    noticeLayer.shouldRasterize = YES;
    
//    self.hiddenYOrigin = hiddenYOrigin;
    
    [self displayNotice];
}

- (void)cleanup
{
    [super cleanup];
    
    self.window = nil;
}

@end
