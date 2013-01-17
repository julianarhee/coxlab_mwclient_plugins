//
//  MWDebuggerWindowController.h
//  MWorksDebugger
//
//  Created by David Cox on 2/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MWorksCocoa/MWWindowController.h"
#import "Narrative/Narrative.h" // new

NSString *FROZEN_STRING = @"Frozen";
NSString *ACTIVE_STRING = @"Active";
NSString *DISABLED_STRING = @"Disabled";

@protocol MWDataEventListenerProtocol;


@interface RatBehaviorControlPanelController : NSWindowController {
    
    // NEW STUFF:
    // editable text field	(this contains the variable to screen in the data stream)
    IBOutlet NSTextField *TargetprobVariableField;
    IBOutlet NSTextField *ValuesTargetprobField;
    
    IBOutlet NSWindow	*optionsSheet;
    
    IBOutlet NRTXYChart *chart;
    NRTScatterPlot *valuesTargetprobPlot;
    
    int TargetprobCodecCode; // codec num for variable
    
    int	numberOfTrials; // class variable
    
    int valuesTargetprob; // class variable
    
    NSMutableArray *valuesTargetprobHistory;
    NSMutableArray *totalHistory;
    int maxHistory;
    
    BOOL VariableCheck;
    
    
    // old
	IBOutlet id delegate;
	NSArray *staircaseStates;
    
}

@property int numberOfTrials; // new

@property int valuesTargetprob; //new

@property(assign) NSArray *staircaseStates;

- (void)awakeFromNib;
//- (void)setDelegate:(id)new_delegate; 

- (IBAction)resetPerformance:(id)sender; // new stuff, until "deliverCenter"
- (IBAction)resetPerformanceInSession:(id)sender;
- (IBAction)launchOptionsSheet:(id)sender;
- (IBAction)acceptOptionsSheet:(id)sender;
- (IBAction)cancelOptionsSheet:(id)sender;

- (void) updatePercentages;
- (void)updatePlot;

// Plot data source methods
-(unsigned)numberOfDataClustersForPlot:(NRTPlot *)plot;
-(NSDictionary *)clusterCoordinatesForPlot:(id)plot andDataClusterIndex:(unsigned)entryIndex;

- (IBAction) deliverCenter:(id)sender;


@end
