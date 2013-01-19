//
//  MWDebuggerWindowController.h
//  MWorksDebugger
//
//  Created by David Cox on 2/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MWorksCocoa/MWWindowController.h"
#import "MWorksCocoa/MWClientProtocol.h"
#import "MWorksCore/GenericData.h"
#import "Narrative/Narrative.h" // new

NSString *FROZEN_STRING = @"Frozen";
NSString *ACTIVE_STRING = @"Active";
NSString *DISABLED_STRING = @"Disabled";

@protocol MWDataEventListenerProtocol;


@interface RatBehaviorControlPanelController : NSWindowController {
    
    // NEW STUFF:
    // editable text field	(this contains the variable to screen in the data stream)
    IBOutlet NSTextField *TargetprobVariableField;
    
    IBOutlet NSTextField *NumberOfTargetprobField;
    IBOutlet NSTextField *NumberOfTotalField;
    
    IBOutlet NSTextField *ValuesTargetprobField;

    IBOutlet NSWindow	*optionsSheet;
    
    IBOutlet NRTXYChart *chart;
    NRTScatterPlot *valuesTargetprobPlot;
    
    int TargetprobCodecCode; // codec num for variable
    
    // class vairables
    int numberOfTargetprobTrials;
    int	numberOfTrials; 
    
    int valuesTargetprob;
    
    NSMutableArray *valuesTargetprobHistory;
    NSMutableArray *totalHistory;
    int maxHistory;
    
    int numberOfTargetprobTrialsInSession;
    int numberOfTrialsInSession;
    
    int valuesTargetprobInSession; // new
    
    BOOL VariableCheck;
    
    
    // old
	IBOutlet id delegate;
	NSArray *staircaseStates;
    
}

//more new
@property int numberOfTargetprobTrials;
@property int numberOfTrials;

@property int valuesTargetprob; 

@property int numberOfTargetprobTrialsInSession;
@property int numberOfTrialsInSession; 

@property int valuesTargetprobInSession;

@property(assign) NSArray *staircaseStates;

- (void)awakeFromNib;
- (void)setDelegate:(id)new_delegate;

- (IBAction)resetPerformance:(id)sender; // new stuff, until "deliverCenter"
- (IBAction)resetPerformanceInSession:(id)sender;

- (IBAction)launchOptionsSheet:(id)sender;
- (IBAction)acceptOptionsSheet:(id)sender;
- (IBAction)cancelOptionsSheet:(id)sender;

- (void) updatePercentages;
- (void)updatePlot;

// Plot data source methods
-(unsigned)numberOfDataClustersForPlot:(NRTPlot *)plot;
-(NSDictionary *)clusterCoordinatesForPlot:(id)plot
    andDataClusterIndex:(unsigned)entryIndex;

- (IBAction) deliverCenter:(id)sender;


@end
