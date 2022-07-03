using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class BatteryWidget extends Ui.Drawable {
	var _x, _y, _r;
	var battery, font;
	
	function initialize(params) {
		Drawable.initialize(params);
        battery = Math.floor(Sys.getSystemStats().battery);

		font = WatchUi.loadResource(Rez.Fonts.MicroFont);
                
		_x = params[:x];
		_y = params[:y];
		_r = params[:r];
	}

	function onSettingsChanged() {
	}
	
	function draw(dc) {
    	dc.setColor(Gfx.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
		dc.drawCircle(_x, _y, _r);
		
		dc.drawText(_x+2, _y-10, font, battery.format("%d") + "%", Graphics.TEXT_JUSTIFY_CENTER);
		dc.setColor(Gfx.COLOR_DK_RED, Graphics.COLOR_TRANSPARENT);
		dc.setPenWidth(3);
		var batteryPercentage = battery/100;
		dc.drawArc(_x, _y, _r, Graphics.ARC_COUNTER_CLOCKWISE, 0, 360*batteryPercentage);
		dc.setPenWidth(1);
        
	}

}