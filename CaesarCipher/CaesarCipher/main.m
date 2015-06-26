//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//


//You are given a class called CaesarCipher with methods encode and decode
//Being amateur codebreakers, we want to know if two distinct looking ciphers correspond to the same input message. Write a
// method called codeBreaker, which accepts two cipher strings as paramaters and returns a boolean value which tells us
// whether they are actually the same input message encoded using two different offsets. hint: the maximum offset is 25
//There are multiple ways to do this. Try to come up with as many solutions as you can.

#import <Foundation/Foundation.h>

@interface CaesarCipher : NSObject

- (NSString *)decode:(NSString *)string offset:(int)offset;
- (NSString *)encode:(NSString *)string offset:(int)offset;
- (BOOL)codeBreaker:(NSString *)codeOne
                   :(NSString *)codeTwo;


- (void)printThis;

@end

@implementation CaesarCipher{

}


- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [string getCharacters:buffer range:NSMakeRange(0, count)];

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }

        int low = islower(buffer[i]) ? 'a' : 'A';
        result[i] = (buffer[i]%low + offset)%26 + low;
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}






- (BOOL)codeBreaker:(NSString *)codeOne
                   :(NSString *)codeTwo{
    [self decode: codeOne offset: 5];
    [self decode: codeTwo offset: 7];
    
    NSString *one = [self decode: codeOne offset: 5];
    NSString *two = [self decode: codeTwo offset: 7];
    
    return([one isEqualToString: two]);

}



@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        CaesarCipher *code = [[CaesarCipher alloc]init];
        
//        [code decode:@"Hey" int:10]
        [code codeBreaker:@"HI:"
                         :@"Heyll"];

        
        NSString *code1 = [code encode:@"Hello" offset:5];
        NSString *code2 = [code encode:@"Hello" offset:7];
        
        [code codeBreaker:code1
                         :code2];
        
        NSLog(@"%d", [code codeBreaker:code1 :code2]);
        
        
        return 0;
    }
    
}
