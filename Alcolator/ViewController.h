//
//  ViewController.h
//  Alcolator
//
//  Created by Lyndon Bartlett on 9/22/15.
//  Copyright © 2015 Lyndon Bartlett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *beerPercentTextField;

- (void)buttonPressed:(UIButton *)sender;
@end

