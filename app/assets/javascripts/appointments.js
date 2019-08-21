$(() => {
  bindClickHandlers();
});

const bindClickHandlers = () => {
  $(document).on('click', '#app-details', function(e) {
    e.preventDefault();
    let id = $(this).attr('data-id');
    let clientId = $(this).attr('client-id');
    fetch(`/clients/${clientId}/appointments/${id}.json`)
      .then(res => res.json())
      .then(data => {
        $('#client-app-table').html('');
        let newApp = new Appointment(data);
        let details = newApp.formatDetails();
        $('#client-app-table').append(details);
      });
  });

class Appointment {
  constructor(app) {
    this.id = app.id;
    this.date_time = new Date(app.date_time);
    this.service = app.service;
    this.comments = app.comments;
    this.artist = app.artist;
    this.client = app.client;
  }

  formatDetails() {
    let formattedTime = formatTime(this.date_time);
    let tableHtml = `
			<ul class="list-group">
				<li class="list-group-item">
          <h5 class="list-group-item-heading">Date and Time:</h5> 
					${this.date_time.toDateString()}${formattedTime}
				</li>
				<li class="list-group-item">
          <h5 class="list-group-item-heading">Type of Service:</h5>
          ${this.service}
				</li>
				<li class="list-group-item">
					<h5 class="list-group-item-heading">Makeup Artist Name:</h5>
					${this.artist.name}
				</li>
				<li class="list-group-item">
					<h5 class="list-group-item-heading">Comments or Requests:</h5>
					${this.comments}
				</li>
      </ul>
		`;
    return tableHtml;
  }
}

const formatTime = date => {
  let hour = date.getUTCHours();
  let min = date.getUTCMinutes();

  let prepand = hour >= 12 ? ' PM ' : ' AM ';
  hour = hour >= 12 ? hour - 12 : hour;

  if (min === 0) {
    min += '0';
  }

  if (hour === 0 && prepand === ' PM ') {
    if (min === 0) {
      hour = 12;
      prepand = ' Noon';
    } else {
      hour = 12;
      prepand = ' PM';
    }
  }

  if (hour === 0 && prepand === ' AM ') {
    if (min === 0) {
      hour = 12;
      prepand = ' Midnight';
    } else {
      hour = 12;
      prepand = ' AM';
    }
  }
  return ' at ' + hour + ':' + min + prepand;
};
