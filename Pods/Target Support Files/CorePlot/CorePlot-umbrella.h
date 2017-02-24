#ifdef __OBJC__
#import <UIKit/UIKit.h>
#endif

#import "CPTAnimation.h"
#import "CPTAnimationOperation.h"
#import "CPTAnimationPeriod.h"
#import "CPTAnnotation.h"
#import "CPTAnnotationHostLayer.h"
#import "CPTAxis.h"
#import "CPTAxisLabel.h"
#import "CPTAxisLabelGroup.h"
#import "CPTAxisSet.h"
#import "CPTAxisTitle.h"
#import "CPTBarPlot.h"
#import "CPTBorderedLayer.h"
#import "CPTCalendarFormatter.h"
#import "CPTColor.h"
#import "CPTColorSpace.h"
#import "CPTConstraints.h"
#import "CPTDebugQuickLook.h"
#import "CPTDefinitions.h"
#import "CPTDerivedXYGraph.h"
#import "CPTExceptions.h"
#import "CPTFill.h"
#import "CPTFunctionDataSource.h"
#import "CPTGradient.h"
#import "CPTGraph.h"
#import "CPTGridLineGroup.h"
#import "CPTGridLines.h"
#import "CPTImage.h"
#import "CPTLayer.h"
#import "CPTLayerAnnotation.h"
#import "CPTLegend.h"
#import "CPTLegendEntry.h"
#import "CPTLimitBand.h"
#import "CPTLineCap.h"
#import "CPTLineStyle.h"
#import "CPTMutableLineStyle.h"
#import "CPTMutableNumericData+TypeConversion.h"
#import "CPTMutableNumericData.h"
#import "CPTMutablePlotRange.h"
#import "CPTMutableShadow.h"
#import "CPTMutableTextStyle.h"
#import "CPTNumericData+TypeConversion.h"
#import "CPTNumericData.h"
#import "CPTNumericDataType.h"
#import "CPTPathExtensions.h"
#import "CPTPieChart.h"
#import "CPTPlot.h"
#import "CPTPlotArea.h"
#import "CPTPlotAreaFrame.h"
#import "CPTPlotGroup.h"
#import "CPTPlotRange.h"
#import "CPTPlotSpace.h"
#import "CPTPlotSpaceAnnotation.h"
#import "CPTPlotSymbol.h"
#import "CPTRangePlot.h"
#import "CPTResponder.h"
#import "CPTScatterPlot.h"
#import "CPTShadow.h"
#import "CPTTextLayer.h"
#import "CPTTextStyle.h"
#import "CPTTheme.h"
#import "CPTTimeFormatter.h"
#import "CPTTradingRangePlot.h"
#import "CPTUtilities.h"
#import "CPTXYAxis.h"
#import "CPTXYAxisSet.h"
#import "CPTXYGraph.h"
#import "CPTXYPlotSpace.h"
#import "NSCoderExtensions.h"
#import "NSDecimalNumberExtensions.h"
#import "NSNumberExtensions.h"
#import "CorePlot.h"
#import "CorePlot-CocoaTouch.h"
#import "CPTGraphHostingView.h"
#import "CPTPlatformSpecificCategories.h"
#import "CPTPlatformSpecificDefines.h"
#import "CPTPlatformSpecificFunctions.h"
#import "CPTTextStylePlatformSpecific.h"

FOUNDATION_EXPORT double CorePlotVersionNumber;
FOUNDATION_EXPORT const unsigned char CorePlotVersionString[];
