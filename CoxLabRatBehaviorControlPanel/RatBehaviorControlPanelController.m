//
//  MWDebuggerWindowController.m
//  MWorksDebugger
//
//  Created by David Cox on 2/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "RatBehaviorControlPanelController.h"

#import "MWorksCocoa/MWClientServerBase.h"
//#import "MWorksCore/Client.h"
#import "MWorksCocoa/MWCocoaEvent.h"

NSString *valuesTargetprobPlotIdentifier = @"ValuesTargetProbLinePlot";

@implementation RatBehaviorControlPanelController

@synthesize staircaseStates;

@synthesize valuesTargetprob; // new

- (void)setupChart {
	// Read chart attributes from plist file.
    //NSDictionary *attribsDict = [NSDictionary dictionaryWithContentsOfFile:
    //    [[NSBundle mainBundle] pathForResource:@"MWBehavioralHistoryChartAttributes" ofType:@"plist"]];
    //[chart setAttributesFromDictionary:attribsDict];
    
    // Set the plot area size and position, which can be done via the configuration
    // file, but is probably best determined dynamically from the NRTXYChart view's
    // bounds.
    // Also set the position of the chart title.
    // Note that all of these things can also be set via the configuration file.
    NSRect b = [chart bounds];
    [chart setAttributesFromDictionary:
     [NSDictionary dictionaryWithObjectsAndKeys:
      @"",
      NRTTitleCA,
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:b.origin.x + 0],
       [NSNumber numberWithFloat:b.origin.x + b.size.width], nil],
      NRTPlotAreaFrameXRangeCA,
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:b.origin.y + 0],
       [NSNumber numberWithFloat:b.origin.y + b.size.height], nil],
      NRTPlotAreaFrameYRangeCA,
      
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:103], nil],
      NRTLeftYAxisCoordinateRangeCA,
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:maxHistory], nil],
      NRTBottomXAxisCoordinateRangeCA,
      
      // Toned down bottom axis ticks
      [NSNumber numberWithFloat:1],
      NRTBottomXAxisMajorTickWidthCA,
      
      [NSNumber numberWithFloat:3],
      NRTBottomXAxisMajorTickLengthCA,
      
      [NSNumber numberWithFloat:0],
      NRTBottomXAxisMinorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTBottomXAxisMinorTickLengthCA,
      
      // No top axis ticks
      [NSNumber numberWithFloat:0],
      NRTTopXAxisMajorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTTopXAxisMajorTickLengthCA,
      
      [NSNumber numberWithFloat:0],
      NRTTopXAxisMinorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTTopXAxisMinorTickLengthCA,
      
      
      // Toned down bottom axis ticks
      [NSNumber numberWithFloat:1],
      NRTLeftYAxisMajorTickWidthCA,
      
      [NSNumber numberWithFloat:3],
      NRTLeftYAxisMajorTickLengthCA,
      
      [NSNumber numberWithFloat:0],
      NRTLeftYAxisMinorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTLeftYAxisMinorTickLengthCA,
      
      // No top axis ticks
      [NSNumber numberWithFloat:0],
      NRTRightYAxisMajorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTRightYAxisMajorTickLengthCA,
      
      [NSNumber numberWithFloat:0],
      NRTRightYAxisMinorTickWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTRightYAxisMinorTickLengthCA,
      
      
      // Toned down axes
      [NSNumber numberWithFloat:1],
      NRTBottomXAxisWidthCA,
      
      [NSNumber numberWithFloat:1],
      NRTLeftYAxisWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTTopXAxisWidthCA,
      
      [NSNumber numberWithFloat:0],
      NRTRightYAxisWidthCA,
      
      [NSArray arrayWithObjects:
       //[NSNumber numberWithFloat:0],
       //[NSNumber numberWithFloat:50],
       //[NSNumber numberWithFloat:100],
       //[NSNumber numberWithFloat:150],
       //[NSNumber numberWithFloat:maxHistory],
       nil],
      NRTBottomXAxisTickCoordinatesCA,
      
      [NSArray arrayWithObjects:
       // [NSNumber numberWithFloat:0],
       // [NSNumber numberWithFloat:50],
       //[NSNumber numberWithFloat:100],
       nil],
      NRTLeftYAxisTickCoordinatesCA,
      
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:0.0],
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:1.0], nil],
      NRTPlotAreaBackgroundRGBACA,
      
      [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:0],
       [NSNumber numberWithFloat:0.0], nil],
      NRTChartBackgroundRGBACA,
      
      /* [NSArray arrayWithObjects:
       [NSNumber numberWithFloat:b.origin.x + b.size.width * 0.5],
       [NSNumber numberWithFloat:b.origin.y + b.size.height - 25], nil],
       NRTTitlePlotViewVectorCA,*/
      
      nil]];
	
    // Add plots
    //[self addLinePlot];
	// [self addHistogramPlot];
	
	// Set plot attributes, which are defined in the NRTScatterPlot ancestor class NRTPlotObject
    valuesTargetprobPlot = [[[NRTScatterPlot alloc]
                           initWithIdentifier:valuesTargetprobPlotIdentifier
                           andDataSource:self] autorelease];
    [valuesTargetprobPlot setAttribute:[NSNumber numberWithFloat:0.5] forKey:NRTLineWidthAttrib];
    [valuesTargetprobPlot setAttribute:[NSColor colorWithCalibratedRed:0.1 green:0.7 blue:0.4 alpha:1.0]
							  forKey:NRTLineColorAttrib];
    [valuesTargetprobPlot setConnectPoints:YES];
	
	// Create and set the cluster graphic of the plot. Here we will just create a filled
    // symbol. We set the stroke and fill colors of the symbol.
    NRTSymbolClusterGraphic *clusterGraphic = [[[NRTSymbolClusterGraphic alloc] init] autorelease];
    [clusterGraphic setAttribute:[NSColor colorWithCalibratedRed:0.0 green:0.0 blue:1.0 alpha:1.0]
						  forKey:NRTFillColorAttrib];
    [clusterGraphic setAttribute:[NSColor colorWithCalibratedRed:0.75 green:0.75 blue:1.0 alpha:1.0]
						  forKey:NRTLineColorAttrib];
    [clusterGraphic setAttribute:[NSNumber numberWithFloat:0.7] forKey:NRTLineWidthAttrib];
	
    // Now we need to actually set the form of the symbol, which will be a circle with a line.
    // It can be anything you can draw with NSBezierPath. It could be a square, a triangle, or
    // a giraffe.
    NSBezierPath *symbolPath = [NSBezierPath bezierPath];
    [symbolPath moveToPoint:NSMakePoint(0.0, 0.0)];
    [symbolPath appendBezierPathWithOvalInRect:NSMakeRect( -1.0, -1.0, 1.0, 1.0 )];
    [clusterGraphic setBezierPath:symbolPath];
    [clusterGraphic setSize:NSMakeSize(1.0, 1.0)];
    
    [valuesTargetprobPlot setClusterGraphic:clusterGraphic];
    
	[chart setUseImageCache:NO];
	
    // Finally add the plot to chart
    [chart addPlot:valuesTargetprobPlot];
	
	[chart layout];
    
}

