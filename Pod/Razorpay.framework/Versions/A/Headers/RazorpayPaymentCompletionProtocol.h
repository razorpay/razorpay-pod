//
//  PaymentCompletionProtocol.h
//  Razorpay
//
//  Created by Akshay Bhalotia on 02/03/16.
//  Copyright © 2016 Razorpay. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RazorpayPaymentCompletionProtocol <NSObject>

- (void)onPaymentError:(int)code description:(nonnull NSString *)str;

@optional
- (void)onPaymentSuccess:(nonnull NSString *)payment_id;
- (void)onPaymentSuccess:(nonnull NSString *)payment_id
                 andData:(nullable NSDictionary *)response;

@end
