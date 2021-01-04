
# Ticket Machine and Station Project

## Projet Explanation
This project contatins a ticket and station management system for the London underground. It contatins the main controller that is in charge of asigning prices, and information to the various ticket machines as well as be able to edti the information of the different staitons.
There are 3 interfaces in the system which work with one another. The first one, the controlelr interface is in charge of editing stations and the ticket machines whithin the stations. It also allows to edti peak and off peak times and prices. 
The second interface is the ticket machine intergace. Each ticket machine makes a ReST call to the controller to get the information about which station the said machine is and what prices it should ask for. 
Lastly the third interface it the gate interface which allows the user to enter the ticket and pass through the gate once the system validates it. 

## Deployment Instructions
### Requirements
In order to deploy the project Java 11 is required to run on all systems. 

### How to Deploy
It is important that the controller web app is running for the entire system to work. First the Controller application needs to be launched before any of the other systems. 
Once that is done the station system with the ticket machine can be started making a ReST call to the main controlelr to get it's information.
If the main system is not started first, the ticket machine ReST client will not work as there will be nowhere to call for information.


