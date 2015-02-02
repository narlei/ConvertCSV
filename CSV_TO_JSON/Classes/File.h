//
//  FIle.h
//  CSV_TO_JSON
//
//  Created by Narlei Moreira on 29/01/15.
//  Copyright (c) 2015 NarleiMoreira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject
+(NSArray *) getLinesFromString:(NSString *) fileContents;

#pragma mark CARACTERES - Manipulação de Texto
+(NSString *) getWordNum:(NSString *)texto indice:(int) indice delimitador:(NSString *)delimitador;
+(int) getWordCount :(NSString *)texto delimitador:(NSString *)delimitador;
+(BOOL) empty:(id) valor;
@end
