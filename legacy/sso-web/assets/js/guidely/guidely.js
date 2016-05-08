var guidely = (function(){
	return {			
		_guides: []
		, _defaults: {
			showOnStart: true
			, welcome: true
			, welcomeTitle: 'Welcome to the guided tour!'
			, welcomeText: 'Click to start a brief tour of our site. Here we\'ll point out important features and tips to make your experience easier. '
			, overlay: true
			, startTrigger: true
			, escClose: true
			, keyNav: true
			, debug: false
		}
		
		, _options: { }
		
		, init: function (config) {
			var that, options;			
			that = this;
			that._options = $.extend (that._defaults, config);	
			
			if (that._guides.length < 1) { that._log ('No guides available.'); return false; }		
			
			that._append ();		
			that._createTopAnchor ();
			that.close ();	
			if (that._options.startTrigger) {		
				that._createStartTrigger ();	
			}
			if (that._options.showOnStart) {
				if (that._options.welcome) {		
					that.welcome ();
				} else {
					that.start ();
				}
			}
		}
		
		, start: function () {			
			var that = this;			
			that.close ();
			that._scrollToTop ();
			that.showNumbers ();			
			that.show (1);
			that.showOverlay ();
			that._log (that._guides);
			that._reposition ();
			$(document).bind ('keyup.guidely', function (e) { 
				if (that._options.escClose) {
					if (e.keyCode == 27) { that.close (); } 
				}
				
				if (that._options.keyNav) {
					if (e.keyCode == 37) { that.prev (); }
					if (e.keyCode == 39) { that.next (); }
				}
			});
			$(window).bind ('resize.guidely', function () { that._reposition (); });
		}
		
		, welcome: function () {
			var that, content, popup, pad, controls, close, overlay, startBtn, noBtn;			
			that = this;
						
			that.close ();
			
			content = $('<div>', {
				'id': 'guide-welcome'
				, 'class': 'guidely-guide'				
			}).appendTo ('body');
			
			popup = $('<div>', {
				'class': 'guidely-popup'	
			}).appendTo (content);
			
			pad = $('<div>', {
				'class': 'guidely-guide-pad'
			}).appendTo (popup);
			
			pad.append ('<h4>' + that._options.welcomeTitle + '</h4>');
			pad.append (that._options.welcomeText);
			
			controls = $('<div>', {
				'class': 'guidely-controls'
			}).appendTo (popup);
			
			content.css ({
				'position': 'absolute'
				, 'top': '75px'
				, 'left': '50%'	
				, 'margin-left': '-' + content.outerWidth () / 2 + 'px'
			});
			
			close = $('<a>', {
				'href': 'javascript:;'
				, 'class': 'guidely-close-trigger'
				, 'html': 'x'
				, 'click': function () { that.close (); }	
			}).appendTo (content);
			
			this.showOverlay ();
			
			startBtn = $('<button>', {
				text: 'Start Tour'
				, click: function () {					
					that.close ();
					that.start ();					
				}
			}).appendTo (controls);
			
			noBtn = $('<button>', {
				text: 'No Thanks'
				, click: function () { that.close (); }
			}).appendTo (controls);
			
			content.show ();
			
			that._scrollToTop (function () { startBtn.focus (); });
			
			$(document).bind ('keyup.guidely', function (e) { 
				if (e.keyCode == 27) { that.close (); } 
			});		
		}
		
		, show: function (guideId) {
			var guide = $('#guidely-guide-' + guideId);
			var number = $('#guidely-number-' + guideId);
			
			this._resetZIndex ();
			
			number.css ({ 'z-index': '20001' });
			guide.show ().css ({ 'z-index': '20000' });
			guide.find ('.guidely-controls button').focus ();	
		}
		
		, next: function () {
			var that, current, next, id;					
			that = this;
			current = $('.guidely-guide:visible');
			next = current.nextAll ('.guidely-guide:not(#guide-welcome)').eq (0);
			
			if (next.length > 0) {
				current.hide ();
				id = next.attr ('id').split ('-')[2];						
				that.show (id);
			}
		}
		
		, prev: function () {
			var that, current, prev, id;					
			that = this;
			current = $('.guidely-guide:visible');
			prev = current.prevAll ('.guidely-guide:first');
			
			if (prev.length > 0) {
				current.hide ();
				id = prev.attr ('id').split ('-')[2];						
				that.show (id);
			}
		}	
		
		, add: function (config) {
			var options = {
				anchor: 'top-left'
			};
						
			options = $.extend (options, config);
			
			if (options.text === '' || options.text === undefined) {
				this._log ('Guide id ' + options.attachTo + ' cannot be blank.');
				return false;
			}
			
			this._guides.push (options);	
		}
		
		, close: function () {
			this.hideNumbers ();
			this.hideGuides ();
			this.hideOverlay ();
			$(document).unbind ('keyup.guidely');
			$(window).unbind ('resize.guidely');
		}	
		
		, hideGuides: function () {
			$('.guidely-guide').hide ();
		}
		
		, showNumbers: function () {
			$('.guidely-number').fadeIn ('slow');
		}
		
		, hideNumbers: function () { 
			$('.guidely-number').hide ();
		}
		
		, showOverlay: function () {
			if (!this._options.overlay) { return false; }
			
			var overlay = $('.guidely-overlay');			
			if (!overlay.length) {
				$('<div>', {
					'class': 'guidely-overlay'
				}).appendTo ('body');
			} else {
				overlay.show ();	
			}
		}
		
		, hideOverlay: function () {
			$('.guidely-overlay').hide ();
		}
		
		, _createNumber: function (id, options) {			
			var that, number, coords, displayId;						
			that = this;
			coords = this._getAnchorCoords (options);
			displayId = id;
			
			number = $('<div>', {
				'id': 'guidely-number-' + id
				, 'class': 'guidely-number'
				, 'html': '<span>' + displayId + '</span>'
			});
			
			number.css ({ 'top': coords[0], 'left': coords[1] });
						
			number.bind ('click', function () {			
				if ($('#guidely-guide-' + id).is (':visible')) { return false; }		
				
				that.showOverlay ();				
				that.hideGuides ();
				that.show (id);
			});
			
			number.appendTo ('body').show ();
		}  
		
		, _createGuide: function (id, options) {
			var that, content, popup, pad, close, controls, coords, number;			
			that = this;
			coords = this._getCoords (options);
			number = $('#guidely-number-' + id);
			
			content = $('<div>', { 
				'id': 'guidely-guide-' + id
				, 'class': 'guidely-guide'				
			}).appendTo ('body');
			
			close = $('<a>', {
				'href': 'javascript:;'
				, 'class': 'guidely-close-trigger'
				, 'html': 'x'
				, 'click': function () { that.close (); }	
			}).appendTo (content);
			
			popup = $('<div>', {
				'class': 'guidely-popup'	
			}).appendTo (content);
			
			pad = $('<div>', {
				'class': 'guidely-guide-pad'
			}).appendTo (popup);
			
			if (options.title !== '' && options.title !== undefined) {
				pad.append ('<h4>' + options.title + '</h4>');
			}
			pad.append (options.text);
			
			controls = $('<div>', {
				'class': 'guidely-controls'
			}).appendTo (popup);
			
			if (this._guides.length == id) {				
				this._createDoneButton ().prependTo (controls);
			} else {
				this._createNextButton ().appendTo (controls);
			}
			
			this._setGuidePosition (number, content);
		}		
		
		, _setGuidePosition: function (number, content) {
			var offset, left, docWidth, docHeight;	
			offset = number.offset ();
			docWidth = $(document).width ();
			docHeight = $(document).height ();
						
			if (content.outerWidth () + offset.left > docWidth) {
				left = (offset.left - content.outerWidth ()) + 30;
				content.addClass ('guidely-anchor-right');
			} else {
				left = (offset.left + number.outerWidth ()) - 30;
				content.removeClass ('guidely-anchor-right');
			}
			
			content.css ({
				'position': 'absolute'
				, 'top': offset.top + 15
				, 'left': left
			});
		}
		
		, _createStartTrigger: function () {
			var that = this;
			
			$('<a>', {
				'href': 'javascript:;'
				, 'class': 'guidely-start-trigger'
				, 'html': 'Start Tour'
				, 'click': function (e) {
					e.preventDefault ();
					
					if (that._options.welcome) {
						that.welcome (that._options.title, that._options.text);
					} else {
						that.start ();
					}
				}
			}).appendTo ('body');
		}
		
		, _getCoords: function (options) {
			var el = $(options.attachTo);
			
			return {
				width: el.outerWidth ()
				, height: el.outerHeight ()
				, top: el.offset ().top
				, left: el.offset ().left
			};
		}
		
		, _getAnchorCoords: function (options) {
			var coords, offsetMap, anchor, numberOffset;						
			coords = this._getCoords (options);			
			anchor = options.anchor.replace ('-', '_');
			numberOffset = 45 / 2;			
			offsetMap = {
				top_left: [coords.top - numberOffset, coords.left - numberOffset]
				, top_right: [coords.top - numberOffset, (coords.left + coords.width) - numberOffset]
				, top_middle: [coords.top - numberOffset, coords.left + (coords.width / 2) - numberOffset]				
				, middle_left: [coords.top + (coords.height / 2) - numberOffset, coords.left - numberOffset]
				, middle_middle: [coords.top + (coords.height / 2) - numberOffset, coords.left + (coords.width / 2) - numberOffset]
				, middle_right: [coords.top + (coords.height / 2) - numberOffset, coords.left + coords.width - numberOffset]				
				, bottom_right: [coords.top + coords.height - numberOffset, (coords.left + coords.width) - numberOffset]
				, bottom_middle: [coords.top + coords.height - numberOffset, coords.left + (coords.width / 2) - numberOffset]
				, bottom_left: [coords.top + coords.height - numberOffset, coords.left - numberOffset]				
			};			
			return offsetMap[anchor];
		}
		
		, _createNextButton: function () {	
			var that = this;					
			return $('<button>', {
				text: 'Next'
				, click: function () {
					that.next ();				
				}
			});
		}	
		
		, _createDoneButton: function () {			
			var that = this;
			
			return $('<button>', {
				text: 'Done'
				, click: function (e) {
					e.preventDefault ();
					that.close ();	
				}
			});
		}
		
		, _resetZIndex: function () {
			$('.guidely-number').css ({ 'z-index': '10002' });
			$('.guidely-guide').css ({ 'z-index': '10001' });
		}
		
		, _append: function () {		
			for (var i=0, l=this._guides.length; i<l; i++) {
				var di = i + 1;
				this._createNumber (di, this._guides[i]);
				this._createGuide (di, this._guides[i]);				
			}
		}	
		
		, _reposition: function () {
			for (var i=0, l = this._guides.length; i<l; i++) {
				var display_id, coords, number, content;					
				display_id = i + 1;
				coords = this._getAnchorCoords (this._guides[i]);					
				number = $('#guidely-number-' + display_id);					
				number.css ({ 'top': coords[0], 'left': coords[1] });					
				content = $('#guidely-guide-' + display_id);			
				this._setGuidePosition (number, content);					
			}
		}
		
		, _scrollToTop: function (callback) {
			var target_offset = $("#guidely-top").offset();
	        var target_top = target_offset.top;	 
	        $('html, body').animate({scrollTop:target_top}, 500, function () { if (typeof callback === 'function') { callback (); } });
		}
		
		, _log: function (msg) {
			if (typeof window.console != 'undefined' && typeof window.console.log != 'undefined' && this._options.debug) {
                console.log(msg);
            }
		}
		
		, _createTopAnchor: function () {
			$('<div>', { id: 'guidely-top' }).prependTo ('body');
		}
	};
})(this);