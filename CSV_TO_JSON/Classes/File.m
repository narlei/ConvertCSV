//
//  FIle.m
//  CSV_TO_JSON
//
//  Created by Narlei Moreira on 29/01/15.
//  Copyright (c) 2015 NarleiMoreira. All rights reserved.
//

#import "File.h"

@implementation File

+(NSArray *) getLinesFromString:(NSString *) fileContents{
    
    // first, separate by new line
    NSArray* allLinedStrings =
    [fileContents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    return allLinedStrings;
}


// Retorna a string no meio da frase
+(NSString *) getWordNum:(NSString *)texto indice:(int) indice delimitador:(NSString *)delimitador{
    texto=[delimitador stringByAppendingString:texto];
    texto=[texto stringByAppendingString:delimitador];
    NSArray *substrings = [texto componentsSeparatedByString:delimitador];
    NSString *first = [substrings objectAtIndex:indice];
    return first;
}
// Retorna a Qtd de Strings separadas por um determinado delimitador
+(int) getWordCount :(NSString *)texto delimitador:(NSString *)delimitador{
    NSArray *substrings = [texto componentsSeparatedByString:delimitador];
    NSString *tamanhoStr=[NSString stringWithFormat:@"%lu",(unsigned long)substrings.count];
    int qtdWord;
    qtdWord = [tamanhoStr intValue];
    return qtdWord;
    
}

+(BOOL) empty:(id) valor{
    if ([valor isKindOfClass:[NSString class]]) {
        if (valor == nil || valor == NULL || [valor length]==0) {
            return YES;
        }
    }else{
        float valorFloat = [valor floatValue];
        if (valorFloat == 0) {
            return YES;
        }
    }
    return NO;
}
//// then break down even further
//NSString* strsInOneLine =
//[allLinedStrings objectAtIndex:0];
//
//// choose whatever input identity you have decided. in this case ;
//NSArray* singleStrs =
//[currentPointString componentsSeparatedByCharactersInSet:
// [NSCharacterSet characterSetWithCharactersInString:@";"]];
@end
