$(() => {
  bindClickHandlers();
});

const bindClickHandlers = () => {
  // $('#app-link').on('click', e => {
  //   e.preventDefault();
  //   history.pushState(null, null, 'appointments');
  //   getAppointments();
  // });

  $(document).on('click', '#app-details', function(e) {
    e.preventDefault();
    let id = $(this).attr('data-id');
    let clientId = $(this).attr('client-id');
    fetch(`/clients/${clientId}/appointments/${id}.json`)
      .then(res => res.json())
      .then(data => {
        console.log(data);
        $('#client-app-table').html('');
        let newApp = new Appointment(data);
        console.log(newApp);
        let details = newApp.formatDetails();
        $('#client-app-table').append(details);
      });
  });

  $('#new-app').on('submit', function(e) {
    e.preventDefault();
    const values = $(this).serialize();

    $.post('/appointments', values).done(function(data) {
      $('#appointment-form').html('');
      const newApp = new Appointment(data);
      const details = newApp.formatDetails();
      $('#appointment-form').append(details);
    });
  });

  $('#show-apps').on('click', function(e) {
    let clientId = $(this).attr('data-client-id');
    fetch(`/clients/${clientId}.json`)
      .then(res => res.json())
      .then(data => {
        $('#client-app-table').html('');
        let showPage = `
			  <thead>
			    <tr>
			      <th>Appointment Date and Time</th>
			      <th>Type of Service</th>
			      <th>Comments / Requests</th>
			    </tr>
			  </thead>
			  <tbody id="apps-details">
			  </tbody>
			`;
        $('#client-app-table').append(showPage);
        data.appointments.forEach(app => {
          let newApp = new Appointment(app);
          let tableHtml = newApp.showTable();
          $('#apps-details').append(tableHtml);
        });
      });
  });
};

// const getAppointments = () => {
//   fetch(`/appointments.json`)
//     .then(res => res.json())
//     .then(data => {
//       $('.app-container').html('');
//       let indexPage = `
// 			<h1>List of all appointments</h1><br>
// 			<table class="table">
// 			  <thead>
// 			    <tr>
// 			      <th>Artist Name</th>
// 			      <th>Client Name</th>
// 			      <th>Appointment Date</th>
// 			      <th>Type of Service</th>
// 			    </tr>
// 			  </thead>
// 			  <tbody id="app-table">
// 			  </tbody>
// 		  </table>
// 		`;
//       $('.app-container').append(indexPage);
//       data.forEach(app => {
//         let newApp = new Appointment(app);
//         let tableHtml = newApp.formatTable();
//         $('#app-table').append(tableHtml);
//       });
//     });
// };

class Appointment {
  constructor(app) {
    this.id = app.id;
    this.date_time = new Date(app.date_time);
    this.service = app.service;
    this.comments = app.comments;
    this.artist = app.artist;
    this.client = app.client;
  }

  formatTable() {
    let formattedTime = formatTime(this.date_time);
    let tableHtml = `
			<tr>
		        <td>${this.artist.name}</td>
		        <td>${this.client.name}</td>
		        <td>${this.date_time.toDateString()}${formattedTime}</td>
		        <td>${this.service}</td>
		     </tr>
		`;
    return tableHtml;
  }

  showTable() {
    let formattedTime = formatTime(this.date_time);
    let tableHtml = `
			<tr>
		        <td>${this.date_time.toDateString()}${formattedTime}</td>
		        <td>${this.service}</td>
		        <td>${this.comments}</td>
		     </tr>
		`;
    return tableHtml;
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
      <a href="/clients/${
        this.client.id
      }" class="btn btn-warning btn-sm" role="button">Go Back</a>
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
