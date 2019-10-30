# Getting started with the DRIVER+ test-bed

This folder gets you started with the DRIVER+ test-bed. It explains how to set-up the technical infrastructure, and how to run a simple scenario. This composition contains the basic required images to run the Apache Kafka messaging framework, as well as several tools that demonstrate the capabilities of how the test-bed can be used to run a scenario (e.g. several management tools and a simulator).

## Installation

You should have installed Docker in order to run the test-bed. To get started, clone and run the docker-composition:
```console
git clone https://github.com/DRIVER-EU/test-bed.git
cd test-bed\docker\local-i4cm
docker-compose up -d
```
The first time it may take a while before all images are downloaded. Subsequently, it may take 1 or 2 minutes before all containers have finished their start-up process.

## Tutorial - Running a scenario

Once the test-bed is up-and-running using the instructions above, let's get started with a demonstration of the test-bed's capabilitities. First of all, here is an overview of the running services and their links:

| Service | Port | Link |
|---------|------|------|
| Kafka & Zookeeper | 3501 | - |
| Kafka topics UI | 3600 | http://localhost:3600 |
| Kafka schema registry and UI | 3601 | http://localhost:3601 |
| Postgres & PGAdmin | - | http://localhost:5050 |
| Time service | 8100 | http://localhost:8100/time-service |
| Admin tool | 8090 | http://localhost:8090 |
| After Action Review tool | 8095 | http://localhost:8095 |
| Trial-Management-Tool | 3210 | http://localhost:3210 |
| COPPER COP tool | 8080 | http://localhost:8080 |
| LCMS connector / gateway | 8500 | http://localhost:8500 |
| SUMO Traffic Simulator | - | - |
| Chain Effect Simulator | - | - |
| Large File Service | 9090 | http://localhost:9090 |
| Silent Producer | - | - |


### Starting a trial
Browse to the [Admin-tool](http://localhost:8090) and initialize the test-bed by clicking on the 'Initialize test-bed'-button. Similarly, start a trial with 'Start trial'.
![image1](https://user-images.githubusercontent.com/11523459/67579710-4ee5d500-f745-11e9-987b-ee62bcad5c18.png)

Then, open the [Trial Management Tool (TMT)](http://localhost:3210). Upload an exported Trial (e.g. [sim-trial](https://github.com/DRIVER-EU/test-bed/files/3772536/trial_2f670b5c-6ec0-4b70-9e87-92252d305d6e.1.zip)) and import it (see [here](#importing-a-trial)). Open this trial by clicking on the title ('sim-trial') and select the 'Run' mode on the top-right. ![image2](https://user-images.githubusercontent.com/11523459/67581026-940b0680-f747-11e9-983b-80dfe36497f0.png)
Next, connect to the test-bed. Then start the session by clicking 'Start'.
![image3](https://user-images.githubusercontent.com/11523459/67581119-c74d9580-f747-11e9-8a5f-3d3573a4122b.png)
When you have done this, an 'Initialize' button appears. Clicking this button will start the time.

#### Chain effect simulator
It will also start a scenario of the chain-effect simulator. When you open the [COPPER-tool](http://localhost:8080), you can view the critical infrastructure if you open the map-layers 'Chain flood', 'Chain power' and 'Chain care'. [COPPER](#copper-chain)

As the scenario will publish an update every hour, you'll either need to wait an hour to see the first update, or increase the simulation time speed. This can be done by the fast-forwarding buttons in the top right of the TMT-interface. 

#### SUMO traffic simulator
Another simulator included in this composition, is DLR's [SUMO](https://sumo.dlr.de/index.html) traffic simulator. In order to use it, open both the [COPPER-tool](http://localhost:8080) and the [TMT](http://localhost:3210). In COPPER, enable the map layers in the group 'simulation' (Unit transport request, unit update, and Affected area). Then start the trial in the TMT, if you hadn't already done so in the previous step. 
![image4](https://user-images.githubusercontent.com/11523459/67871172-3a804e80-fb30-11e9-85bd-d73c6c9dde41.png)
Most of the scenario will run automatically, however the Traffic storyline requires a manual intervention. Click on the red 'Traffic' storyline and subsequently on 'Click here when ready'. This will send an initialization to SUMO. Then repeat these steps for 'Send vehicle1 to accident_site'.
![image](https://user-images.githubusercontent.com/11523459/67871443-a82c7a80-fb30-11e9-86f2-852262db32bb.png)

If you now go to COPPER, it should display the route, Affected Area and the driving vehicle1.
![image5](https://user-images.githubusercontent.com/11523459/67871781-2f79ee00-fb31-11e9-87da-2fd48898bde1.png)


##### Running locally
You can also connect your local SUMO installation to the test-bed. First install SUMO using [the instructions](https://github.com/DRIVER-EU/sumo-connector). After that, follow the instructions to run the [Rotterdam scenario](https://github.com/DRIVER-EU/sumo-connector/tree/master/Rotterdam). Run the script ```py sumo_connector.py``` before starting the trial. 

#### LCMS Connector
In order to connect the test-bed to LCMS, create a ```.env``` file in this folder (next to ```docker-compose.yml```). In that file, add your login details for LCMS: 
```
LCMS_CONNECTOR_USERNAME=johndoe
LCMS_CONNECTOR_PASSWORD=1234
```
Additionally, you might need to change the default exercise name ```Driver+ Test``` with another LCMS-excercise in the file ```docker-compose.yml```. The parameter to change is ```LCMS_CONNECTOR_EXCERCISE```.


## Screenshots
### Importing a trial
Open a browser window with the [Trial Management Tool (TMT)](http://localhost:3210) dashboard and click the green '+'-button and then 'upload existing trial'.
![coppert2](https://user-images.githubusercontent.com/11523459/57529348-fc4e6300-7334-11e9-9afd-c939532a2548.jpg)
![coppert3](https://user-images.githubusercontent.com/11523459/57529350-fd7f9000-7334-11e9-82de-c413833e1b0e.jpg)

### Copper chain
![image](https://user-images.githubusercontent.com/11523459/67581546-79855d00-f748-11e9-93bf-1a064a007f43.png)
