using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Mon;
using Toybox.Test;

class FloorsWidget extends Ui.Drawable {
	var _x, _y, _r;
	var floors,floorsGoal, font;
	
	function initialize(params) {
		Drawable.initialize(params);
		font = WatchUi.loadResource(Rez.Fonts.MicroFont);
                
		_x = params[:x];
		_y = params[:y];
		_r = params[:r];
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {

		if (Sys.getDeviceSettings().activityTrackingOn) {
			
			floors = Mon.getInfo().floorsClimbed;
			floorsGoal = Mon.getInfo().floorsClimbedGoal;
			var floorsPercentage = floors.toFloat()/floorsGoal.toFloat();
			dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawCircle(_x, _y, _r);
			
			dc.drawText(_x+2, _y-10, font, floors, Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
			dc.setPenWidth(3);
			dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, 0, 360*floorsPercentage);
			dc.setPenWidth(1);
		}
	}

}