- (void)awakeFromNib {
//- (void)setDelegate:(id)new_delegate{
//	delegate = new_delegate;
	
	#define RAT_CONTROL_PANEL_CALLBACK_KEY	"ratcontrolpanelcallback"
	#define RESERVED_CODEC_CODE	0
	
	self.staircaseStates = [NSArray arrayWithObjects:ACTIVE_STRING, DISABLED_STRING, FROZEN_STRING, Nil];
	
//	[delegate registerEventCallbackWithReceiver:self 
//                                     selector:@selector(codecUpdated:)
//                                  callbackKey:RAT_CONTROL_PANEL_CALLBACK_KEY
//                              forVariableCode:RESERVED_CODEC_CODE];
    
    // NEW STUFF...? (until curly bracket end)
    TargetprobCodecCode = -1;
    
    valuesTargetprob = 0;
    
    // flag for variable codec check (see _cacheCodes)
    VariableCheck = NO;
	
	[ValuesTargetprobField setDrawsBackground:NO];
    valuesTargetprobHistory = [[NSMutableArray alloc] init];
    totalHistory = [[NSMutableArray alloc] init];
	maxHistory = 100;
    
    [self setupChart];

}

//new stuff:
- (void) updatePercentages {
    self.valuesTargetprob = (int)((double)numberOfTrials/(double)numberOfTrials*100);

    [valuesTargetprobHistory addObject:[NSNumber numberWithDouble:valuesTargetprob]];
    [totalHistory addObject:[NSNumber numberWithInt:numberOfTrials]];
    
    if([totalHistory count] > maxHistory){
        [valuesTargetprobHistory removeObjectAtIndex:0];
    }
    
    [self updatePlot];
    
    [self performSelectorOnMainThread: @selector(setNeedsDisplayOnMainThread:)
                           withObject: chart waitUntilDone: NO];
    
	
}

- (void)updatePlot
{
	//@synchronized(chart){
    [chart layout];
	//}
}


- (void)openSheet{
	
}


- (void)closeSheet {
    [optionsSheet orderOut:self];
    [NSApp endSheet:optionsSheet];
}

