//
//  TaskToMemoPolicy.m
//  MigDemoAuto
//
//  Created by 蒼い惑星 on 11/02/14.
//  Copyright 2011 蒼い惑星. All rights reserved.
//

#import "TaskToMemoPolicy.h"


@implementation TaskToMemoPolicy

- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)sInstance 
									  entityMapping:(NSEntityMapping *)mapping 
											manager:(NSMigrationManager *)manager 
											  error:(NSError **)error {
	
	NSString *memoStr = [sInstance valueForKey:@"memo"];
	NSManagedObjectContext *moc = [manager destinationContext];
	
	NSArray *memoArray = [memoStr componentsSeparatedByString:@"|"];
	for (NSString *memo in memoArray) {
		if (memo) {
			// デスティネーションインスタンス作成 (デスティネーションManabedObjectContextである)
			NSManagedObject *memoEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Memo" inManagedObjectContext:moc];
			[memoEntity setValue:memo forKey:@"content"];
			
			// 関連付ける
			[manager associateSourceInstance:sInstance withDestinationInstance:memoEntity forEntityMapping:mapping];
			
			NSLog(@"Task:%@ newMemo:%@", [sInstance valueForKey:@"name"], memo);
		}
	}
	
	return YES;
}

@end
