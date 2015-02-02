//
//  ViewController.h
//  CSV_TO_JSON
//
//  Created by Narlei Moreira on 29/01/15.
//  Copyright (c) 2015 NarleiMoreira. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (unsafe_unretained) IBOutlet NSTextView *textFieldCsv;
@property (unsafe_unretained) IBOutlet NSTextView *textFieldJson;
@property (weak) IBOutlet NSProgressIndicator *progress;
@property (weak) IBOutlet NSScrollView *textScroolCsv;

@property (nonatomic,strong)  NSString *formatoArquivo;
@property (weak) IBOutlet NSComboBox *comboSeparadores;

- (IBAction)buttonConvertPressed:(id)sender;
- (IBAction)salvarJson:(id)sender;
- (IBAction)buttonConvertXmlPressed:(id)sender;


@end

