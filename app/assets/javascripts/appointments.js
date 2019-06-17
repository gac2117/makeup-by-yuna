class Appointment {
	constructor(date_time, service, comments, artist_id, client_id) {
		this.date_time = new Date(date_time);
		this.service = service;
		this.comments = comments;
		this.artist_id = artist_id;
		this.client_id = client_id;
	}

	appInfo() {
		return `You have booked a(n) ${this.service} appointment for ${this.date_time}.`
	}
}
