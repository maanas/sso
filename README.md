sso
===

SSO - Single Sign On

Single Sign On is LUA based Application layer which act as authentication layer. The module create a session and store the same in mysql database. The module can also act as Web Application Firewall checking any thing we want. 

[The earlier version of the code is moved in legacy folder](legacy/README.md)

The project now includes a vagrant based setup so that all the tools are available at single place. The new users can clone the repository and run the test application and try out before taking the pluge. The new organisation of code and content will also make it easier to get started and experimenting with own setup.



#### Application Stack
The Application Stack is based on nginx. The nginx is wonderful Webserver and it can actually be made an excellent application server by embedding the power of LUA. Please read openresty doc for more information as to how it can be used. We are using ngnix + LUA to convert the high load endpoint to LUA. The primary backend is php and the endpoint where we get hammering we have converted to nginx + LUA where we reuse the PHP Session (store in database) though this module.

LUA gives great power and flexibiltiy considering we do not have to worry about memory management and the whole LUA interpretor (luajit) is loaded inside ngnix at the start. The results are simply amazing. 


##### Session
The session concept has been borrowed from PHP where the sessions are stored in database. In SSO we are also storing the session in database and issue a cookie. On every requst we look up the database and verify the cookie exist in database and then allow the request.

I have added a PHP sessoins code i use in php along with mysql dump of the session table to give some idea.

##### Apps
Every end point can be forced for Single Sign on Check. Every endpoint is part of an App. The app is a constant which needs to be supplied. The SSO check for authorization of a user for an app before it actually allows the request


#### Request Phase
Nginx has various phases in which a request is processed. The SSO works at Access Phase and the request is interuppted if not authorized even before it request hits the endpoint, making SSO an idea choice for much better use as Application Firewall. You can go creating in writing sql query and design database schema and control via other front end and the web server will respond to that.

#### Valid Credentials
This will result in access being granted and the endpoint request is processed


#### Invalid Credentials
This will result in redirection for authentication

#### Restriction on username and password
The support only alpha user name and alpha password. Need to add regex to allow some special charactors.

## Project Roadmap
Integrate SAML into the project so that the SSO can work at par with other commercial grade single sign on solutions but at much faster and efficiently.

## Cavets
I have dumped the actual code and the documentation is still needs lot of fine tuning. Do drop me a mail in case you need any help and explanation as how things are done.

