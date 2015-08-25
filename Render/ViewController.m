//
//  ViewController.m
//  Render
//
//  Created by Vignesh Ramesh on 02/06/15.
//  Copyright (c) 2015 Vignesh Ramesh. All rights reserved.
//

#import "ViewController.h"
#import "LinearLayout.h"
#import "TableLayout.h"

@interface ViewController () <UITextViewDelegate, UIScrollViewDelegate>

@end

@implementation ViewController
{
    UIScrollView *editorScrollView;
    LinearLayout *editorView;
    NSLayoutConstraint *bottomConstraint;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpKeyboardNotificationHandlers];
    
    editorScrollView = [[UIScrollView alloc] init];
    editorScrollView.scrollEnabled = YES;
    editorScrollView.delegate = self;
    editorScrollView.maximumZoomScale = 1.5;
    editorScrollView.minimumZoomScale = 1.0;
    editorScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:editorScrollView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:editorScrollView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:editorScrollView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:editorScrollView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    bottomConstraint = [NSLayoutConstraint constraintWithItem:editorScrollView
                                                    attribute:NSLayoutAttributeBottom
                                                    relatedBy:NSLayoutRelationEqual
                                                       toItem:self.view
                                                    attribute:NSLayoutAttributeBottom
                                                   multiplier:1.0
                                                     constant:0];
    [self.view addConstraint:bottomConstraint];

    
    editorView = [[LinearLayout alloc] initWithOrientation:LayoutViewOrientationVertical];
    editorView.translatesAutoresizingMaskIntoConstraints = NO;
    [editorScrollView addSubview:editorView];
    
    [editorScrollView addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:editorScrollView
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:0]];
    [editorScrollView addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:editorScrollView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                      constant:20]];
    [editorScrollView addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:editorScrollView
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1.0
                                                      constant:0]];
    [editorScrollView addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:editorScrollView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1.0
                                                      constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:editorView
                                                      attribute:NSLayoutAttributeTrailing
                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                         toItem:self.view
                                                      attribute:NSLayoutAttributeTrailing
                                                     multiplier:1.0
                                                       constant:0]];
    
    
//    for (int i=0; i<=3; i++) {
//        [editorView addItem:[self textViewWithText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis ante vitae quam laoreet feugiat. Etiam id tellus in sem bibendum condimentum eget ut velit. Suspendisse ut viverra purus. Duis vestibulum risus vitae velit maximus condimentum. Nunc fringilla rutrum metus et finibus. Curabitur scelerisque egestas purus, vitae gravida nulla mattis eu. Aliquam id erat id tortor condimentum molestie. Pellentesque consectetur lectus ut massa placerat, ut cursus ipsum dictum. Quisque sit amet facilisis nisi. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Vestibulum id imperdiet libero. Cras vel convallis metus. Nullam maximus consectetur justo, nec gravida erat lacinia vel."]];
//    }
    TableLayout *layout = [[TableLayout alloc] initWithRows:2 Columns:2];
    layout.translatesAutoresizingMaskIntoConstraints = NO;
    
//    LinearLayout *layout = [[LinearLayout alloc] initWithOrientation:LayoutViewOrientationHorizontal];
//    layout.translatesAutoresizingMaskIntoConstraints = NO;
//    [layout addItem:[self textViewWithText:@"test"]];
//    [layout addItem:[self textViewWithText:@"test"]];
//    [layout addItem:[self textViewWithText:@"test"]];
    
    [editorView addItem:[self textViewWithText:@"textview 1"]];
    [editorView addItem:layout];
    [editorView addItem:[self textViewWithText:@"textview 2"]];
    editorScrollView.backgroundColor = [UIColor cyanColor];
    editorView.backgroundColor = [UIColor redColor];
}

- (UITextView *)textViewWithText:(NSString *)text
{
    UITextView *textView = [UITextView new];
    textView.text = text;
    [textView setScrollEnabled:NO];
    textView.delegate = self;
    
    textView.layer.borderWidth = 0.5;
    return textView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

-(void)updateViewConstraints
{
    [super updateViewConstraints];
}

- (void)setUpKeyboardNotificationHandlers {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:)
                   name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:)
                   name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    /*
     Reduce the size of the text view so
     that it's not obscured by the keyboard.
     Animate the resize so that it's in sync
     with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y
    // coordinate of its origin in self's view's
    // coordinate system. The bottom of the text
    // view's frame should align with the top
    // of the keyboard's final position.
    //
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:
                                       UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    bottomConstraint.constant = -keyboardRect.size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    // Animate the resize of the text view's
    // frame in sync with the keyboard's appearance.
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    editorView.frame = newTextViewFrame;
//    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the
     disappearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:
                                       UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    bottomConstraint.constant = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    editorView.frame = self.view.bounds;
//    [UIView commitAnimations];
}

// TextView delegates

-(void)textViewDidChangeSelection:(UITextView *)textView
{
    CGRect cursorRect = [textView caretRectForPosition:textView.selectedTextRange.start];
    cursorRect = [self.view convertRect:cursorRect fromView:textView];
    if (!CGRectIntersectsRect(cursorRect, editorScrollView.frame)) {
        cursorRect.size.height += 30; // To add some space underneath the cursor
        [editorScrollView scrollRectToVisible:cursorRect animated:NO];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (_shouldIgnorepredictiveInput) {
        [self setShouldIgnorepredictiveInput:NO];
        return NO;
    }
    
    [self setShouldIgnorepredictiveInput:YES];
    [textView.textStorage replaceCharactersInRange:range withString:text];
    
    NSRange rng = range;
    rng.location += text.length;
    rng.length = 0;
    [textView setSelectedRange:rng];
    [self setShouldIgnorepredictiveInput:NO];
    return NO;
}

// Scrollview delegates

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return editorView;
}

//-(void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    scrollView.center = self.view.center;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
