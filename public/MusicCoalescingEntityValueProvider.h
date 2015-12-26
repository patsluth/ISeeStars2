
@protocol MusicEntityValueProviding;





@interface MusicCoalescingEntityValueProvider : NSObject
{
}

@property (nonatomic, retain) id<MusicEntityValueProviding> baseEntityValueProvider;

- (id)valueForEntityProperty:(NSString *)arg1;

@end




