using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class TimeWidget extends Ui.Drawable {
	var _x, _y, hoursFont, minutesFont;
	var hoursColor = App.getApp().getProperty("HoursColor");
	
	function initialize(params) {
		Drawable.initialize(params);
		
		hoursFont = WatchUi.loadResource(Rez.Fonts.HoursFont);
        minutesFont = WatchUi.loadResource(Rez.Fonts.MinutesFont);
        
		_x = params[:x];
		_y = params[:y];
	}

	function onSettingsChanged() {
		hoursColor = App.getApp().getProperty("HoursColor");
	}
	
	function draw(dc) {
		var timeFormat = "$1$:$2$";
     	
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        var mins = clockTime.min.format("%02d");
        
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        }
    
    	hours = hours.format("%02d");
        if (!App.getApp().isSleeping) {
			dc.setColor(hoursColor, Graphics.COLOR_TRANSPARENT);
			dc.drawText(
				_x,
				_y,
				hoursFont,
				hours,
				Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER
			);
			
			dc.setColor(Gfx.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawText(
				_x,
				_y,
				minutesFont,
				mins,
				Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
			);
		} else {
			dc.setColor(Gfx.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
			dc.drawText(
				_x,
				_y,
				Gfx.FONT_LARGE,
				hours + " " + mins,
				Graphics.TEXT_JUSTIFY_CENTER
			);
		}
/*
		dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		dc.drawCircle(210, 70, 60);
		dc.drawCircle(310, 90, 35);
*/
	}

}