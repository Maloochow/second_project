Project Mangement App:
User Authentication:
Home Page:
A list of existing gallery names
can create a new gallery
or click on gallery name to login to your gallery user account

Click on one of the galleries:
to create your user account, or log into your user account
only user emails that is stored in the database can be created or logged in
If the user email is not registered, the login page shows that this email has not been invited
if the user is registered at a different gallery, show a message saying, redirecting to the right gallery page

Navigation menu:
All tickets, Users, Clients, Logout

Gallery Page;
Only visible to logged in users that belongs to the gallery
button to create a new ticket
list current active tickets and upcoming
button to choose edit or delete the ticket if it belongs to the user


Edit ticket:
if the ticket belongs to the author
update the modify time
confirmation email send automatically to the user

Create ticket:
create time
confirmation email send automatically to the user

Delete
if the ticket belongs to the author
confirmation email send automatically to the user

User Page:
Only visible to logged in users that belongs to the gallery
button to invite a user
list all users
gallery admin account has the ability to delete a user

user invites:
enter user email address
automatic email send to gallery admin, current user and invited email


Clients page:
Only visible to logged in users that belongs to the gallery
button to create a client
list all clients, have a button to edit client

edit client:
save the last user that edited the client
send a confirmation to shop admin & user




Different organizations, when you create, you create an organization, the account also automatically become gallery admin

Models:
Gallery
has many users
has many tickets through users
has many Clients through tickets
delete user—remove gallery ID from the user
name

User
belongs_to gallery
has many tickets
has many Clients through tickets
username
email—unique
password
short intro

Client
has many tickets
has many users through tickets
belongs to gallery??
app number
status: subscribe, withdrawn


Ticke
belongs_to user
belongs_to Client
artwork:
starting date:
ending date:
create time
modify time
status

User Invites
has many users
invitor_id
new_user


send auto-email: https://github.com/mikel/mail
customize the email: https://github.com/foundation/inky-rb
https://get.foundation/emails/docs/gem-guide.html


Side development:
List all the requests created by the gallery that is active,  a button to view more details
On each request page, they can update an existing request: e.g., the preview ending date; Delete the request (put in junk folder)
when preview is created or updated, send auto-email to the sales person and page admin

filter?? what previews has been sent to a Client? the previews created by a sales person
sort by? Rank sales person by the number of previews they sent?

Header menu: Sign in—with a register code, only required at registration/ Login / Gallery Name, Logout, appears based on conditions

delete action put the preview request to a junk folder. So they can revisit what they created. If they abolished. If they want to delete permanently, they can go to the junk folder and delete permanently.