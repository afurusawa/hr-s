//
//  SUPPersonalizationMetaData.h
//  clientrt
//
//  Created by Jane Yang on 11/4/11.
//  Copyright (c) 2011 Sybase, Inc. All rights reserved.
//

#import "SUPAttributeMetaDataRBS.h"

@interface SUPPersonalizationMetaData : SUPAttributeMetaDataRBS
{
    @protected
    SUPPersonalizationType personalizationType;
    BOOL        isEncrypted;
    
}
@property(readwrite,assign,nonatomic)SUPPersonalizationType personalizationType;
@property(readwrite,assign,nonatomic)BOOL isEncrypted;
+ (id)getInstance;
@end