- (IBAction)launchOptionsSheet:(id)sender{
	[NSApp beginSheet:optionsSheet modalForWindow:[NSApp mainWindow]
		modalDelegate:nil didEndSelector:nil contextInfo:nil];
}

- (IBAction)acceptOptionsSheet:(id)sender{
	[self closeSheet];
}

- (IBAction)cancelOptionsSheet:(id)sender{
	[self closeSheet];
}


- (IBAction)resetPerformance:(id)sender {
	//@synchronized(self){
    // reset button clears the past performance and start over the counting
    TargetprobCodecCode = -1;

    self.valuesTargetprob = 0;

    VariableCheck = NO;
    
    
    [ValuesTargetprobField setDrawsBackground:NO];
    [valuesTargetprobHistory removeAllObjects];
    [totalHistory removeAllObjects];
    
    [self updatePlot];
    
    // re-check the codec number (in case the variable names have changed)
    //[self _cacheCodes];
    
	//}
    
    
}

/*******************************************************************
 *                           Private Methods
 *******************************************************************/
// This methods find the codec number for the variables that keep track of good trials
//versus bad trials, it does so by matching the tag names to the variables in the experiment.
- (void)receiveCodec: (MWCocoaEvent *)event {
    
	[delegate unregisterCallbacksWithKey:RAT_CONTROL_PANEL_CALLBACK_KEY];
	
	if(delegate != nil) {
		TargetprobCodecCode = [[delegate codeForTag:[TargetprobVariableField stringValue]] intValue];
        
		VariableCheck = YES;
	}
    
    // if variables entered by the user was not found in the experiment, issue a warning in the console.
	if (TargetprobCodecCode == -1) {
		mwarning(M_NETWORK_MESSAGE_DOMAIN, "Variable for targetprob: %s was not found.",[[TargetprobVariableField stringValue] cStringUsingEncoding:NSASCIIStringEncoding]);
	} else {
		[delegate registerEventCallbackWithReceiver:self
                                           selector:@selector(serviceCorrectEvent:)
                                        callbackKey:RAT_CONTROL_PANEL_CALLBACK_KEY
                                    forVariableCode:TargetprobCodecCode
                                       onMainThread:YES];
	}
    
    // re-register for the codec
	[delegate registerEventCallbackWithReceiver:self
                                       selector:@selector(receiveCodec:)
                                    callbackKey:RAT_CONTROL_PANEL_CALLBACK_KEY
                                forVariableCode:RESERVED_CODEC_CODE
                                   onMainThread:YES];
    
}


// Plot data source methods
-(unsigned)numberOfDataClustersForPlot:(NRTPlot *)plot
{
	int num = 0;
	
	if ( [[plot identifier] isEqual:valuesTargetprobPlotIdentifier] ) {
		num =  [valuesTargetprobHistory count];
		//NSLog(@"N Data Clusters: %d", num);
    }
	
	return num;
}


-(NSDictionary *)clusterCoordinatesForPlot:(id)plot andDataClusterIndex:(unsigned)entryIndex
{
    float x, y;
	
	x = (float)entryIndex;
	y = 0.0;
	
	if([[plot identifier] isEqual:valuesTargetprobPlotIdentifier]){
		y = [[valuesTargetprobHistory objectAtIndex:entryIndex] floatValue];
	}
	
    //NSLog(@"x,y: %g, %g", x, y);
	
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithFloat:x],	NRTXClusterIdentifier,
            [NSNumber numberWithFloat:y], 	NRTYClusterIdentifier, nil];
	
	
}

    
// rest of the old stuff:
- (void) codecUpdated:(MWCocoaEvent *)event {
	//int code = [event code];
	//if(code == RESERVED_CODEC_CODE){
	
	NSArray *names = [delegate variableNames];

	for(int i = 0; i < [names count]; i++){
		[self willChangeValueForKey:[names objectAtIndex:i]];
	}
	
	for(int i = 0; i < [names count]; i++){
		[self didChangeValueForKey:[names objectAtIndex:i]];
	}


}


/*- (id) valueForKey:(NSString *)key{
	return [delegate valueForKey:key];
}

- (void) setValue:(id)val forKey:(NSString *)key{
	[delegate setValue:val forKey:key];
}*/

- (IBAction) deliverCenter:(id)sender {
	[delegate setValue:[delegate valueForKeyPath:@"variables.reward_amount"]
			forKeyPath:@"variables.LickOutput"];
}

//- (IBAction) deliverRight:(id)sender {
//	[delegate setValue:[delegate valueForKeyPath:@"variables.minimal_reward_duration"]
//			forKeyPath:@"variables.LickOutput3"];
//}


@end
