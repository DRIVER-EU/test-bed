[![Stories in Ready](https://badge.waffle.io/DRIVER-EU/WP923-test-bed.png?label=ready&title=Ready)](http://waffle.io/DRIVER-EU/test-bed)

![test-bed](https://raw.githubusercontent.com/DRIVER-EU/test-bed/master/img/Common%20Information%20and%20Simulation%20Space.gif)

# Test-bed
This repository combines tools and data to quickly setup an environment for testing new solutions in the crisis domain, either standalone or in collaborative trials and experiments.

Our work is funded by the [DRIVER+](http://driver-project.eu) EU project as part of the Horizon 2020 program, which runs till 2020. However, we are commited to find sustainable solutions well beyond this date.

## Running the test-bed

Assuming you have installed `docker`, you can either go to `docker/local` and run `docker-compose up -d`, or from the root folder, you can start the test-bed with `yarn local` or `npm run local` (in this case, you also need to have `yarn` and `npm` installed).

# Design Guidelines of the DRIVER+ Test-bed

## 1. The test-bed shall consist of open source software.
Crisis management affects us all, and therefore we want to achieve a broad adoptation and no hindrances with respect to license management. In addition, being open source, we welcome everyone to create pull requests to improve the solutions that we are offering.

## 2. The test-bed shall be open for commercial organisations
Commercial organisations can help you to integrate the test-bed in your organisation, offer software solutions that exceed the capabilities of the offered tools, of provide support in maintaining the test-bed.

## 3. The test-bed shall consist of support and simulation tools, as well as data
Similar to websites like [Ninite](https://ninite.com/), where you can *"Install and Update All Your Programs at Once"*, we will create a similar experience for the test-bed. Users of the test-bed can select the components that they need, and they receive a test-bed fitted to their needs. They can pick from:

- Support tools, which allow system administrators to quickly setup the test-bed, add or remove components, inspect its status, inject test messages, verify received messages, record and replay a session, trial or experiment. Support tools also covers authentication and authorization management, geo servers to share a map or other information layers, or observer tools. Additionally, it also includes tools to manage a trial, or a mailserver that allows participants to exchange messages with each other that can be easily recorded and re-examined later.
- Simulation tools, which allow the solution developers or trial managers to start a previously recorded flow of messages, e.g. a police car driving around, a flooding or earthquake simulation, or a sequence of tweets or email messages. It may also include simulation software, e.g. a traffic simulator that provides background traffic. In this way, they can create different virtual incidents for testing their solution standalone, or during a trial or experiment.
- Data sets representing virtual (or real) incident areas, e.g. a flooding simulation in The Netherlands or an earthquake in Italy, combined with relevant information static and dynamic layers. For example, static layers like background maps, census information, and critical infrastructure. Or dynamic layers, e.g. crowd simulations or sensor networks.

We also invite other parties to create (open or commercial) tools and data that are compatible, so they can swap out functionality or extend it.

## 4. The test-bed consists of a Common Information Space, and a Common Simulation Space, connected via a Gateway
Interoperability in the test-bed is based on exchanging information (in the form of messages) between tools and users. Conceptually, there are two kinds of messages:

- Informative messages that are exchanged between the end users (crisis management practicioners). These are part of the Common Information Space (or CIS). Messages exchanged in this space should be based on open standards to allow a wide adoption, and we support:
  - OASIS [Emergency Data Exchange Language](http://docs.oasis-open.org/emergency/edxl-de/v2.0/edxl-de-v2.0.html), a.k.a. EDXL, version 2
  - OASIS [Common Alerting Protocol](http://docs.oasis-open.org/emergency/cap/v1.2/CAP-v1.2-os.html) (CAP) messages, version 1.2.

- Simulation messages that are exchanged between different simulators, and which together create a virtual incident area. These are part of the Common Simulation Space (CSS). Messages exchanged in this space are more dynamic in nature, depending on the virtual incident that you wish to simulate, and even (commercial) simulation standards like the [High Level Architecture](https://en.wikipedia.org/wiki/High-level_architecture), a.k.a. HLA or IEEE 1516, are often not flexible enough to support them.
We therefore (most-likely - currently under investigation) will employ the [Apache AVRO standard](https://avro.apache.org/docs/1.8.1/spec.html), also supported by the Apache organisation. It is a compact binary message exchange standard with a strong schema, which can be easily created (serialized) and read (deserialized). The schema is used to validate the structure of the messages.

The Gateway is the middleware glue that connects the two spaces: it will take information from the simulation space, convert it to the proper format, and publish it to the information space. For example, the measured water level during a flooding, or the location of ambulances, which subsequently can be displayed on a Common Operational Picture tool. Vice versa, it will convert informative messages from the information space to AVRO messages in the simulation space, e.g. to order a fire fighter to extinguish a fire.

In the figure, there are two other components:
- Trial or Scenario Management: they are used for controlling the virtual incident, e.g. to trigger a plane crash or start a forest fire, of flood the communication team with social media messages.
- After Action Review: allowing you to log the flow of messages, and replay and examine the trial at a later time.

NOTE: A simulator, e.g. a flooding simulator, that is used to support practitioners in making better decisions, is part of the CIS.

## 5. The test-bed shall run in a [Docker](docker.com) environment.
Installing software can be tedious, and due to its nature, the test-bed consists of an integration of many tools. And although you could install each tool separately, in order to facilitate an easy deployment, we will use Docker images and Docker compose to rollout the test-bed. As Docker is supported on Unix as well as Windows operating systems, everyone should be able to run it smoothly.

As a consequence, for the moment most of the supplied tools will run in a Unix environment, since Windows-based Docker containers are still experimental. However, this will not limit you to create Windows-only solutions, as it can still connect to the test-bed.

## 6. The core of the test-bed is based on Apache Kafka
In order to integrate different tools within the test-bed, and to make it easy to connect them with other solutions, we have selected an integration platform based on [Apache Kafka](https://kafka.apache.org). Although there are many good open-source messaging systems available, Kafka has a number of distinct advantages:
- It is supported by the Apache organisation, and used by a number of major commercial organisations. This means that it will not go away quickly, and it has many client connectors to ease integration.
- It is simple to setup and run, and performs very well. Where similar software systems cannot deal with more than 10.000 messages per second, Kafka can process a tenfold.



