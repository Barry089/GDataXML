//
//  ViewController.m
//  GDataXML
//
//  Created by Li Zhe on 10/3/16.
//  Copyright © 2016 SH10. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)print:(NSString *)string {
    self.textView.text = [self.textView.text stringByAppendingString:string];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startXMLParsing:(id)sender {
    
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"xml"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding error:NULL];
    if (doc) {
        [self print:@"\nParse XML with XPath and print out every employe:\n\n"];
        NSArray *employees = [doc nodesForXPath:@"//employe" error:NULL];
        for (GDataXMLElement *employe in employees) {
            [self print:[employe stringValue]];
            [self print:@"\n"];
        }
    }
}

- (IBAction)startHTMLParsing {
}
@end
