//
//  HelloWrapper.m
//  MenuSelectorSwiftUI
//
//  Created by Cyan on 2022/06/03.
//

#import <Foundation/Foundation.h>
#import "HelloWrapper.h"
#import "Hello.hpp"
@implementation HelloWrapper
- (NSString *) sayHello {
    Hello hello;
    std::string helloMessage = hello.sayHello();
    return [NSString
            stringWithCString:helloMessage.c_str()
            encoding:NSUTF8StringEncoding];
}
@end
