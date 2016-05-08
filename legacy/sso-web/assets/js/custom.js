$(document).ready(function() {
	var d1 = [];
	for (var i = 0; i <= 10; i += 1)
		d1.push([i, parseInt(Math.random() * 30)]);

	var d2 = [];
	for (var i = 0; i <= 10; i += 1)
		d2.push([i, parseInt(Math.random() * 30)]);

	var d3 = [];
	for (var i = 0; i <= 10; i += 1)
		d3.push([i, parseInt(Math.random() * 30)]);

	var ds = new Array();

	ds.push({
		data:d1,
		bars: {
			show: true, 
			barWidth: 0.2, 
			order: 1,
			lineWidth : 2
		},
		label : "Premium members"
	});
	ds.push({
		data:d2,
		bars: {
			show: true, 
			barWidth: 0.2, 
			order: 2
		},
		label : "Members"
	});
	ds.push({
		data:d3,
		bars: {
			show: true, 
			barWidth: 0.2, 
			order: 3
		},
		label:"Guests"
	});

	if($('.flot.bar').length > 0){
		$.plot($(".flot.bar"), ds, {grid: {
			hoverable: true,
			clickable: true
		},colors: [ '#2872bd', '#85a12a', '#feb900', '#128902', '#c6c12f']});
	}

	var sin = [], cos = [], tmp = [];
				for (var i = 0; i < 21; i += 0.5) {
					sin.push([i, Math.sin(i)]);
					cos.push([i, Math.cos(i)]);
				}

				var options = {
					series: {
						lines: { show: true },
						points: { show: true }
					},
					grid: {
						hoverable: true,
						clickable: true
					},
					yaxis: { min: -1.1, max: 1.1 },
					colors: [ '#2872bd', '#666666', '#feb900', '#128902', '#c6c12f']
				};

				var options2 = {
					series: {
						pie: { 
							show: true,
							radius: 1,
							label: {
								show: true,
								radius: 1,
								formatter: function(label, series){
									return '<div style="font-size:12px;text-align:center;padding:2px;color:white;font-weight:bold">'+label+'<br/>'+Math.round(series.percent)+'%</div>';
								},
								background: { opacity: 0.8 }
							}
						}
					},
					legend:{
						show:false
					},
					grid: {
						hoverable: true,
						clickable: true
					},
					colors: [ '#2872bd', '#666666', '#feb900', '#128902', '#c6c12f']
				};

				if($('.flot.line').length > 0){
					$.plot($(".flot.line"), [ {label: "Active guests", data: sin}, {label: "Active members", data: cos} ] , options);
				}
				if($(".flot.pie").length > 0){
					$.plot($(".flot.pie"), [ {label: "Active guests", data: 5}, {label: "Active members", data: 10},{label: "Label #3", data: 3},{label: "Label #4", data: 7} ] , options2);
				}

	function showTooltip(x, y, contents) {
		$('<div id="tooltip">' + contents + '</div>').css( {
			top: y + 5,
			left: x + 10,
		}).appendTo("body").show();
	}

	if($('.flot.live').length > 0){
			$(function () {
				var data = [], totalPoints = 300;
				function getRandomData() {
					if (data.length > 0)
						data = data.slice(1);

					while (data.length < totalPoints) {
						var prev = data.length > 0 ? data[data.length - 1] : 50;
						var y = prev + Math.random() * 10 - 5;
						if (y < 0)
							y = 0;
						if (y > 100)
							y = 100;
						data.push(y);
					}

					var res = [];
					for (var i = 0; i < data.length; ++i)
						res.push([i, data[i]])
					return res;
				}

				var updateInterval = 30;


				var options = {
				series: { shadowSize: 0 },
				yaxis: { min: 0, max: 100 },
				xaxis: { show: false }
				};
				var plot = $.plot($(".flot.live"), [ getRandomData() ], options);

				function update() {
					plot.setData([ getRandomData() ]);
					plot.draw();

					setTimeout(update, updateInterval);
				}

				update();
		});
	}

	$(".flot").bind("plothover", function (event, pos, item) {
			if (item) {
				if(event.currentTarget.className == 'flot bar'){
					var y = Math.round(item.datapoint[1]);
				} else if(event.currentTarget.className == 'flot pie') {
					var y = Math.round(item.datapoint[0])+"%";
				} else if(event.currentTarget.className == 'flot line'){
					var y = (Math.round(item.datapoint[1] * 1000)/1000);
				} else {
					var y = (Math.round(item.datapoint[1]*1000)/1000)+"€";
				}
				$("#tooltip").remove();
				showTooltip(pos.pageX, pos.pageY,"Value = "+y);
			}
			else {
				$("#tooltip").remove();
				previousPoint = null;            
			}
	});

	$(".tip").tooltip();

	if($('.fancy').length > 0){
		$(".fancy").fancybox({
			'transitionIn'	:	'elastic',
			'transitionOut'	:	'elastic',
			'speedIn'		:	600, 
			'speedOut'		:	200
		});
	}

	if($(".cho").length > 0){
		$(".cho").chosen({no_results_text: "No results matched"});
	}

	if($('.cleditor').length > 0){
		$(".cleditor").cleditor({width:'auto'});
	}

	if($('.spinner').length > 0){
		$('.spinner').spinner();
	}

	if($('.timepicker').length > 0){
		$('.timepicker').timepicker({
			defaultTime: 'current',
			minuteStep: 1,
			disableFocus: true,
			template: 'dropdown'
		});
	}

	if($('.tagsinput').length > 0){
		$('.tagsinput').tagsInput({width:'auto', height:'auto'});
	}

	if($('.plupload').length > 0){
		$('.plupload').pluploadQueue({
			runtimes : 'html5,gears,flash,silverlight,browserplus',
			url : 'js/plupload/upload.php',
			max_file_size : '10mb',
			chunk_size : '1mb',
			unique_names : true,
			resize : {width : 320, height : 240, quality : 90},
			filters : [
				{title : "Image files", extensions : "jpg,gif,png"},
				{title : "Zip files", extensions : "zip"}
			],
			flash_swf_url : 'js/plupload/plupload.flash.swf',
			silverlight_xap_url : 'js/plupload/plupload.silverlight.xap'
		});
		$(".plupload_header").remove();
		$(".plupload_progress_container").addClass("progress").addClass('progress-striped');
		$(".plupload_progress_bar").addClass("bar");
		$(".plupload_button").each(function(e){
			if($(this).hasClass("plupload_add")){
				$(this).attr("class", 'btn btn-primary pl_add btn-small');
			} else {
				$(this).attr("class", 'btn btn-success pl_start btn-small');
			}
		});
	}

	if($('.datepick').length > 0){
		$('.datepick').datepicker();
	}

	if($('.mask_date').length > 0 || $(".mask_phone").length > 0 || $(".mask_serialNumber").length > 0 || $(".mask_productNumber").length > 0){
		$(".mask_date").inputmask("9999/99/99");
		$(".mask_phone").inputmask("(999) 999-9999");
		$(".mask_serialNumber").inputmask("9999-9999-99");
		$(".mask_productNumber").inputmask("AAA-9999-A");
	}

	if($('.dataTable').length > 0){
		$('.dataTable').each(function(e){
			if($(this).hasClass("dataTable-noheader")){
				$(this).dataTable({
					"sPaginationType": "bootstrap",
					'bFilter': false,
					'bLengthChange': false
				});
			} else {
				$(this).dataTable({
					"sPaginationType": "bootstrap"
				});
			}
		});
	}
});
