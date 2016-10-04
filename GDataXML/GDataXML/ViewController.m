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
    //格式为 .txt, .xml的储存数据的文件类型均可被GData解析；
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"txt"];
    
    // 1.将本地文件转化为NSData；2.使用类GDataXMLDocument 解析转化后的数据 并且存储它；
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding error:NULL];
    if (doc) {
        [self print:@"\nParse XML with XPath and print out every employe:\n\n"];
        NSInteger  n = 1;
        
        //类GDataXMLDocument的对象调用自身的方法nodesForXPath通过关键字"//employe", 取出对应的值并存放到数组中。
        NSArray *employees = [doc nodesForXPath:@"////name" error:NULL];
        
        //遍历数组employees 中GDataXMLElement类型的元素，并通过stringValue方法转化为字符串.
        for (GDataXMLElement *employe in employees) {
            
            [self print:[employe stringValue]];
            [self print:@"\n"];
            n ++;
        }
    }
}

- (IBAction)startHTMLParsing {
    
    self.textView.text = @"";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html" ofType:@"html"];
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithHTMLData:[NSData dataWithContentsOfFile:path] encoding:NSUTF8StringEncoding error:NULL];
    
    if (doc) {
        [self print:@"\nLoad non valid HTML file and convert it to valid XML:\n\n"];
        [self print:[[doc rootElement] XMLString]];
    }
}

- (IBAction)runXPathTests:(id)sender {
    
    self.textView.text = nil;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithHTMLString:@"<doc></doc>" error:NULL];
    [doc nodesForXPath:@"//doc" error:NULL];
    
    GDataXMLDocument *doc1 = [[GDataXMLDocument alloc] initWithXMLString:@"<doc/>" error:NULL];
    NSAssert([doc1 nodesForXPath:@"//doc" error:NULL].count == 1, @"1.1: Works, 1.2: Works");
    NSAssert([doc1 nodesForXPath:@"/doc" error:NULL].count == 1,  @"1.1: Works, 1.2: Works");
    NSAssert([doc1 nodesForXPath:@"doc" error:NULL].count == 1,   @"1.1: Works, 1.2: Fails");
    
    [self print:@"\nNo crash, seems to work"];
}
@end
