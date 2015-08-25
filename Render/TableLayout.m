//
//  TableLayout.m
//  Render
//
//  Created by Vignesh Ramesh on 25/06/15.
//  Copyright (c) 2015 Vignesh Ramesh. All rights reserved.
//

#import "TableLayout.h"
#import "TableRow.h"
#import "TableCell.h"

@implementation TableLayout
{
    
}

- (id)initWithRows:(NSInteger)row Columns:(NSInteger)column
{
    self = [super initWithOrientation:LayoutViewOrientationVertical];
    if (self) {        
        _rows = row;
        _columns = column;
        
        for (int i=0; i<row; i++) {
            TableRow *tableRow = [[TableRow alloc] initWithOrientation:LayoutViewOrientationHorizontal];
            tableRow.translatesAutoresizingMaskIntoConstraints = NO;
            for (int j=0; j<column; j++) {
                TableCell *tableCell = [[TableCell alloc] initWithOrientation:LayoutViewOrientationVertical];
                tableCell.translatesAutoresizingMaskIntoConstraints = NO;
                [tableCell addItem:[self textViewWithText:@"test"]];
                
                [tableRow addItem:tableCell];
            }
            [self addItem:tableRow];
        }
    }
    return self;
}

- (UITextView *)textViewWithText:(NSString *)text
{
    UITextView *textView = [UITextView new];
    textView.text = text;
    [textView setScrollEnabled:NO];
    
    textView.layer.borderWidth = 0.5;
    return textView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

@end
