using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Mon;
using Toybox.Test;

class StepsWidget extends Ui.Drawable {
	var _x, _y, _r;
	var steps, stepsGoal, iconFont, microFont;
	
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
			
			steps = Mon.getInfo().steps;
			stepsGoal = Mon.getInfo().stepGoal;
			var stepsPercentage = steps.toFloat()/stepsGoal.toFloat();
			if (stepsPercentage > 1) {
				stepsPercentage = 1;
			}


			dc.setColor(Gfx.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
			dc.drawText(_x, _y-15, Graphics.FONT_XTINY, steps, Graphics.TEXT_JUSTIFY_CENTER);

			dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawCircle(_x, _y, _r+5);
			dc.setPenWidth(5);
			dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, 240);
			dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
			dc.drawText(_x, _y+_r/2, iconFont, "", Graphics.TEXT_JUSTIFY_CENTER);
			if (stepsPercentage > 0) {
				dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, -60, (300*stepsPercentage)-60);
			}
			dc.setPenWidth(1);
			/*
			dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawCircle(_x, _y, _r);
			
			dc.drawText(_x+2, _y-10, font, steps, Graphics.TEXT_JUSTIFY_CENTER);
			dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
			
			if (stepsPercentage > 0) {
				dc.setPenWidth(3);
				dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, 0, 360*stepsPercentage);
				dc.setPenWidth(1);
			}
			*/
		}
	}

}