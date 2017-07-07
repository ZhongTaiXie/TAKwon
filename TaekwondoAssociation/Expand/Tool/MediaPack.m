//
//  MediaPack.m
//
//  Created by Ceres  on 15/9/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MediaPack.h"


NSString *const kMediaPackMediaType = @"media_type";
NSString *const kMediaPackMediaId = @"media_id";
NSString *const kMediaPackTitle = @"title";
NSString *const kMediaPackDescription = @"description";
NSString *const kMediaPackThumbnail = @"thumbnail";
NSString *const kMediaPackOrigin = @"origin";
NSString *const kMediaPackOther = @"other";


@interface MediaPack ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MediaPack

@synthesize mediaType = _mediaType;
@synthesize mediaId = _mediaId;
@synthesize title = _title;
@synthesize mediaPackDescription = _mediaPackDescription;
@synthesize thumbnail = _thumbnail;
@synthesize origin = _origin;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.mediaType = [self objectOrNilForKey:kMediaPackMediaType fromDictionary:dict];
            self.mediaId = [self objectOrNilForKey:kMediaPackMediaId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kMediaPackTitle fromDictionary:dict];
            self.mediaPackDescription = [self objectOrNilForKey:kMediaPackDescription fromDictionary:dict];
            self.thumbnail = [self objectOrNilForKey:kMediaPackThumbnail fromDictionary:dict];
            self.origin = [self objectOrNilForKey:kMediaPackOrigin fromDictionary:dict];
            self.other = [self objectOrNilForKey:kMediaPackOther fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mediaType forKey:kMediaPackMediaType];
    [mutableDict setValue:self.mediaId forKey:kMediaPackMediaId];
    [mutableDict setValue:self.title forKey:kMediaPackTitle];
    [mutableDict setValue:self.mediaPackDescription forKey:kMediaPackDescription];
    [mutableDict setValue:self.thumbnail forKey:kMediaPackThumbnail];
    [mutableDict setValue:self.origin forKey:kMediaPackOrigin];
    [mutableDict setValue:self.other forKey:kMediaPackOther];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.mediaType = [aDecoder decodeObjectForKey:kMediaPackMediaType];
    self.mediaId = [aDecoder decodeObjectForKey:kMediaPackMediaId];
    self.title = [aDecoder decodeObjectForKey:kMediaPackTitle];
    self.mediaPackDescription = [aDecoder decodeObjectForKey:kMediaPackDescription];
    self.thumbnail = [aDecoder decodeObjectForKey:kMediaPackThumbnail];
    self.origin = [aDecoder decodeObjectForKey:kMediaPackOrigin];
    self.other = [aDecoder decodeObjectForKey:kMediaPackOther];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mediaType forKey:kMediaPackMediaType];
    [aCoder encodeObject:_mediaId forKey:kMediaPackMediaId];
    [aCoder encodeObject:_title forKey:kMediaPackTitle];
    [aCoder encodeObject:_mediaPackDescription forKey:kMediaPackDescription];
    [aCoder encodeObject:_thumbnail forKey:kMediaPackThumbnail];
    [aCoder encodeObject:_origin forKey:kMediaPackOrigin];
    [aCoder encodeObject:_other forKey:kMediaPackOther];
}

- (id)copyWithZone:(NSZone *)zone
{
    MediaPack *copy = [[MediaPack alloc] init];
    
    if (copy) {

        copy.mediaType = [self.mediaType copyWithZone:zone];
        copy.mediaId = [self.mediaId copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.mediaPackDescription = [self.mediaPackDescription copyWithZone:zone];
        copy.thumbnail = [self.thumbnail copyWithZone:zone];
        copy.origin = [self.origin copyWithZone:zone];
        copy.other = [self.other copyWithZone:zone];
    }
    
    return copy;
}


@end
