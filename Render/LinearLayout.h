//
//  EditorView.h
//  Render
//
//  Created by Vignesh Ramesh on 03/06/15.
//  Copyright (c) 2015 Vignesh Ramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LayoutViewOrientationVertical,
    LayoutViewOrientationHorizontal
} LinearLayoutViewOrientation;

@interface LinearLayout : UIView

@property (nonatomic, readonly) NSMutableArray *items;
@property (nonatomic, assign) LinearLayoutViewOrientation orientation;

- (id)initWithOrientation:(LinearLayoutViewOrientation)orientation;

- (void)addItem:(UIView *)item;
- (void)removeItem:(UIView *)item;
- (void)removeAllItems;

- (void)insertItem:(UIView *)newItem beforeItem:(UIView *)existingItem;
- (void)insertItem:(UIView *)newItem afterItem:(UIView *)existingItem;
- (void)insertItem:(UIView *)newItem atIndex:(NSUInteger)index;

@end
