//
//  WBSuccessNoticeView.m
//  NoticeView
//
//  Created by Tito Ciuro on 5/25/12.
//  Copyright (c) 2012 Tito Ciuro. All rights reserved.
//

#import "WBSuccessNoticeView.h"
#import "WBNoticeView+ForSubclassEyesOnly.h"
#import "WBBlueGradientView.h"

@interface WBSuccessNoticeView ()
@property (nonatomic) UIWindow* window;
@end

@implementation WBSuccessNoticeView

+ (WBSuccessNoticeView *)successNoticeInViewController:(UIViewController *)view title:(NSString *)title;
{
    WBErrorNoticeView *notice = [WBErrorNoticeView errorNoticeInViewController:view title:title message:title];;
    notice.color = [UIColor colorWithRed:43.0f/255.0f green:148.0f/255.0f blue:183.0f/255.0f alpha:1];
    return (id)notice;
}

@end
