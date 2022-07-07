using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Mon;
using Toybox.Position as Pos;
using Toybox.Activity as Activity;
using Toybox.SensorHistory as SensorHistory;

class AltitudeWidget extends Ui.Drawable {
	var _x, _y, sl_x, sl_y, iconFont;
    var terrainIcon = "";
	var altitude;
	
	function initialize(params) {
		Drawable.initialize(params);
		iconFont = WatchUi.loadResource(Rez.Fonts.MicroIcons);
		
		_x = params[:x];
		_y = params[:y];
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {
		if (Sys.getDeviceSettings().activityTrackingOn) {
			
		    dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
			dc.drawText(
				_x,
				_y-1,
				iconFont,
				terrainIcon,
				Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER
			);
	    
	        dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	        dc.drawText(
				_x+1,
				_y,
				Graphics.FONT_XTINY,
				retrieveAltitudeText(),
				Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
			);
	
		}
		
	}
	
    private function retrieveAltitudeText() {
		var activityInfo = Activity.getActivityInfo();
		var altitude = activityInfo.altitude;
		var value = "";
		var unit = "m";
		var sample;
		
		if ((altitude == null) && (Toybox has :SensorHistory) && (Toybox.SensorHistory has :getElevationHistory)) {
			sample = SensorHistory.getElevationHistory({ :period => 1, :order => SensorHistory.ORDER_NEWEST_FIRST })
				.next();
			if ((sample != null) && (sample.data != null)) {
				altitude = sample.data;
			}
		}
		if (altitude != null) {
			value = altitude.format(INTEGER_FORMAT);
		}
		
		return value + unit;
    }
	
}