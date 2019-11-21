//
//  PrinterExecutorByZebraBitmap.h
//  Runner
//
//  Created by ebestmobile on 2019/11/20.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#ifndef PrinterExecutorByZebraBitmap_h
#define PrinterExecutorByZebraBitmap_h

@interface PrinterExecutorByZebraBitmap : NSObject

@property (nonatomic) NSString *address;
@property (nonatomic) NSString *imgPath;

- (void)printByAddress;

@end

#endif /* PrinterExecutorByZebraBitmap_h */
