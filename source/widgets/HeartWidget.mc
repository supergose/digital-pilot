using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Mon;
using Toybox.Activity as Activity;

class HeartWidget extends Ui.Drawable {
	var _x, _y, iconFont;
    var heartIcon = "";
	var heartRate = "";
	
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
		
	    	heartRate = getHeartRate();
	    					
		    dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
			dc.drawText(
				_x-1,
				_y-1,
				iconFont,
				heartIcon,
				Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER
			);
			
	        dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
	        dc.drawText(
				_x+1,
				_y,
				Graphics.FONT_XTINY,
				heartRate,
				Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
			);
	
		}
		
	}
	
	private function getHeartRate() {
		var activityInfo = Activity.getActivityInfo();
		var sample = activityInfo.currentHeartRate;
		var value = "--";
		if (sample != null) {
			value = sample.format(INTEGER_FORMAT);
		} else if (ActivityMonitor has :getHeartRateHistory) {
			sample = ActivityMonitor.getHeartRateHistory(1, /* newestFirst */ true)
				.next();
			if ((sample != null) && (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
				value = sample.heartRate.format(INTEGER_FORMAT);
			}
		}
		return value;
	}

}