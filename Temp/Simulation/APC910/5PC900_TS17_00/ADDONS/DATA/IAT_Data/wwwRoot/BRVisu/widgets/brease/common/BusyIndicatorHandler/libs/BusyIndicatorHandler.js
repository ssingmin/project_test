define([
    'brease/core/Class',
    'brease/core/Utils'
], function (
    SuperClass, Utils
) {

    'use strict';

    /**
    * @class widgets.brease.common.BusyIndicatorHandler.libs.BusyIndicatorHandler
    * @extends brease.core.Class
    * module to handle the busy indicator Widget. 
    */
    /**
    * @method constructor
    * @param {Object} widget reference to widget creating the instance
    */
    var BusyIndicatorHandler = SuperClass.extend(function BusyIndicatorHandler(widget) {
            SuperClass.apply(this, arguments);
            this.widget = widget;
        }, null),

        p = BusyIndicatorHandler.prototype;

    p.dispose = function () {
        var widget = this.widget;
        
        this._resetTimeout();

        if (this.widget.busyWrapper) {
            brease.uiController.dispose(widget.busyWrapper, false, function () {
                widget.busyWrapper.remove();
                widget.busyWrapper = null;
                widget.busyId = null;
                widget.busyIndicator = null;
            }); 
        }
    };

    p._resetTimeout = function () {
        if (this.busyIndicatorTimout) {
            window.clearTimeout(this.busyIndicatorTimout);
            this.busyIndicatorTimout = null;
        }
    };

    p._setTimeout = function (widget, busyIndicatorDelay) {
        this._resetTimeout();
        this.busyIndicatorTimout = window.setTimeout(function () { widget.busyWrapper.css('visibility', 'visible'); }, busyIndicatorDelay);
    };

    p.showBusyIndicator = function () {
        if (brease.config.editMode || this.widget.settings.busyIndicatorDelay < 0) { return; }

        if (this.widget.busyWrapper) {
            var busyIndicatorDelay = 0;

            if (this.widget.settings.busyIndicatorDelay) {
                busyIndicatorDelay = this.widget.settings.busyIndicatorDelay;
            }
            if (busyIndicatorDelay === 0) { 
                this.widget.busyWrapper.css('visibility', 'visible');
            } else {
                this._setTimeout(this.widget, busyIndicatorDelay);
            }
        }
    };

    p.hideBusyIndicator = function () {
        if (this.widget.busyWrapper) {
            this.widget.busyWrapper.css('visibility', 'hidden');
            this._resetTimeout();
        }
    };

    p.createBusyIndicator = function (cssObject) {
        var widget = this.widget,
            stdCssObject = { 
                'z-Index': '9999', 
                'position': 'absolute',
                'top': '0px',
                'left': '0px',
                'width': '100%',
                'height': '100%',
                'background-color': '#fff',
                'opacity': 0.5,
                'display': 'inline-flex',
                'align-items': 'center',
                'justify-content': 'center',
                'visibility': 'hidden'
            };

        if (cssObject) {
            stdCssObject = cssObject;
        }
            
        if (!widget.busyWrapper) {    
            widget.busyId = Utils.uniqueID(widget.elem.id + '_busyIndicator');
            widget.busyWrapper = $('<div class="busyWrapper"/>');
            widget.busyWrapper.css(stdCssObject);
            widget.el.append(widget.busyWrapper);

            brease.uiController.createWidgets(widget.busyWrapper[0], [
                {
                    className: 'widgets.brease.BusyIndicator',
                    id: widget.busyId,
                    options: {}
                }
            ], true, widget.settings.parentContentId);
        }
    };

    return BusyIndicatorHandler;
});
