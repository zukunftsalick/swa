jQuery(window).ready(function(){
	jQuery("#btnInit").click(initiate_geolocation);
	jQuery("#btnForm").click(initiate_form);
});

function initiate_form(){
	jQuery(".form").toggle();
}

function initiate_geolocation() {
	navigator.geolocation.getCurrentPosition(handle_geolocation_query,handle_errors);
	toggle_spinner();
}

function toggle_spinner(){
	jQuery('.spinner').toggle();
}

function toggle_map(){
	jQuery('.map').toggle();
}

function handle_errors(error)
{
	switch(error.code)
	{
		case error.PERMISSION_DENIED: alert("user did not share geolocation data");
		break;

		case error.POSITION_UNAVAILABLE: alert("could not detect current position");
		break;

		case error.TIMEOUT: alert("retrieving position timed out");
		break;

		default: alert("unknown error");
		break;
	}
}

function handle_geolocation_query(position)
{
	var image_url = "http://maps.google.com/maps/api/staticmap?sensor=false&center=" + position.coords.latitude + "," +
	position.coords.longitude + "&zoom=16&size=500x300&markers=color:blue|label:S|" +
	position.coords.latitude + ',' + position.coords.longitude;

	toggle_spinner();
	toggle_map();
	set_hidden_variables(position.coords);
	jQuery("#map").remove();
	jQuery("#container div.map").append(
		jQuery(document.createElement("img")).attr("src", image_url).attr('id','map')
	);
}

function set_hidden_variables(coords) {
	jQuery("#latitude").val(coords.latitude);
	jQuery("#longitude").val(coords.longitude);
}