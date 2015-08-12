//
//  TableLayout.h
//  Render
//
//  Created by Vignesh Ramesh on 25/06/15.
//  Copyright (c) 2015 Vignesh Ramesh. All rights reserved.
//

#import "LinearLayout.h"

@interface TableLayout : LinearLayout

- (id)initWithRows:(NSInteger)row Columns:(NSInteger)column;

@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) NSInteger columns;

@end
