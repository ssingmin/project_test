define([
    'brease/core/ContainerWidget',
    'brease/events/BreaseEvent',
    'brease/enum/Enum',
    'brease/core/Utils',
    'brease/controller/PopUpManager',
    'brease/controller/libs/KeyActions',
    'widgets/brease/FlyOut/libs/Utils',
    'widgets/brease/common/libs/HideableWidgetEvents',
    'widgets/brease/common/libs/HideableWidgetState'
], function (SuperClass, BreaseEvent, Enum, Utils, popupManager, KeyActions,
    FlyOutUtils, HideableWidgetEvents, HideableWidgetState) {
    'use strict';
    /**
     * @class widgets.brease.FlyOut
     * @extends brease.core.ContainerWidget
     * @requires widgets.brease.ToggleButton
     *
     * @iatMeta studio:visible
     * true
     * @iatMeta studio:license
     * licensed
     * @iatMeta studio:isContainer
     * true
     *
     * @iatMeta category:Category
     * Container
     * @iatMeta description:short
     * Ausblendbares Containerfeld
     * @iatMeta description:de
     * Ausblendbarer Container
     * @iatMeta description:en
     * Hideable container
     */

    /**
     * @property {WidgetList} parents=["system.brease.Content"]
     * @inheritdoc  
     */

    /**
     * @cfg {brease.enum.ImageAlign} docking='left'
     * @iatStudioExposed
     * @iatCategory Appearance
     * position of the flyout widget
     */

    /**
     * @cfg {ImagePath} image=''
     * @iatStudioExposed
     * @bindable
     * @iatCategory Appearance
     * Path to an optional image.
     * When svg - graphics are used, be sure that in your *.svg-file height and width attributes are specified on the svg-element.
     * For more detailed information see https://www.w3.org/TR/SVG/struct.html (chapter 5.1.2)
     */

    /**
     * @cfg {Boolean} autoClose=false
     * @iatStudioExposed
     * @iatCategory Behavior
     * close Flyout on click outside the content
     * if true and the FlyOut is open and the user clicks somewhere outside the FlyOut, it closes automatically
     */

    /**
     * @cfg {brease.enum.ImageAlign} imageAlign='left'
     * @iatStudioExposed
     * @iatCategory Appearance
     * Position of image relative to text.
     */

    /**
     * @cfg {String} text=''
     * @localizable
     * @iatStudioExposed
     * @bindable
     * @iatCategory Appearance
     * Text displayed in the FlyOut button
     */

    /**
     * @cfg {Integer} buttonOffset=0
     * @iatStudioExposed
     * @iatCategory Appearance
     * Offset of the button
     */

    /**
     * @cfg {brease.enum.DialogMode} mode='modeless'
     * @iatStudioExposed
     * @iatCategory Behavior
     * Similar to a pop-up dialog window, this option determines if the user can ('modeless') or cannot ('modal') interact with the remainder of the UI.
     */

    /**
     * @cfg {Boolean} showOnTop=false
     * @iatStudioExposed
     * @iatCategory Behavior
     * When TRUE, forces the FlyOut above all other elements in the visualization.
     */

    /**
     * @cfg {Boolean} showButton=true
     * @iatStudioExposed
     * @iatCategory Behavior
     * When FALSE, this property makes the FlyOut button invisible. The FlyOut must then be opened and closed via the widget's actions (Open, Close, Toggle).
     */

    /**
     * @cfg {StyleReference} buttonStyle='default'
     * @iatStudioExposed
     * @iatCategory Appearance
     * @typeRefId widgets.brease.ToggleButton
     * Style of the Button
     * Use the styles of the widget ToggleButton
     */

    /**
     * @cfg {Boolean} ellipsis=false
     * @iatStudioExposed
     * @iatCategory Behavior
     * If true, overflow of text is symbolized with an ellipsis. This option has no effect, if wordWrap = true.
     */

    /**
     * @cfg {Boolean} wordWrap=false
     * @iatStudioExposed
     * @iatCategory Behavior
     * If true, text will wrap when necessary.
     * This property has no effect, if multiLine=false
     */

    /**
     * @cfg {Boolean} multiLine=false
     * @iatStudioExposed
     * @iatCategory Behavior
     * If true, more than one line is possible.
     * Text will wrap when necessary (if property wordWrap is set to true) or at explicit line breaks (\n).
     * If false, text will never wrap to the next line. The text continues on the same line.
     */
    
    /**
     * @method showTooltip
     * @hide
     */

    var defaultSettings = {
            docking: Enum.ImageAlign.left,
            buttonHeight: 50,
            buttonWidth: 50,
            buttonOffset: 0,
            buttonImageAlign: Enum.ImageAlign.left,
            ellipsis: false,
            wordWrap: false,
            multiLine: false,
            mode: Enum.DialogMode.MODELESS,
            showOnTop: false,
            showButton: true,
            dimmerOn: false,
            buttonStyle: 'default',
            autoClose: false,
            // styling information used as calculation base.. set default values here
            width: 100,
            height: 200,
            focusable: false
        },

        WidgetClass = SuperClass.extend(function FlyOut() {
            SuperClass.apply(this, arguments);
        }, defaultSettings),

        p = WidgetClass.prototype;

    p.init = function () {

        var widget = this;

        if (this.settings.omitClass !== true) {
            this.addInitialClass('breaseFlyOut');
        }
        this.addInitialClass('breaseHideableContentControlContainer');
        this.internal = {
            state: HideableWidgetState.CLOSED
        };
        if (brease.config.editMode) {
            this.settings.enable = true;
        }
        SuperClass.prototype.init.call(this, true);
        this.contentWrapper = this.container;

        this.el.wrapInner('<div class="breaseFlyOutWrapper" />');
        this.flyOutWrapper = this.el.find('.breaseFlyOutWrapper').addClass('breaseHideableContentControlContainer').data('widgetid', this.elem.id);

        //add button
        this.buttonId = Utils.uniqueID(this.elem.id + '_child');
        this.flyOutWrapper.one(BreaseEvent.CONTENT_PARSED, this._bind('_wrapperParsedHandler'));
        this.flyOutReady = new $.Deferred();
        this.flyOutReady.promise();

        this.toggleButtonReady = new $.Deferred();
        this.toggleButtonReady.promise();

        this.el.on(BreaseEvent.WIDGET_READY, widget._bind('_widgetReadyHandler'));
        this.flyOutWrapper.on(BreaseEvent.WIDGET_READY, widget._bind('_buttonReadyHandler'));
        this.bodyWrapper = $("<div class='breaseFlyOut' />")
            .attr('id', this.elem.id + '_breaseFlyOutWrapper');
        if (!brease.config.editMode) {
            this.bodyWrapper.css({ top: 0, left: 0 });
        }
        
        this._initEventHandler();

        _createDimmer.call(this);

        this.settings.buttonTooltip = this.settings.tooltip;
        this.settings.tooltip = '';

        brease.uiController.createWidgets(this.flyOutWrapper[0], [{
            className: 'widgets.brease.ToggleButton',
            id: this.buttonId,
            options: $.extend(true, this.settings.buttonSettings,
                {
                    text: this.settings.text,
                    image: this.settings.image,
                    imageAlign: this.settings.imageAlign,
                    ellipsis: this.settings.ellipsis,
                    wordWrap: this.settings.wordWrap,
                    multiLine: this.settings.multiLine,
                    style: this.settings.buttonStyle,
                    tooltip: this.settings.buttonTooltip,
                    droppable: false,
                    omitDisabledClick: true,
                    tabIndex: this.settings.tabIndex
                })
        }], true, this.settings.parentContentId);

        this.setStyle(this.settings.style);

        if (!brease.config.editMode) {
            _setInitialZIndex(this);
            if (this.isHidden) {
                _setVisibility.call(this, this.isHidden);
            }
        }
    };
    p._initEditor = function () {
        var widget = this;
        require(['widgets/brease/FlyOut/libs/EditorHandles'], function (EditorHandles) {
            var editorHandles = new EditorHandles(widget);

            widget.getHandles = function () {
                return editorHandles.getHandles();
            };

            widget.isRotatable = function () {
                return editorHandles.isRotatable();
            };

            widget.designer.getSelectionDecoratables = function () {
                return editorHandles.getSelectionDecoratables();
            };
            widget.designer.trySetProperty = function (name, value) {
                return editorHandles.trySetProperty(name, value);
            };
        });

        // Provide access to function for designer
        this._updateEditDimensions = function () {
            _updateEditDimensions.call(this);
        };

        this.el.css('overflow', 'visible');
    };
    p.setStyle = function (style) {
        if (this.bodyWrapper) {
            this.bodyWrapper.removeClass(this.settings.stylePrefix + '_style_' + this.settings.style);
        }
        SuperClass.prototype.setStyle.call(this, style);
        if (this.bodyWrapper) {
            this.bodyWrapper.addClass(this.settings.stylePrefix + '_style_' + this.settings.style);
        }
    };

    /**
     * @method setDocking
     * Sets docking
     * @param {brease.enum.ImageAlign} docking
     */
    p.setDocking = function (docking) {
        this.settings.docking = docking;

        if (brease.config.editMode) {

            this.flyOutWrapper.css({ top: 'auto', left: 'auto', right: 'auto', bottom: 'auto' });
            this.elem.style.removeProperty('left');
            this.elem.style.removeProperty('top');
            this.elem.style.removeProperty('right');
            this.elem.style.removeProperty('bottom');
            this.bodyWrapper.css({ top: 'auto', left: 'auto', right: 'auto', bottom: 'auto' });
            this.button.css('position', 'relative');
            this.container.css('position', 'relative');
            this.container.css('bottom', 'auto');
            switch (this.settings.docking) {

                case Enum.ImageAlign.top:
                case Enum.ImageAlign.bottom:
                {
                    this.distance = parseInt(this.settings.height, 10);
                    this.bodyWrapper.css({
                        width: this.contentWrapper.outerWidth(),
                        height: this.contentWrapper.outerHeight() + this.button.outerHeight()
                    });
                    break;
                }
                case Enum.ImageAlign.left:
                case Enum.ImageAlign.right:
                {
                    this.distance = parseInt(this.settings.width, 10);
                    this.bodyWrapper.css({
                        width: this.contentWrapper.outerWidth() + this.button.outerWidth(),
                        height: this.contentWrapper.outerHeight()
                    });
                    break;
                }

            }

            if (this.el.hasClass('show')) {
                _updateDocking.call(this);
                _updateEditDimensions.call(this);
            } else {
                this.show();
                _updateDocking.call(this);
                _updateEditDimensions.call(this);
                this.hide();
            }
        }
    };

    /**
     * @method getDocking 
     * Returns docking.
     * @return {brease.enum.ImageAlign}
     */
    p.getDocking = function () {
        return this.settings.docking;
    };

    /**
     * @method setImage
     * @iatStudioExposed
     * Sets image
     * @param {ImagePath} image
     */
    p.setImage = function (image) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.image = image;
            brease.callWidget(self.buttonId, 'setImage', self.settings.image);
        });
    };

    /**
     * @method getImage 
     * Returns image.
     * @return {ImagePath}
     */
    p.getImage = function () {
        return this.settings.image;
    };

    /**
     * @method setAutoClose
     * Sets autoClose
     * @param {Boolean} autoClose
     */
    p.setAutoClose = function (autoClose) {
        this.settings.autoClose = autoClose;
        if (!autoClose) {
            _removeOptionalAutoCloseListener(this);
        }
    };

    /**
     * @method getAutoClose 
     * Returns autoClose.
     * @return {Boolean}
     */
    p.getAutoClose = function () {
        return this.settings.autoClose;
    };

    /**
     * @method setImageAlign
     * Sets imageAlign
     * @param {brease.enum.ImageAlign} imageAlign
     */
    p.setImageAlign = function (imageAlign) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.imageAlign = imageAlign;
            brease.callWidget(self.buttonId, 'setImageAlign', self.settings.imageAlign);
        });
    };

    /**
     * @method getImageAlign 
     * Returns imageAlign.
     * @return {brease.enum.ImageAlign}
     */
    p.getImageAlign = function () {
        return this.settings.imageAlign;
    };

    /**
    * @method setText
    * @iatStudioExposed
    * Sets text
    * @param {String} text
    * @paramMeta text:localizable=true
    */
    p.setText = function (text) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.text = text;
            brease.callWidget(self.buttonId, 'setText', self.settings.text);
        });
    };

    /**
     * @method getText 
     * Returns text.
     * @return {String}
     */
    p.getText = function () {
        return this.settings.text;
    };

    /**
     * @method setButtonOffset
     * Sets buttonOffset
     * @param {Integer} buttonOffset
     */
    p.setButtonOffset = function (buttonOffset) {
        this.settings.buttonOffset = buttonOffset;

        if (brease.config.editMode) {
            this._setButtonOffset();
            _updateEditDimensions.call(this);
        }
    };

    /**
     * @method getButtonOffset 
     * Returns buttonOffset.
     * @return {Integer}
     */
    p.getButtonOffset = function () {
        return this.settings.buttonOffset;
    };

    /**
     * @method setButtonStyle
     * Sets buttonStyle
     * @param {StyleReference} buttonStyle
     */
    p.setButtonStyle = function (buttonStyle) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.buttonStyle = buttonStyle;
            brease.callWidget(self.buttonId, 'setStyle', self.settings.buttonStyle);
        });
    };

    /**
     * @method getButtonStyle 
     * Returns buttonStyle.
     * @return {String}
     */
    p.getButtonStyle = function () {
        return this.settings.buttonStyle;
    };

    /**
     * @method setMode
     * Sets the dialog mode for the FlyOut
     * @param {brease.enum.DialogMode} mode
     */
    p.setMode = function (mode) {
        this.settings.mode = mode;
        _createDimmer.call(this);
    };

    /**
     * @method getMode 
     * Returns status for dialog mode property.
     * @return {brease.enum.DialogMode}
     */
    p.getMode = function () {
        return this.settings.mode;
    };

    /**
     * @method setShowOnTop
     * Sets the stacking mode for the FlyOut
     * @param {Boolean} showOnTop
     */
    p.setShowOnTop = function (showOnTop) {
        this.settings.showOnTop = showOnTop;
    };

    /**
     * @method getShowOnTop
     * Returns the stacking mode for the FlyOut
     * @return {Boolean}
     */
    p.getShowOnTop = function () {
        return this.settings.showOnTop;
    };

    /**
      * @method setShowButton
      * Configures whether or not to use the FlyOut button
      * @param {Boolean} showButton
      */
    p.setShowButton = function (showButton) {
        this.settings.showButton = showButton;

        if (brease.config.editMode) {
            this._setButtonVisibility();
        }
    };

    /**
     * @method getShowButton
     * Returns the status of the showButton property
     * @return {Boolean}
     */
    p.getShowButton = function () {
        return this.settings.showButton;
    };

    /**
     * @method setEllipsis
     * Sets ellipsis
     * @param {Boolean} ellipsis
     */
    p.setEllipsis = function (ellipsis) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.ellipsis = ellipsis;
            brease.callWidget(self.buttonId, 'setEllipsis', self.settings.ellipsis);
        });
    };

    /**
     * @method getEllipsis 
     * Returns ellipsis.
     * @return {Boolean}
     */
    p.getEllipsis = function () {
        return this.settings.ellipsis;
    };

    /**
     * @method setWordWrap
     * Sets wordWrap
     * @param {Boolean} wordWrap
     */
    p.setWordWrap = function (wordWrap) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.wordWrap = wordWrap;
            brease.callWidget(self.buttonId, 'setWordWrap', self.settings.wordWrap);
        });
    };

    /**
     * @method getWordWrap 
     * Returns wordWrap.
     * @return {Boolean}
     */
    p.getWordWrap = function () {
        return this.settings.wordWrap;
    };

    /**
     * @method setMultiLine
     * Sets multiLine
     * @param {Boolean} multiLine
     */
    p.setMultiLine = function (multiLine) {
        var self = this;

        $.when(this.flyOutReady).done(function () {
            self.settings.multiLine = multiLine;
            brease.callWidget(self.buttonId, 'setMultiLine', self.settings.multiLine);
        });
    };

    /**
     * @method getMultiLine 
     * Returns multiLine.
     * @return {Boolean}
     */
    p.getMultiLine = function () {
        return this.settings.multiLine;
    };

    /**
     * @method open
     * @iatStudioExposed
     * Open the FlyOut widget.
     */
    p.open = function () {
        if (this.isDisabled) { return; }
        if (this.internal.state === HideableWidgetState.CLOSED) {
            this._setStateAndDispatch(HideableWidgetState.TRANSITION, HideableWidgetEvents.BEFORE_OPEN);
        }
        _setZIndex(this);
        this.show();
        _updateButtonToggleState(this, true);
    };

    /**
     * @method close
     * @iatStudioExposed
     * Close the FlyOut widget.
     */
    p.close = function () {
        if (this.isDisabled) { return; }
        if (this.internal.state === HideableWidgetState.OPEN) {
            this._setStateAndDispatch(HideableWidgetState.TRANSITION);
        }
        _resetZIndex(this);
        this.hide();
        _updateButtonToggleState(this, false);
    };

    /**
     * @method toggle
     * @iatStudioExposed
     * Open the FlyOut widget.
     */
    p.toggle = function () {

        if (this.isDisabled) { return; }

        if (this.el.hasClass('show')) {
            if (this.internal.state === HideableWidgetState.OPEN) {
                this._setStateAndDispatch(HideableWidgetState.TRANSITION);
            }
            _resetZIndex(this);
            this.hide();
            _updateButtonToggleState(this, false);
        } else {
            if (this.internal.state === HideableWidgetState.CLOSED) {
                this._setStateAndDispatch(HideableWidgetState.TRANSITION, HideableWidgetEvents.BEFORE_OPEN);
            }
            _setZIndex(this);
            this.show();
            _updateButtonToggleState(this, true);
        }
    };

    p._wrapperParsedHandler = function () {
        this.button = $('#' + this.buttonId);
        this.button.addClass('flyoutButton');
        this._setButtonOffset();
        this._setButtonVisibility();
        
        _updateEditDimensions.call(this);

        if (brease.config.preLoadingState === true) {
            this._dispatchReady();
        } else {
            _addListeners(this);
        }
    };

    p._setButtonOffset = function () {

        if (this.settings.buttonOffset === undefined) {
            return;
        }
        var offset = this.settings.buttonOffset;

        switch (this.settings.docking) {
            case Enum.ImageAlign.top:
                this.button.css('left', offset);
                break;
            case Enum.ImageAlign.right:
                this.button.css('top', offset);
                break;
            case Enum.ImageAlign.bottom:
                this.button.css('left', offset);
                break;

            case Enum.ImageAlign.left:
                this.button.css('top', offset);
                break;
        }
    };

    p._setButtonVisibility = function () {

        if (this.settings.showButton === true) {
            if (!brease.config.editMode) {
                this.button.css('visibility', 'visible');
            } else {
                // cannot set visibility to false --> still need button to operate the FlyOut
                this.button.css('opacity', 1);
                this.button.removeClass('iatd-outline');
            } 
        } else {
            if (!brease.config.editMode) {
                this.button.css('visibility', 'hidden');
            } else {
                // cannot set visibility to false --> still need button to operate the FlyOut
                this.button.css('opacity', 0.1);
                this.button.addClass('iatd-outline');
            }   
        }

    };

    p._setInitialPosition = function () {
        var container;
        window.clearTimeout(this.initPosTmOut);

        var focusElem = document.activeElement;
        // the call 'this.bodyWrapper.append(this.flyOutWrapper)' leads to the loss of the focus => prevent closes in focusout handler
        this.flyOutWrapper.off('focusout', this._bind('_onFocusout'));
        this.bodyWrapper.append(this.flyOutWrapper);
        
        if (brease.config.editMode) {
            this.el.append(this.bodyWrapper);
            container = brease.bodyEl.find('.iatd-content-wrapper');
            if (container.length === 1) { //append only if wrappper is there
                container.append(this.el);
            }
        } else {
            container = this.el.closest('.contentBox');

            if ($.contains(brease.appElem, this.elem) || container.length === 0) {
                brease.bodyEl.append(this.bodyWrapper);
            } else {
                container.append(this.bodyWrapper);
            }
            this.bodyWrapper.before(this.dimmer);
        }
        if (_requiresFocusoutHandler.call(this)) {
            this.flyOutWrapper.on('focusout', this._bind('_onFocusout'));
        }
        _updateDocking.call(this);
        this._initEditDimensions();

        if (this.el.hasClass('move')) {
            this._onTransitionEnd();
        }
        _restoreFocus.call(this, focusElem);
    };

    p.show = function () {
        var cssInfo = {
            top: {
                top: 0,
                left: 0
            },
            right: {
                right: 0,
                top: 0
            },
            bottom: {
                top: 0,
                left: 0
            },
            left: {
                left: 0,
                top: 0
            }
        };
        
        this.el.addClass('show');
        this.bodyWrapper.addClass('show');

        this.flyOutWrapper.css(cssInfo[this.settings.docking]);
        _updateEditDimensions.call(this);

        if (this.settings.mode === Enum.DialogMode.MODAL) {
            this._toggleDimmer(true);
        }

        if (this.settings.autoClose === true) {
            _addOptionalAutoCloseListener(this);
        }
    };

    p.hide = function () {
        var cssObj = {
            left: 0,
            top: 0
        };
        if (this.el.hasClass('show')) {
            this.el.addClass('move');
            this.bodyWrapper.addClass('move');
            this.el.removeClass('show');
            this.bodyWrapper.removeClass('show');
        }
        switch (this.settings.docking) {

            case Enum.ImageAlign.top:

                cssObj = {
                    top: this.distance * -1,
                    left: 0
                };
                break;

            case Enum.ImageAlign.right:

                cssObj = {
                    right: this.distance * -1,
                    top: 0
                };
                break;

            case Enum.ImageAlign.bottom:

                cssObj = {
                    top: this.distance,
                    left: 0
                };
                if (brease.config.editMode) {
                    cssObj = {
                        bottom: this.distance * -1,
                        left: 0
                    };
                }
                break;

            case Enum.ImageAlign.left:

                cssObj = {
                    left: this.distance * -1,
                    top: 0
                };
                break;
        }

        this.flyOutWrapper.css(cssObj);
        
        if (this.settings.mode === Enum.DialogMode.MODAL) {
            this._toggleDimmer(false);
        }

        if (this.settings.autoClose === true) {
            _removeOptionalAutoCloseListener(this);
        }
    };

    p.getButtonId = function () {
        return this.buttonId;
    };

    // Overload 'updateVisibility' from ContainerWidget, BaseWidget
    p.updateVisibility = function (initial) {
        var hidden,
            widget = this;

        $.when(this.flyOutReady).done(function () {
            SuperClass.prototype.updateVisibility.call(widget, initial);
            hidden = widget.isHidden;

            if (widget.button !== undefined) {
                _setVisibility.call(widget, hidden);
            }
        });
    }; 

    p._initEventHandler = function () {
        if (this.bodyWrapper) {
            this.bodyWrapper.on(BreaseEvent.CLICK, this._bind('_clickHandler'));
        }
    };
    
    p._clickHandler = function (e) {
        SuperClass.prototype._clickHandler.call(this, e, { origin: this.elem.id });
    };

    p._toggleChangeHandler = function (e) {
        if (this.isDisabled || brease.config.editMode) { return; }

        if (e.detail.checked === true) {
            if (this.internal.state === HideableWidgetState.CLOSED) {
                this._setStateAndDispatch(HideableWidgetState.TRANSITION, HideableWidgetEvents.BEFORE_OPEN);
            }
            this.show();
            this._toggleStateChangedHandler(true);
        } else {
            this.hide();
            this._toggleStateChangedHandler(false);
        }
    };

    p._resizeEventHandler = function () {
        // A&P 570355: added check of scale factor (nonzero) 
        if (Utils.getScaleFactor(this.elem.parentElement) !== 0) {
            _updateDocking.call(this);
        }
    };

    p._mouseDownHandler = function (e) {
        var widget = this;

        if (this.isDisabled || brease.config.editMode) { return; }
        this._handleEvent(e);

        if ((this.el.hasClass('move') === false) && (this.el.hasClass('show') === false)) {
            _.defer(function () {
                _setZIndex(widget);
            });
            this._setStateAndDispatch(HideableWidgetState.TRANSITION, HideableWidgetEvents.BEFORE_OPEN);
        }

        this.flyOutWrapper.removeClass('transition');
        this.el.addClass('move');
        this.bodyWrapper.addClass('move');

        this.startX = FlyOutUtils.getPageX(e);
        this.startY = FlyOutUtils.getPageY(e);

        this.offsetTop = this.el.offset().top;
        this.offsetLeft = this.el.offset().left;
        this.mouseOffsetY = this.startY - this.offsetTop;
        this.mouseOffsetX = this.startX - this.offsetLeft;

        var cssTop = this.flyOutWrapper.css('top');
        var cssRight = this.flyOutWrapper.css('right');
        var cssLeft = this.flyOutWrapper.css('left');
        this.startDistance = {
            top: ((cssTop !== 'auto') ? parseInt(cssTop, 10) : 0) * -1,
            right: ((cssRight !== 'auto') ? parseInt(cssRight, 10) : 0) * -1,

            bottom: ((cssTop !== 'auto') ? parseInt(cssTop, 10) : 0),
            left: ((cssLeft !== 'auto') ? parseInt(cssLeft, 10) : 0) * -1
        };

        // save scaleFactor for the use in mousemove:
        this.internal.scaleFactor = Utils.getScaleFactor(this.elem.parentElement);
        brease.docEl.on(BreaseEvent.MOUSE_MOVE, this._bind('_mouseMoveHandler'));
        brease.docEl.on(BreaseEvent.MOUSE_UP, this._bind('_mouseUpHandler'));
        // focus on mousedown is prevented with _handleEvent => we have to manually set it 
        this.button.focus();
    };

    p._mouseMoveHandler = function (e) {
        if (this.isDisabled || brease.config.editMode) { return; }
        
        var scaleFactor = this.internal.scaleFactor;
        var cssObj = {};

        this.pageX = FlyOutUtils.getPageX(e);
        this.pageY = FlyOutUtils.getPageY(e);

        var getCssObj = FlyOutUtils.cssCalculator[this.settings.docking];
        if (typeof getCssObj === 'function') {
            cssObj = getCssObj.call(this, scaleFactor); 
        }
        this.flyOutWrapper.css(cssObj);
    };

    p._mouseUpHandler = function (e) {
        var toggleButton = brease.callWidget(this.buttonId, 'widget'),
            internalTarget = false;

        //if _mouseMoveHandler was not called, e.g. with a single click, 
        //this.pageX is undefined or not uptodate -> call getPageX again
        this.pageX = FlyOutUtils.getPageX(e);
        this.pageY = FlyOutUtils.getPageY(e);

        if (e.target.id !== null && e.target.id !== '') {
            internalTarget = this.container.find('#' + e.target.id).length > 0;
        }

        if (this.isDisabled || brease.config.editMode || internalTarget) { return; }
        this._handleEvent(e, true);

        brease.docEl.off(BreaseEvent.MOUSE_UP, this._bind('_mouseUpHandler'));
        brease.docEl.off(BreaseEvent.MOUSE_MOVE, this._bind('_mouseMoveHandler'));

        this.flyOutWrapper.addClass('transition');

        var distY = this.pageY - this.startY,
            distX = this.pageX - this.startX,
            dist;

        switch (this.settings.docking) {

            case Enum.ImageAlign.top:
                dist = distY;
                break;

            case Enum.ImageAlign.right:
                dist = distX * -1;
                break;

            case Enum.ImageAlign.bottom:
                dist = distY * -1;
                break;

            case Enum.ImageAlign.left:
                dist = distX;
                break;
        }

        _handleMoved.call(this, dist);

        this.resetToggleBtnStateTimeout = window.setTimeout(function (widget) {
            if (widget.el.hasClass('show') === false) {
                _resetZIndex(widget);

                if (widget.button.hasClass('checked')) {
                    _updateButtonToggleState(widget, false);
                }
            } else {
                if (widget.button.hasClass('checked') === false) {
                    _updateButtonToggleState(widget, true);
                }
            }
        }, 10, this);

        toggleButton._upHandler(e);
    };

    p._autoCloseHandler = function (e) {
        var actualElementOnClickCoordinates,
            clientRect = this.bodyWrapper.find('.container')[0].getBoundingClientRect(),
            insideCoordinates = false;

        if (Utils.isNumeric(e.clientX) && Utils.isNumeric(e.clientY)) {
            insideCoordinates = e.clientX > clientRect.left && e.clientX < clientRect.right &&
                e.clientY > clientRect.top && e.clientY < clientRect.bottom;
            actualElementOnClickCoordinates = document.elementFromPoint(e.clientX, e.clientY);
        }

        if (e.target !== this.button[0] &&
            !$.contains(this.flyOutWrapper[0], actualElementOnClickCoordinates) &&
            !$.contains(this.flyOutWrapper[0], e.target) &&
            !insideCoordinates) {
            _autoClose(this);
            this.close();
        }
    };

    p._placedInTabItemRepositionHandler = function (e) {
        if (e.detail.visible) {
            this.el.closest('.breaseTabItemContainer').off(BreaseEvent.VISIBILITY_CHANGED, this._bind('_placedInTabItemRepositionHandler'));
            _updateDocking.call(this);
        }
    };

    p.setEnable = function (value) {
        if (brease.config.editMode !== true) {
            _setEnable.call(this, value);
            SuperClass.prototype.setEnable.apply(this, arguments);
        }
    };

    p._setDimmer = function () {
        if (this.dimmer !== undefined) {
            this.dimmer.css('display', 'block').removeClass('init-only');
            _disableScroll.call(this);
        }
    };

    p._removeDimmer = function () {
        if (this.dimmer !== undefined) {
            _updateModalOverlays();
            this.dimmer.removeClass('active');
            this.dimmer.css({ display: 'none' });
        }
    };

    /**
     * @event ToggleStateChanged
     * @iatStudioExposed
     * Event returns a boolean value of 'TRUE' once the FlyOut widget is expanded (opened), and 'FALSE' when the FlyOut is collapsed (closed).
     * @param {Boolean} newValue
     */
    p._toggleStateChangedHandler = function (val) {
        this.createEvent('ToggleStateChanged', { newValue: val }).dispatch();
    };

    p._toggleDimmer = function (val) {

        if (!brease.config.editMode) {
            if (val && !this.settings.dimmerOn) {
                this.settings.dimmerOn = true;
                var currZIndex = popupManager.getHighestZindex();
                this._setDimmer(currZIndex);
                _updateModalOverlays();
            } else if (!val && this.settings.dimmerOn) {
                this.settings.dimmerOn = false;
                this._removeDimmer();
                _enableScroll.call(this);
            }
        }
    };

    p._widgetReadyHandler = function (e) {
        var self = this;

        if (e.target.id === self.elem.id) {
            $.when(self.toggleButtonReady).done(function () {
                self.flyOutReady.resolve();
            });
        }
    };

    p._buttonReadyHandler = function (e) {
        var self = this;

        if (e.target.id === self.buttonId) {
            self.toggleButtonReady.resolve();
        }
    };

    /**
    * @method focus
    * @iatStudioExposed
    * Sets focus on the widget button element, if it can be focused and keyboardOperation=true
    * overrides BaseWidget.focus
    */
    p.focus = function () {
        return brease.callWidget(this.buttonId, 'focus');
    };

    p.onBeforeDispose = function () {
        var widget = this;
        this.toggleButtonReady.reject();
        this.flyOutReady.reject();
        if (this.settings.mode === Enum.DialogMode.MODAL) {
            this.bodyWrapper[0].dispatchEvent(new CustomEvent(BreaseEvent.HIDE_MODAL, { bubbles: true, detail: { id: this.elem.id } }));
            this._toggleDimmer(false);
        }

        _removeListeners(this);

        brease.uiController.dispose(this.bodyWrapper, false, function () {
            widget.bodyWrapper.remove();
            if (widget.dimmer) {
                widget.dimmer.remove();
            }
        });

        SuperClass.prototype.onBeforeDispose.apply(this, arguments);
    };

    p.wake = function () {
        this._setInitialPosition();
        if (this.bodyWrapperCache) {
            this.bodyWrapper = $('#' + this.bodyWrapperCache[0].id);
            
            if (this.settings.mode === Enum.DialogMode.MODAL) {
                this.bodyWrapper.before(this.dimmerCache);
                this.dimmer = $('#' + this.dimmerCache[0].id);    
            }
        }

        _addListeners(this);

        SuperClass.prototype.wake.apply(this, arguments);
    };

    p.onBeforeSuspend = function () {
        if (this.settings.mode === Enum.DialogMode.MODAL) {
            this._toggleDimmer(false);
            this.bodyWrapper[0].dispatchEvent(new CustomEvent(BreaseEvent.HIDE_MODAL, { bubbles: true, detail: { id: this.elem.id } }));

            this.dimmerCache = this.dimmer.detach();
        }
        if (this.el.hasClass('show')) {
            this.close();
            // listener for transitionend is removed in next line so we have to trigger the handler manually
            this._onTransitionEnd();
        }
        _removeListeners(this);
        this.bodyWrapperCache = this.bodyWrapper.detach(); // Flyout in DialogWindow affects calculation of size when it's contents are in DOM
        SuperClass.prototype.onBeforeSuspend.apply(this, arguments);
    };

    p._initEditDimensions = function () {
        if (brease.config.editMode) {
            var position = _calcPosition(this);
            switch (this.settings.docking) {
                case Enum.ImageAlign.bottom:
                {
                    this.bodyWrapper.css({
                        left: 0,
                        top: 'auto',
                        bottom: 0,
                        minWidth: 0,
                        width: position.container.width,
                        minHeight: position.container.height * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                        height: '100vh' //100% viewport height  (auto adapted when viewport changes)
                    });
                    break;
                }
                case Enum.ImageAlign.top:
                {
                    this.bodyWrapper.css({
                        left: 0,
                        top: 0,
                        bottom: 'auto',
                        minWidth: 0,
                        width: position.container.width,
                        minHeight: position.container.height * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                        height: '100vh' //100% viewport height  (auto adapted when viewport changes)
                    });

                    break;
                }
                case Enum.ImageAlign.right:
                {
                    this.bodyWrapper.css({
                        left: 'auto',
                        right: 0,
                        top: 0,
                        minHeight: 0,
                        height: position.container.height,
                        minWidth: position.container.width * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                        width: '100vw' //100% viewport with  (auto adapted when viewport changes)
                    });
                    break;
                }
                case Enum.ImageAlign.left:
                {
                    this.bodyWrapper.css({
                        left: 0,
                        right: 'auto',
                        top: 0,
                        minHeight: 0,
                        height: position.container.height,
                        minWidth: position.container.width * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                        width: '100vw' //100% viewport with  (auto adapted when viewport changes)
                    });
                }
            }
        }
    };

    p._onTransitionEnd = function () {
        var hasFocus = this.container[0].contains(document.activeElement);

        this.el.removeClass('move');
        this.bodyWrapper.removeClass('move');

        if (this.el.hasClass('show')) {
            if (this.settings.mode === Enum.DialogMode.MODAL) {
                this.bodyWrapper[0].dispatchEvent(new CustomEvent(BreaseEvent.SHOW_MODAL, { bubbles: true, detail: { id: this.elem.id } }));
            }
            this.bodyWrapper[0].addEventListener('keydown', this._bind('_keydownHandler'));
            this._setStateAndDispatch(HideableWidgetState.OPEN, HideableWidgetEvents.OPENED);
        } else {
            if (this.settings.mode === Enum.DialogMode.MODAL) {
                this.bodyWrapper[0].dispatchEvent(new CustomEvent(BreaseEvent.HIDE_MODAL, { bubbles: true, detail: { id: this.elem.id } }));
            }
            _resetZIndex(this);
            if (hasFocus) {
                brease.focusManager.focusNext();
            }
            this.bodyWrapper[0].removeEventListener('keydown', this._bind('_keydownHandler'));
            this._setStateAndDispatch(HideableWidgetState.CLOSED, HideableWidgetEvents.CLOSED);
        }
    };

    p._setStateAndDispatch = function (state, evt) {
        if (this.internal.state !== state) {
            this.internal.state = state;
            if (evt) {
                this.createEvent(evt).dispatch(); 
            }
        }
    };

    p._keydownHandler = function (e) {
        if (KeyActions.getActionsForKey(e.key).indexOf(Enum.KeyAction.Close) !== -1) {
            // prevent dialog close if FlyOut placed in dialog
            e.stopPropagation();
            e.preventDefault();
            this.close();
        }
    };

    p._onFocusout = function (e) {
        if (!this.flyOutWrapper[0].contains(e.relatedTarget)) {
            this.close();
        }
    };

    p._onButtonFocusIn = function () {
        /**
        * @event FocusIn
        * Fired when the widgets gets focus
        * @iatStudioExposed 
        * @eventComment
        */
        this.createEvent(BreaseEvent.FOCUS_IN).dispatch();
    };

    p._onButtonFocusOut = function () {
        /**
        * @event FocusOut
        * Fired when the widgets lost focus
        * @iatStudioExposed 
        * @eventComment
        */
        this.createEvent(BreaseEvent.FOCUS_OUT).dispatch();
    };

    function _autoClose(widget) {
        var parentLayout = widget.el.closest('[data-brease-layoutId]'),
            parentWidget = parentLayout.closest('.breaseWidget');
        if (parentWidget.length > 0) { //Flyout in e.g. a DialogWindow (embedded content)
            parentLayout.off(BreaseEvent.CLICK, widget._bind('_autoCloseHandler'));
        } else {
            brease.docEl.off(BreaseEvent.CLICK, widget._bind('_autoCloseHandler'));
        }
    }

    function _addOptionalAutoCloseListener(widget) {
        var parentLayout = widget.el.closest('[data-brease-layoutId]'),
            parentWidget = parentLayout.closest('.breaseWidget');
        
        if (parentWidget.length > 0) { //Flyout in e.g. a DialogWindow (embedded content)
            parentLayout.on(BreaseEvent.CLICK, widget._bind('_autoCloseHandler')); // only click on DialogWindow's content closes FlyOut, click on header (moving Dialog) won't trigger a close
            parentLayout.on(BreaseEvent.DISABLED_CLICK, widget._bind('_autoCloseHandler'));
        } else {
            brease.docEl.on(BreaseEvent.CLICK, widget._bind('_autoCloseHandler'));
            brease.docEl.on(BreaseEvent.DISABLED_CLICK, widget._bind('_autoCloseHandler'));
        }
        if (brease.config.isKeyboardOperationEnabled()) {
            widget.flyOutWrapper.on('focusout', widget._bind('_onFocusout'));
        }
    }

    function _removeOptionalAutoCloseListener(widget) {
        var parentLayout = widget.el.closest('[data-brease-layoutId]'),
            parentWidget = parentLayout.closest('.breaseWidget');
        
        if (parentWidget.length > 0) { //Flyout in e.g. a DialogWindow (embedded content)
            parentLayout.off(BreaseEvent.CLICK, widget._bind('_autoCloseHandler')); // only click on DialogWindow's content closes FlyOut, click on header (moving Dialog) won't trigger a close
            parentLayout.off(BreaseEvent.DISABLED_CLICK, widget._bind('_autoCloseHandler'));
        } else {
            brease.docEl.off(BreaseEvent.CLICK, widget._bind('_autoCloseHandler'));
            brease.docEl.off(BreaseEvent.DISABLED_CLICK, widget._bind('_autoCloseHandler'));
        }
        widget.flyOutWrapper.off('focusout', widget._bind('_onFocusout'));
    }

    function _addListeners(widget) {
        widget.button.on(BreaseEvent.MOUSE_DOWN, widget._bind('_mouseDownHandler'));
        widget.button.on(BreaseEvent.CHANGE, widget._bind('_toggleChangeHandler')); 

        widget.initPosTmOut = window.setTimeout(widget._bind('_setInitialPosition'), 10);
        
        // A&P 536750: changed from FRAGMENT_SHOW to PAGE_LOADED event (triggered on appContainer, not SystemLoader)
        brease.appView.on(BreaseEvent.PAGE_LOADED, widget._bind('_setInitialPosition'));

        // A&P 691770: if FlyOut is placed in a tabItem it needs to reposition on initial visibility_change where visibility is true
        widget.el.closest('.breaseTabItemContainer').on(BreaseEvent.VISIBILITY_CHANGED, widget._bind('_placedInTabItemRepositionHandler'));

        // A&P 510755
        brease.bodyEl.on(BreaseEvent.APP_RESIZE, widget._bind('_resizeEventHandler'));

        widget.flyOutWrapper.on('transitionend', widget._bind('_onTransitionEnd'));
        
        if (brease.config.isKeyboardOperationEnabled()) {
            widget.button.on(BreaseEvent.FOCUS_IN, widget._bind('_onButtonFocusIn'));
            widget.button.on(BreaseEvent.FOCUS_OUT, widget._bind('_onButtonFocusOut'));
        }
    }

    function _removeListeners(widget) {
        widget.button.off(BreaseEvent.MOUSE_DOWN, widget._bind('_mouseDownHandler'));
        widget.button.off(BreaseEvent.CHANGE, widget._bind('_toggleChangeHandler'));
        widget.button.off(BreaseEvent.FOCUS_IN, widget._bind('_onButtonFocusIn'));
        widget.button.off(BreaseEvent.FOCUS_OUT, widget._bind('_onButtonFocusOut'));

        // A&P 536750: changed from FRAGMENT_SHOW to PAGE_LOADED event (triggered on appContainer, not SystemLoader)
        brease.appView.off(BreaseEvent.PAGE_LOADED, widget._bind('_setInitialPosition'));
        
        // A&P 691770:
        widget.el.closest('.breaseTabItemContainer').off(BreaseEvent.VISIBILITY_CHANGED, widget._bind('_placedInTabItemRepositionHandler'));
        
        // A&P 510755
        brease.bodyEl.off(BreaseEvent.APP_RESIZE, widget._bind('_resizeEventHandler'));

        widget.flyOutWrapper.off('transitionend', widget._bind('_onTransitionEnd'));

        window.clearTimeout(widget.initPosTmOut);
        window.clearTimeout(widget.resetToggleBtnStateTimeout);
        
        brease.docEl.off(BreaseEvent.MOUSE_MOVE, widget._bind('_mouseMoveHandler'));
        brease.docEl.off(BreaseEvent.MOUSE_UP, widget._bind('_mouseUpHandler'));

        _autoClose(widget);
    }

    function _setVisibility(value) {
        // value === true, widget is 'hidden'
        // value === false, widget is shown, not hidden
 
        if (brease.config.editMode !== true) {
            if (value === undefined) {
                
            } else if (value === true) {
                this.bodyWrapper.addClass('remove');
                if (this.settings.autoClose === true) {
                    _invisibleHide(this);
                }
            } else {
                this.bodyWrapper.removeClass('remove');
                _updateDocking.call(this);
            }
        }
    }

    function _setEnable(value) {
        if (brease.config.editMode !== true) {
            if (value === undefined) {
                
            } else {
                var toggleButton = brease.callWidget(this.buttonId, 'widget');

                if (value) {
                    toggleButton.enable();
                } else {
                    toggleButton.disable();
                    _invisibleHide(this);
                }
            }
        }
    }

    function _invisibleHide(widget) {
        if (widget.el.hasClass('show')) {
            widget.hide();
            _updateButtonToggleState(widget, false);
        }
    }

    function _updateButtonToggleState(widget, buttonState) {
        var toggleButton = brease.callWidget(widget.buttonId, 'widget');
        if (!brease.config.editMode) {
            if (buttonState !== toggleButton.settings.value) {
                toggleButton.toggle(buttonState, true);
            }
        }
    }

    function _resetZIndex(widget) {
        var widgetZIndex = 100 + ((widget.settings.zIndex !== undefined) ? widget.settings.zIndex : 0);

        if (widget.settings.showOnTop === false || brease.config.editMode) { return; }

        widget.bodyWrapper.css('z-index', widgetZIndex);
        if (widget.dimmer !== undefined) {
            widget.dimmer.css('z-index', widgetZIndex);
        }
    }

    function _setInitialZIndex(widget) {
        var widgetZIndex = 100 + ((widget.settings.zIndex !== undefined) ? widget.settings.zIndex : 0); // this should be the z-index assigned by the editor, controlled by user

        widget.bodyWrapper.css('z-index', widgetZIndex);
        if (widget.dimmer !== undefined) {
            widget.dimmer.css('z-index', widgetZIndex);
        }

        widget.settings.prevActiveZIndex = widgetZIndex;
    }

    function _setZIndex(widget) {

        if (widget.settings.showOnTop === false || brease.config.editMode) { return; }

        if (widget.settings.prevActiveZIndex === undefined) {
            widget.settings.prevActiveZIndex = widget.bodyWrapper.css('z-index');
        }

        var highestZIndex = popupManager.getHighestZindex();
        if (widget.settings.prevActiveZIndex < highestZIndex) {
            widget.settings.prevActiveZIndex = highestZIndex;
        }

        widget.bodyWrapper.css('z-index', widget.settings.prevActiveZIndex);
        if (widget.dimmer !== undefined) {
            widget.dimmer.css('z-index', widget.settings.prevActiveZIndex);
        }
    }

    function _updateDocking() {
        var bodyWrapperCss = {},
            dialogLayout = this.el.closest('[data-brease-dialogid]'),
            scaleFactor = Utils.getScaleFactor(this.elem.parentElement),
            containerSize = _getContainerSize.call(this);
        if (!isNaN(containerSize.widthInPercent)) {
            this.contentWrapper.css('width', containerSize.width);
        }

        if (!isNaN(containerSize.heightInPercent)) {
            this.contentWrapper.css('height', containerSize.height);
        }

        this.el.removeClass('right top left bottom');
        this.bodyWrapper.removeClass('right top left bottom');
        this.button.appendTo(this.flyOutWrapper);

        switch (this.settings.docking) {
            case Enum.ImageAlign.top:
                this.distance = containerSize.height;
                this.bodyWrapper.addClass('top');
                this.el.addClass('top');

                bodyWrapperCss = {
                    width: this.contentWrapper.outerWidth(),
                    height: this.contentWrapper.outerHeight() + this.button.outerHeight() + parseInt(this.button.css('marginTop'), 10) + parseInt(this.button.css('marginBottom'), 10),
                    transform: 'matrix(' + scaleFactor + ',0,0,' + scaleFactor + ',0,0)',
                    transformOrigin: 'top left'
                };
                break;

            case Enum.ImageAlign.right:
                this.distance = containerSize.width;

                this.bodyWrapper.addClass('right');
                this.el.addClass('right')
                    .css('left', 'auto');

                bodyWrapperCss = {
                    width: this.contentWrapper.outerWidth() + this.button.outerWidth() + parseInt(this.button.css('marginLeft'), 10) + parseInt(this.button.css('marginRight'), 10),
                    height: this.contentWrapper.outerHeight(),
                    transform: 'matrix(' + scaleFactor + ',0,0,' + scaleFactor + ',' + this.button.outerWidth() * scaleFactor + ',0)',
                    transformOrigin: 'top right'
                };
                break;

            case Enum.ImageAlign.bottom:
                this.button.prependTo(this.flyOutWrapper);
                this.distance = containerSize.height;
                this.bodyWrapper.addClass('bottom');
                this.el.addClass('bottom')
                    .css('top', 'auto')
                    .css('display', 'inline');

                bodyWrapperCss = {
                    width: this.contentWrapper.outerWidth(),
                    height: this.contentWrapper.outerHeight() + this.button.outerHeight() + parseInt(this.button.css('marginTop'), 10) + parseInt(this.button.css('marginBottom'), 10),
                    transform: 'matrix(' + scaleFactor + ',0,0,' + scaleFactor + ',0,' + this.button.outerHeight() * scaleFactor + ')',
                    transformOrigin: 'bottom left'
                };
                break;

            case Enum.ImageAlign.left:
                this.distance = containerSize.width;
                this.bodyWrapper.addClass('left');
                this.el.addClass('left');
                bodyWrapperCss = {
                    width: this.contentWrapper.outerWidth() + this.button.outerWidth() + parseInt(this.button.css('marginLeft'), 10) + parseInt(this.button.css('marginRight'), 10),
                    height: this.contentWrapper.outerHeight(),
                    transform: 'matrix(' + scaleFactor + ',0,0,' + scaleFactor + ',0,0)',
                    transformOrigin: 'top left'
                };
                break;
        }

        //as flyout is attached differently in the designer (and dialogs), the transformation should not be applied
        if (brease.config.editMode || dialogLayout.length > 0) {
            bodyWrapperCss.transform = 'none';
            bodyWrapperCss.transformOrigin = '50% 50% 0';
        }
        this.bodyWrapper.css(bodyWrapperCss);

        this._setButtonOffset();
        _updateEditDimensions.call(this);

        if (!this.el.hasClass('initialized')) {
            this.hide();
            _updateEditDimensions.call(this);
            var that = this;
            _.defer(function () {
                if (!brease.config.editMode) {
                    that.flyOutWrapper.addClass('transition');
                }
            });
            if (brease.config.editMode !== true && this.settings.enable === false) {
                _setEnable.call(this, this.settings.enable);
            }

            this.el.addClass('initialized');
            this.bodyWrapper.addClass('initialized');

            this._dispatchReady();
        }

        _fixOffsetAfterUpdateDocking.call(this);
    }

    function _fixOffsetAfterUpdateDocking() {
        var scaleFactor = Utils.getScaleFactor(this.elem.parentElement);
        var offset = {
            top: parseInt(this.settings.top * scaleFactor),
            left: parseInt(this.settings.left * scaleFactor)
        };

        if (brease.config.editMode) {
            if (this.settings.docking === Enum.ImageAlign.top) {
                offset.top = this.contentWrapper.offset().top;
                offset.top = 0;
            } else if (this.settings.docking === Enum.ImageAlign.left) {
                offset.left = this.contentWrapper.offset().left;
                offset.left = 0;
            }
            return;
        }
        var dialogLayout = this.el.closest('[data-brease-dialogid]');
        if (dialogLayout.length === 0) { // NOT a dialog content
            var parentAreaElem = this.elem.closest('.LayoutArea');
            // some test do not have a area so we have to fall back to parent
            parentAreaElem = parentAreaElem === null ? this.elem.parentElement : parentAreaElem;
            var parentOffset = $(parentAreaElem).offset();

            offset.left += parentOffset.left;
            offset.top += parentOffset.top;

            switch (this.settings.docking) {
                case Enum.ImageAlign.right:
                    offset.left += parentAreaElem.getBoundingClientRect().width - this.bodyWrapper.width() * scaleFactor;
                    break;
                
                case Enum.ImageAlign.bottom:
                    offset.top += parentAreaElem.getBoundingClientRect().height - this.bodyWrapper.height() * scaleFactor;
                    break;
            }
            this.bodyWrapper.offset(offset);
        
        } else { // dialog: no scaling should be applied (due to location in DOM)
            
            switch (this.settings.docking) {
                case Enum.ImageAlign.right:
                    this.bodyWrapper.css('left', 'auto');
                    this.bodyWrapper.css('top', this.settings.top);
                    break;

                case Enum.ImageAlign.left:
                    this.bodyWrapper.css('top', this.settings.top);
                    break;
              
                case Enum.ImageAlign.bottom:
                    this.bodyWrapper.css('top', 'auto');
                    this.bodyWrapper.css('left', this.settings.left); 
                    break;

                case Enum.ImageAlign.top:
                    this.bodyWrapper.css('left', this.settings.left); 
                    break;
            }
        }
    }
    // used in designer context
    function _calcPosition(widget) {
        var position = { container: {}, button: {} },
            containerSize = _getContainerSize.call(widget);

        position.container = {
            width: containerSize.width,
            height: containerSize.height
        };

        position.button = {
            top: parseInt(widget.settings.top, 10),
            left: parseInt(widget.settings.left, 10)
        };

        switch (widget.settings.docking) {
            case Enum.ImageAlign.top:
            case Enum.ImageAlign.bottom:
            {
                position.button.left += widget.settings.buttonOffset;
                break;
            }
            case Enum.ImageAlign.left:
            case Enum.ImageAlign.right:
            {
                position.button.top += widget.settings.buttonOffset;
                break;
            }
        }

        return position;
    }

    p._setWidth = function (w) {
        if (brease.config.editMode) {
            this.settings.width = w;
            _updateDocking.call(this);

            this._setButtonOffset();
            _updateEditDimensions.call(this);
        }
    };

    p._setHeight = function (h) {
        if (brease.config.editMode) {
            this.settings.height = h;
            _updateDocking.call(this);

            this._setButtonOffset();

            _updateEditDimensions.call(this);
        }
    };

    function _updateEditDimensions() {
        if (brease.config.editMode) {
            var position = _calcPosition(this);

            this.container.css('pointer-events', 'auto');
            this.button.css('pointer-events', 'auto');

            this.container.css({
                width: position.container.width,
                height: position.container.height // only partial visible..
            });

            if (this.el.hasClass('show')) {
                switch (this.settings.docking) {
                    case Enum.ImageAlign.bottom:
                    {
                        this.button.css({
                            position: 'absolute',
                            left: position.button.left,
                            top: 'auto',
                            bottom: position.container.height
                        });

                        this.bodyWrapper.css({
                            left: 0,
                            top: 'auto',
                            bottom: 0,
                            minWidth: 0,
                            width: position.container.width,
                            minHeight: position.container.height * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                            height: '100vh' //100% viewport height  (auto adapted when viewport changes)
                        });

                        this.container.css({
                            position: 'absolute',
                            top: 'auto',
                            bottom: 0
                        });
                        this.flyOutWrapper.css({ top: 'auto', bottom: 0 });
                        break;
                    }
                    case Enum.ImageAlign.top:
                    {
                        this.button.css({
                            left: position.button.left,
                            top: 0
                        });

                        this.bodyWrapper.css({
                            left: 0,
                            top: 0,
                            bottom: 'auto',
                            minWidth: 0,
                            width: position.container.width,
                            minHeight: position.container.height * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                            height: '100vh' //100% viewport height  (auto adapted when viewport changes)
                        });

                        break;
                    }
                    case Enum.ImageAlign.right:
                    {
                        this.button.css({
                            left: 0,
                            top: position.button.top
                        });

                        this.bodyWrapper.css({
                            left: 'auto',
                            right: 0,
                            top: 0,
                            minHeight: 0,
                            height: position.container.height,
                            minWidth: position.container.width * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                            width: '100vw' //100% viewport with  (auto adapted when viewport changes)
                        });

                        this.flyOutWrapper.css({ right: 0 });
                        break;
                    }
                    case Enum.ImageAlign.left:
                    {
                        this.button.css({
                            left: 0,
                            top: position.button.top
                        });

                        this.bodyWrapper.css({
                            left: 0,
                            right: 'auto',
                            top: 0,
                            minHeight: 0,
                            height: position.container.height,
                            minWidth: position.container.width * 2, // highly unlikely that tha button is larger than the content in a very big content... 
                            width: '100vw' //100% viewport with  (auto adapted when viewport changes)
                        });
                    }
                }
            } else {

                this.hide(); //  css
                /* Special case bottom - closed */
                if (this.settings.docking === Enum.ImageAlign.bottom) {
                    this.button.css({
                        position: 'absolute',
                        top: 'auto',
                        bottom: 0
                    });
                    this.container.css({
                        position: 'absolute',
                        top: 'auto',
                        bottom: -position.container.height
                    });
                    this.flyOutWrapper.css({ top: 'auto', bottom: 0 });
                }
            }
            this._setButtonOffset();
            this._setButtonVisibility();

            var event = this.createEvent('HandlesChanged');
            event.dispatch();
            
        }
    }

    function _updateModalOverlays() {
        $('.breaseModalDimmer:visible').addClass('active');
    }
    function _getContainerSize() {
        var containerSize = {
            widthInPercent: Utils.isPercentageValue(this.settings.width) ? parseInt(this.settings.width, 10) : NaN,
            width: parseInt(this.settings.width, 10),
            heightInPercent: Utils.isPercentageValue(this.settings.height) ? parseInt(this.settings.height, 10) : NaN,
            height: parseInt(this.settings.height, 10)
        };
        if (!isNaN(containerSize.widthInPercent)) {
            containerSize.width = this.elem.parentElement.clientWidth * containerSize.widthInPercent / 100;
        }

        if (!isNaN(containerSize.heightInPercent)) {
            containerSize.height = this.elem.parentElement.clientHeight * containerSize.heightInPercent / 100;
        }
        return containerSize;
    }
    var _safe;
    function _disableScroll() {
        this.dimmer.on('mousewheel DOMMouseScroll touchstart', _preventDefault);
        if (!_safe) {
            _safe = {
                x: brease.bodyEl.css('overflow-x'),
                y: brease.bodyEl.css('overflow-y')
            };
        }
        document.body.style.overflow = 'hidden';
    }

    function _enableScroll() {
        if ($('.breaseModalDimmer:visible').length === 0 && !this.dimmer.hasClass('init-only')) {
            this.dimmer.off('mousewheel DOMMouseScroll touchstart', _preventDefault);
            brease.bodyEl.css('overflow-x', _safe.x);
            brease.bodyEl.css('overflow-y', _safe.y);
        }
    }

    function _preventDefault(e) {
        e.preventDefault();
    }

    function _createDimmer() {
        if (this.dimmer === undefined && this.settings.mode === Enum.DialogMode.MODAL && !brease.config.editMode) {
            this.dimmer = $('<div/>').attr('id', 'Dimmer_' + this.elem.id).addClass('breaseModalDimmer init-only');
            this.dimmer.css('display', 'none');
        }
    }

    function _handleMoved(dist) {
        if (dist === 0) return;
        if (!this.el.hasClass('show')) {
            //comes from closed state
            if (dist > 10) {
                this.show();
            } else {
                this.hide();
            }
        } else {
            //comes from opened state
            if (dist < -10) {
                this.hide();
            } else {
                this.show();
            }
        }
        // if FlyOut is moved by mouse(or touch) to the endposition (open or closed), _onTransitionEnd is not called as no transition runs
        // therefore we have to check this case and call _onTransitionEnd if necessary
        checkOpenClosedState.call(this, dist);
    }

    function checkOpenClosedState(dist) {
        
        var wrapperPos = this.flyOutWrapper.position();
        var containerSize = _getContainerSize.call(this);
        var docking = this.settings.docking;
        var scale = Utils.getScaleFactor(this.elem.parentElement);
        var compareSize = {
            width: containerSize.width * scale,
            height: containerSize.height * scale
        };

        // only moves of the ToggleButton from opposite position are detected, as we do not need moves, 
        // which return to start position of the move (e.g. start at closed position and return to closed position)
        if (isMoveFromOpposite(dist, docking, compareSize)) {
            this._onTransitionEnd(); 
        } else {
            var isInClosedPosition = isNearClosedPosition(docking, wrapperPos, compareSize);
            if (isInClosedPosition && this.internal.state !== HideableWidgetState.CLOSED) {
                this._setStateAndDispatch(HideableWidgetState.CLOSED, HideableWidgetEvents.CLOSED);
                this.el.removeClass('move');
                this.bodyWrapper.removeClass('move');
            }
        }
    }

    function isHorizontalDocking(docking) {
        return docking === Enum.ImageAlign.left || docking === Enum.ImageAlign.right;
    }

    function isVerticalDocking(docking) {
        return docking === Enum.ImageAlign.top || docking === Enum.ImageAlign.bottom;
    }

    function isMoveFromOpposite(dist, docking, containerSize) {
        return ((isHorizontalDocking(docking) && Math.abs(dist) >= containerSize.width) ||
                (isVerticalDocking(docking) && Math.abs(dist) >= containerSize.height)); 
    }

    function isNear(a, b) {
        return Math.abs(a - b) < 1;
    }

    function isNearClosedPosition(docking, wrapperPos, containerSize) {
        return (docking === Enum.ImageAlign.left && isNear(wrapperPos.left, -containerSize.width)) || 
                (docking === Enum.ImageAlign.right && isNear(wrapperPos.left, containerSize.width)) ||
                (docking === Enum.ImageAlign.top && isNear(wrapperPos.top, -containerSize.height)) || 
                (docking === Enum.ImageAlign.bottom && isNear(wrapperPos.top, containerSize.height)); 
    }

    function _requiresFocusoutHandler() {
        return brease.config.isKeyboardOperationEnabled() && this.elem.classList.contains('show') && this.settings.autoClose;
    }

    function _restoreFocus(focusElem) {
        if (brease.config.isKeyboardOperationEnabled() && this.flyOutWrapper[0].contains(focusElem) && !this.flyOutWrapper[0].contains(document.activeElement)) {
            focusElem.focus();
        }
    }

    return WidgetClass;

});
