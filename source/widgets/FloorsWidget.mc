using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Mon;
using Toybox.Test;

class FloorsWidget extends Ui.Drawable {
	var _x, _y, _r;
	var floors,floorsGoal, iconFont, microFont;
	
	function initialize(params) {
		Drawable.initialize(params);

		iconFont = WatchUi.loadResource(Rez.Fonts.MicroIcons);
		microFont = WatchUi.loadResource(Rez.Fonts.MicroFont);
                
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


			dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
			dc.drawText(_x, _y-15, Graphics.FONT_XTINY, floors, Graphics.TEXT_JUSTIFY_CENTER);

			dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawCircle(_x, _y, _r+5);
			dc.setPenWidth(5);
			dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, 240);
			dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
			dc.drawText(_x, _y+_r/2, iconFont, "", Graphics.TEXT_JUSTIFY_CENTER);
			if (floorsPercentage > 0) {
				dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, (300*floorsPercentage)-60);
			}
			dc.setPenWidth(1);

		}
	}

}