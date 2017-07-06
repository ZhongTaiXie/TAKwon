//
//  MediaPack.h
//
//  Created by Ceres  on 15/9/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaPack : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mediaType;
@property (nonatomic, strong) NSString *mediaId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mediaPackDescription;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *origin;
@property (nonatomic, strong) NSString *other;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
