//
//  ExtendNSLogFunctionality.m
//  ExtendNSLog

#import "ExtendNSLogFunctionality.h"

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
#if DEBUG_MODE
    va_list ap;
    va_start(ap, format);

    //if (![format hasSuffix: @"\n"]) format = [format stringByAppendingString: @"\n"];
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];

    va_end(ap);

    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "%s (line %d): %s\n", [fileName UTF8String], lineNumber, [body UTF8String]);
#endif
}

@implementation ExtendNSLogFunctionality

@end
