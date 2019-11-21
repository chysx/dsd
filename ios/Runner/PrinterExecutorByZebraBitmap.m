//
//  PrinterExecutorByZebraBitmap.m
//  Runner
//
//  Created by ebestmobile on 2019/11/20.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrinterExecutorByZebraBitmap.h"

#import "ZebraPrinterConnection.h"
#import  "TcpPrinterConnection.h"
#import "ZebraPrinter.h"
#import "ZebraPrinterFactory.h"
#import "PrinterStatus.h"
#import "PrinterStatusMessages.h"
#import "MfiBtPrinterConnection.h"

@implementation PrinterExecutorByZebraBitmap
int ACTULA_WIDTH = 760;
- (void)printByAddress{
        [NSThread detachNewThreadSelector:@selector(startPrint) toTarget:self withObject:nil];
}

- (void)startPrint {
        
    NSString *address = self.address;
    NSLog(@"address = %@",address);
    
    id<ZebraPrinterConnection, NSObject> connection = nil;
    connection = [[MfiBtPrinterConnection alloc] initWithSerialNumber:address];
    BOOL didOpen = [connection open];
    if(didOpen == YES) {

        NSLog(@"Connected...");
        NSLog(@"Determining Printer Language...");

        NSError *error = nil;
        id<ZebraPrinter,NSObject> printer = [ZebraPrinterFactory getInstance:connection error:&error];
        
        if(printer != nil) {
            PrinterLanguage language = [printer getPrinterControlLanguage];
            NSLog(@"Sending Data...");

            UIImage *image = [self getImage];
            
            NSString *startStr = [self getStartCommandByBitmap:image.size.height + 20];
            NSData *data = [NSData dataWithBytes:[startStr UTF8String] length:[startStr length]];
            [connection write:data error:&error];
            
            BOOL sentOK = [self sendImageToPrinter:image printer:printer];
            
            if (sentOK == YES) {
                NSLog(@"Test Label Sent");

            } else {
                NSLog(@"Test Label Failed to Print");
            }
        } else {
                        NSLog(@"Could not Detect Language");

        }
    } else {
        NSLog(@"Could not connect to printer");

    }
    
    NSLog(@"Disconnecting");

    
    [connection close];
}

-(BOOL) sendImageToPrinter:(UIImage *)image printer:(id<ZebraPrinter,NSObject>)printer {
    BOOL success = NO;
    id<GraphicsUtil, NSObject> graphicsUtil = [printer getGraphicsUtil];
    NSError *error = nil;
    success = [graphicsUtil printImage:[image CGImage] atX:0 atY:0 withWidth:image.size.width withHeight:image.size.height andIsInsideFormat:NO error:&error];
    return success;
}

- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale
{
  CGSize size = image.size;
  CGFloat width = size.width;
  CGFloat height = size.height;
  CGFloat scaledWidth = width * scale;
  CGFloat scaledHeight = height * scale;
  UIGraphicsBeginImageContext(size); // this will crop
  [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
  UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (UIImage*)getImage{
    NSData *data = [NSData dataWithContentsOfFile:self.imgPath];
    UIImage *image = [UIImage imageWithData:data];
    float scale = ACTULA_WIDTH * 1.0f / image.size.width;
    NSLog(@"scale = %f",scale);
    return [self imageCompressWithSimple:image scale:scale];
}

- (NSString*)getStartCommandByBitmap:(int)height{
    return [[NSString alloc] initWithFormat:@"^XA^POI^PW%d^LL%d^LH0,0^XZ\r\n",ACTULA_WIDTH,height];
}

@end
