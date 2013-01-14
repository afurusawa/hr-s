#import "HR_SuiteLoggerImpl.h"
#import "HR_SuiteLogRecordImpl.h"
#import "HR_SuiteKeyGenerator.h"

@implementation HR_SuiteLoggerImpl

- (id<SUPLogRecord>)createRealLogRecord
{
	HR_SuiteLogRecordImpl *log = [HR_SuiteLogRecordImpl getInstance];
	log.messageId = [HR_SuiteKeyGenerator generateId];
	log.requestId = [NSString stringWithFormat:@"%ld",log.messageId];
    log.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
	log.code = 9999;
	log.component = @"HR_SuiteDB";
	return log;
}


@end