'use strict';
define(['brease/enum/Enum'], function (Enum) {
  
    const Utils = {

        cssCalculator: {
            'top': function (scaleFactor) {
                var pos = (this.startDistance.top - (this.pageY - this.offsetTop - this.mouseOffsetY) / scaleFactor) * -1;
                if (pos > 0) {
                    return { left: 0 };
                } else if (Math.abs(pos) > this.distance) {
                    return { top: -this.distance };
                } else {
                    return { top: pos };
                }
            },
            'bottom': function (scaleFactor) {
                var offset = (this.startY - this.pageY) / scaleFactor;
                var pos = this.startDistance.bottom - offset;
                if (pos < 0) {
                    return { top: 0 };
                } else if (pos > this.distance) {
                    return { top: this.distance };
                } else {
                    return { top: pos };
                } 
            },
            'left': function (scaleFactor) {
                var pos = (this.startDistance.left - (this.pageX - this.offsetLeft - this.mouseOffsetX) / scaleFactor) * -1;
                if (pos > 0) {
                    return { left: 0 };
                } else if (Math.abs(pos) > this.distance) {
                    return { left: -this.distance };
                } else {
                    return { left: pos };
                }
            },
            'right': function (scaleFactor) {
                var offset = (this.offsetLeft - this.startX) / scaleFactor + this.el.width();
                if (this.startDistance.right <= 0) {
                    offset -= this.distance;
                }
                var pos = (this.offsetLeft - this.pageX) / scaleFactor - offset + this.el.width() - this.distance;
                if (pos > 0) {
                    return { right: 0 };
                } else if (Math.abs(pos) > this.distance) {
                    return { right: -this.distance };
                } else {
                    return { right: pos };
                }
            }
        },

        getPageX: function (e) {
            return (e.originalEvent && e.originalEvent.touches && e.originalEvent.touches.length > 0) ? e.originalEvent.touches[0].pageX : e.pageX;
        },

        getPageY: function (e) {
            return (e.originalEvent && e.originalEvent.touches && e.originalEvent.touches.length > 0) ? e.originalEvent.touches[0].pageY : e.pageY;
        }
    };
    
    return Utils;

});
