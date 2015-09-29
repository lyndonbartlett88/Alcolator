//
//  ViewController.m
//  Alcolator
//
//  Created by Lyndon Bartlett on 9/22/15.
//  Copyright © 2015 Lyndon Bartlett. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () //<UITextFieldDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.beerPercentTextField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    if (enteredNumber == 0) {
        sender.text = nil;
    }
    
}
- (IBAction)sliderValueDidChange:(UISlider *)sender {
    int integerSliderValue = (int)sender.value;
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    NSString *navigationText;
    NSRange wineRange = [self.navigationItem.title rangeOfString:@"Wine"];
    
//    if ([self.navigationItem.title  isEqual: @"Wine"]) {
    if (wineRange.location == NSNotFound) {
        navigationText = NSLocalizedString(@"Whiskey", nil);
        self.navigationItem.title = [NSString stringWithFormat:@"%@ (%d shots)", navigationText, integerSliderValue];
    }
    else
    {
        navigationText = NSLocalizedString(@"Wine", nil);
        self.navigationItem.title = [NSString stringWithFormat:@"%@ (%d glasses)", navigationText, integerSliderValue];
    }
//    else
//    {
//        navigationText = NSLocalizedString(@"Whiskey", nil);
//        self.navigationItem.title = [NSString stringWithFormat:@"%@ (%f shots)", navigationText, self.beerCountSlider.value];
//    }

}

- (IBAction)buttonPressed:(id)sender {
    if([self.beerPercentTextField isFirstResponder] && [self.beerPercentTextField canResignFirstResponder])
    {
        [self.beerPercentTextField resignFirstResponder];
    }

    //[self.beerPercentTextField resignFirstResponder];
    //first, calculate how much alcohol is in all those beers...
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12; //assume they are 12oz beer bottles
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    //wine calculator
    float ouncesInOneWineGlass = 5; //wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13; //13% is average
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    int intNumberOfWineGlassesForEquivalentAlcoholAmount = numberOfWineGlassesForEquivalentAlcoholAmount;
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) intNumberOfWineGlassesForEquivalentAlcoholAmount]];
    //decide whether to use "beer"/"beers" and "glass"/"glasses"
    NSString *beerText;
    if (numberOfBeers == 1)
    {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    }
    else
    {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1)
    {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    }
    else
    {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    //generate the result text, and display it on the label
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
