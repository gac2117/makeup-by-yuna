# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Included two has_many relationships (Clients and Artists have many Appointments)
- [x] Included two belongs_to relationships (Appointment belongs to Client and Artist)
- [x] Included two has_many through relationships (Artist has many Clients through Appointments, and Client has many Artists through Appointments)
- [x] Include at least one many-to-many relationship (Artist has many Clients through Appointments, and Client has many Artists through Appointments)
- [x] The "through" part of the has_many through (Appointments) includes three user submittable attributes: date and time, type of service, and comments.
- [x] Included reasonable validations, like presence and uniqueness.
- [x] Included a class level ActiveRecord scope method (Appointment.by_date URL: /clients/1)
- [x] Include signup (Bcrypt)
- [x] Include login (Bcrypt)
- [x] Include logout (Bcrypt)
- [x] Include third party signup/login (Facebook/OmniAuth)
- [x] Include nested resource show or index (URL: /artists/1/appointments)
- [x] Include nested resource "new" form (URL: /clients/1/appointments/new)
- [x] Include form display of validation errors (form URL: /clients/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
