//
//  ViewController.m
//  CSV_TO_JSON
//
//  Created by Narlei Moreira on 29/01/15.
//  Copyright (c) 2015 NarleiMoreira. All rights reserved.
//

#import "ViewController.h"
#import "File.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progress setHidden:YES];
    [self.comboSeparadores selectItemAtIndex:0];
    self.formatoArquivo = @"txt";


    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)buttonConvertPressed:(id)sender {
    self.formatoArquivo = @"json";
    [self performSelectorInBackground:@selector(converteJson) withObject:nil];
    
}

- (IBAction)buttonConvertXmlPressed:(id)sender {
    self.formatoArquivo = @"xml";
    [self performSelectorInBackground:@selector(converteXml) withObject:nil];
}

- (IBAction)salvarJson:(id)sender {
    NSString *JSONValue = [self.textFieldJson string];
    
    // create the save panel
    NSSavePanel *panel = [NSSavePanel savePanel];
    
    // set a new file name
    [panel setNameFieldStringValue:[NSString stringWithFormat:@"output.%@",self.formatoArquivo]];
    
    // display the panel
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *saveURL = [panel URL];
            
            [JSONValue writeToFile:[saveURL absoluteString] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    }];
}



-(void) converteJson{
    NSArray * linhas = [File getLinesFromString:[self.textFieldCsv string]];
    if (linhas.count >0) {
        NSString *cabecalho = [linhas objectAtIndex:0];
        
        NSString *textoJSON = [NSString new];
        textoJSON = [textoJSON stringByAppendingString:@"[\n"];
        [self.progress setDoubleValue:0];
        [self.progress setMaxValue:linhas.count];
        [self.progress setHidden:NO];
        NSString *separador= @";";
        switch ([self.comboSeparadores indexOfSelectedItem]) {
            case 0:
                separador = @";";
                break;
            case 1:
                separador = @",";
                break;
            case 2:
                separador = @"\t";
                break;
            default:
                break;
        }
        int numeroValoresNaLinha = [File getWordCount:cabecalho delimitador:separador];
        
        for (int cont = 1; cont < linhas.count; cont++) {
            NSString *linhaAtual = [linhas objectAtIndex:cont];
            
            
            textoJSON = [textoJSON stringByAppendingString:@"{\n"];
            for (int contValores = 1; contValores <= numeroValoresNaLinha; contValores++) {
                int numeroValoresNaLinha1 = [File getWordCount:linhaAtual delimitador:separador];
                if (![File empty:[File getWordNum:cabecalho indice:contValores delimitador:separador]] && numeroValoresNaLinha1==numeroValoresNaLinha) {
                    
                    textoJSON = [textoJSON stringByAppendingString:[NSString stringWithFormat:@"\t\"%@\" : \"%@\"",[File getWordNum:cabecalho indice:contValores delimitador:separador],[File getWordNum:linhaAtual indice:contValores delimitador:separador]]];
                    
                    
                    
                    if (contValores != numeroValoresNaLinha) {
                        textoJSON = [textoJSON stringByAppendingString:@",\n"];
                    }else{
                        textoJSON = [textoJSON stringByAppendingString:@"\n"];
                    }
                }
                
            }
            if (cont+1 != linhas.count) {
                textoJSON = [textoJSON stringByAppendingString:@"},\n"];
            }else{
                textoJSON = [textoJSON stringByAppendingString:@"}\n"];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                double valorProgress = [[NSString stringWithFormat:@"%d",cont] doubleValue];
                [self.progress setDoubleValue:valorProgress];
            });
        }
        
        
        
        
        
        textoJSON = [textoJSON stringByAppendingString:@"]"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progress setDoubleValue:0];
            [self.progress setHidden:YES];
            [self.textFieldJson setString:textoJSON];
        });
    }
}



-(void) converteXml{
    NSArray * linhas = [File getLinesFromString:[self.textFieldCsv string]];
    if (linhas.count >0) {
        NSString *cabecalho = [linhas objectAtIndex:0];
        
        NSString *textoJSON = [NSString new];
        textoJSON = [textoJSON stringByAppendingString:@"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<root>\n"];
        [self.progress setDoubleValue:0];
        [self.progress setMaxValue:linhas.count];
        [self.progress setHidden:NO];
        NSString *separador= @";";
        switch ([self.comboSeparadores indexOfSelectedItem]) {
            case 0:
                separador = @";";
                break;
            case 1:
                separador = @",";
                break;
            case 2:
                separador = @"\t";
                break;
            default:
                break;
        }
        int numeroValoresNaLinha = [File getWordCount:cabecalho delimitador:separador];
        
        for (int cont = 1; cont < linhas.count; cont++) {
            NSString *linhaAtual = [linhas objectAtIndex:cont];
            
            
            textoJSON = [textoJSON stringByAppendingString:[NSString stringWithFormat:@"<%d>\n",cont]];
            for (int contValores = 1; contValores <= numeroValoresNaLinha; contValores++) {
                int numeroValoresNaLinha1 = [File getWordCount:linhaAtual delimitador:separador];
                if (![File empty:[File getWordNum:cabecalho indice:contValores delimitador:separador]] && numeroValoresNaLinha1==numeroValoresNaLinha) {
                    
                    textoJSON = [textoJSON stringByAppendingString:[NSString stringWithFormat:@"\t<%@>%@</%@>\n",[File getWordNum:cabecalho indice:contValores delimitador:separador],[File getWordNum:linhaAtual indice:contValores delimitador:separador],[File getWordNum:cabecalho indice:contValores delimitador:separador]]];
                }
                
            }
            textoJSON = [textoJSON stringByAppendingString:[NSString stringWithFormat:@"</%d>\n",cont]];
            dispatch_async(dispatch_get_main_queue(), ^{
                double valorProgress = [[NSString stringWithFormat:@"%d",cont] doubleValue];
                [self.progress setDoubleValue:valorProgress];
            });
        }
        
        
        
        
        
        textoJSON = [textoJSON stringByAppendingString:@"</root>"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progress setDoubleValue:0];
            [self.progress setHidden:YES];
            [self.textFieldJson setString:textoJSON];
        });
    }
}

-(void) viewWillDisappear{
    [NSApp terminate:self];
}
@end
