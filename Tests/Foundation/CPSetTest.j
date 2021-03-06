
@import <Foundation/CPSet.j>


@implementation CPSetTest : OJTestCase
{
    CPSet set;
}

- (void)assertSet:(CPSet)aSet onlyHasObjects:(CPArray)objects
{
    [self assert:[objects count] equals:[aSet count]];

    var allObjects = [aSet allObjects],
        index = 0,
        count = [objects count];

    [self assert:[objects count] equals:[allObjects count]];

    for (; index < count; ++index)
    {
        var object = objects[index];

        if ([allObjects indexOfObjectIdenticalTo:object] === CPNotFound)
            return [self fail:@"Set does not contain " + object];
    }
}

- (void)testEmptySet
{
    var set = [CPSet set];

    [self assert:@"{(\n)}" equals:[set description]];
    [self assert:0 equals:[set count]];
    [self assert:[] equals:[set allObjects]];
    [self assert:nil equals:[set anyObject]];
    [self assert:NO equals:[set containsObject:RAND()]];
    [self assert:nil equals:[set member:RAND()]];

    var object,
        objectEnumerator = [set objectEnumerator];

    while ((object = [objectEnumerator nextObject]) !== nil)
        [self fail:@"Empty set had non-empty enumerator"];

    [self assertTrue:[set isSubsetOfSet:set]];
    [self assertTrue:[set isSubsetOfSet:[CPSet set]]];

    // Empty set intersects nothing!
    [self assertFalse:[set intersectsSet:set]];
    [self assertFalse:[set intersectsSet:[CPSet set]]];

    [self assertTrue:[set isEqualToSet:set]];
    [self assertTrue:[set isEqualToSet:[CPSet set]]];

    var copy = [set copy];

    [self assert:@"{(\n)}" equals:[copy description]];
    [self assertTrue:[set isEqualToSet:copy]];
}

- (void)testSetWithArray_
{
    [self assertSet:[CPSet setWithArray:[]] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithArray:[@"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithArray:[@"a", @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithArray:[@"a", @"a", @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithArray:[@"a", @"b"]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithArray:[@"a", @"b", @"a"]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithArray:[@"a", @"b", @"a", 0]] onlyHasObjects:[@"a", @"b", 0]];
}

- (void)testSetWithObject
{
    [self assertSet:[CPSet setWithObject:nil] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObject:undefined] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObject:0] onlyHasObjects:[0]];
    [self assertSet:[CPSet setWithObject:@"a"] onlyHasObjects:[@"a"]];
}

- (void)testSetWithObjects_count_
{
    [self assertSet:[CPSet setWithObjects:[] count:0] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObjects:[@"a"] count:1] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"a"] count:2] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"a", @"a"] count:3] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b"] count:2] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b", @"a"] count:3] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b", @"a", 0] count:4] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithObjects:[@"a", nil, undefined, 0] count:4] onlyHasObjects:[@"a", 0]];

    [self assertSet:[CPSet setWithObjects:[] count:4] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObjects:[@"a"] count:2] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"a"] count:0] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"a", @"a"] count:1] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b"] count:1] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b", @"a"] count:2] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:[@"a", @"b", @"a", 0] count:10] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithObjects:[@"a", nil, undefined, 0] count:3] onlyHasObjects:[@"a"]];
}

- (void)testSetWithObjects_count_
{
    [self assertSet:[CPSet setWithObjects:nil] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithObjects:@"a"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", nil] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"a"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", nil, @"a"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"a", @"a"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"a", @"a"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b"] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b", nil] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:@"a", nil, @"b"] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b", @"a"] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b", @"a", 0] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b", @"a", 0, nil] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithObjects:@"a", @"b", @"a", nil, 0] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithObjects:@"a", nil, undefined, 0] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithObjects:@"a", undefined, 0, nil] onlyHasObjects:[@"a", 0]];
}

- (void)testSetWithSet_
{
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:nil]] onlyHasObjects:[]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", nil]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", nil, @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"a", @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"a", @"a"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b"]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b", nil]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", nil, @"b"]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b", @"a"]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b", @"a", 0]] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b", @"a", 0, nil]] onlyHasObjects:[@"a", @"b", 0]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", @"b", @"a", nil, 0]] onlyHasObjects:[@"a", @"b"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", nil, undefined, 0]] onlyHasObjects:[@"a"]];
    [self assertSet:[CPSet setWithSet:[CPSet setWithObjects:@"a", undefined, 0, nil]] onlyHasObjects:[@"a", 0]];
}

- (void)testAddObject
{
    var set = [CPSet new];

    [self assertFalse:[set containsObject:"foo"]];
    [set addObject:"foo"];
    [self assertTrue:[set containsObject:"foo"]];
}

- (void)testAddZeroObject
{
    var set = [CPSet new];

    [self assertFalse:[set containsObject:0]];
    [set addObject:0];
    [self assertTrue:[set containsObject:0]];
}

- (void)testRemoveObject
{
    var set = [CPSet new];

    [set addObject:"foo"];
    [self assertTrue:[set containsObject:"foo"]];
    [set removeObject:"foo"];
    [self assertFalse:[set containsObject:"foo"]];
}

- (void)testRemoveZeroObject
{
    var set = [CPSet new];

    [set addObject:0];
    [self assertTrue:[set containsObject:0]];
    [set removeObject:0];
    [self assertFalse:[set containsObject:0]];
}

- (void)testAddNilObject
{
    var set = [CPSet new];

    [self assertFalse:[set containsObject:nil]];
    [set addObject:nil];
    [self assertFalse:[set containsObject:nil]];
}

- (void)testRemoveNilObject
{
    var set = [CPSet new];

    [set addObject:nil];
    [self assertFalse:[set containsObject:nil]];
    [set removeObject:nil];
    [self assertFalse:[set containsObject:nil]];
}

- (void)testIsSubsetOfSet
{
    var set = [CPSet setWithArray:[1, 2, 3, 4, 5]];
    [self assertTrue:[[CPSet setWithArray:[1, 2, 3]] isSubsetOfSet:set]];
    [self assertFalse:[[CPSet setWithArray:[1, 2, 3, 100]] isSubsetOfSet:set]];
    [self assertTrue:[[CPSet new] isSubsetOfSet:set]];
}

- (void)testDescription
{
    var set = [CPSet new];

    [self assert:@"{(\n)}" equals:[set description]];
    [set addObject:"horizon"];
    [set addObject:"surfer"];
    [set addObject:"7"];
    [self assertSet:set onlyHasObjects:["horizon", "surfer", "7"]];
}

@end
