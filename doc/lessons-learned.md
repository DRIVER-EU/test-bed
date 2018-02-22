# Lessons learned from the old DRIVER-project

The current project, DRIVER+ (D+), is a continuation of the old DRIVER project, henceforward called D-. In D-, already several experiments were organised to test crisis management systems and solutions. This chapter will discuss the lessons that we could learn from them, specifically related to the technical infrastructure, a.k.a. the test-bed, encompassing the connection to the operational systems as well as the simulators.

## Summary of the lessons learned

1. A generic [guidance methodology](#guidance_methodology) is needed for analysing the need, and preparing, executing and reviewing an experiment.
2. Create [one test-bed](#one_testbed) and use it for each and every trial.
3. The test-bed should be [open source](#open_source).
4. The test-bed should have a [message-oriented architecture](#message_oriented).
5. The test-bed should use [well-defined, easily accessible, syntactically correct messages, and close to common standards](#standard).
6. The test-bed should be clearly [defined and scoped](#definition), i.e. what it is, and what it is not.
7. The test-bed must be [easily reproducible, and offer administrative as well as supporting tools and services](#complete).

All of these aspects have been addressed in D+.

## The organisation of each experiment was ad hoc {#guidance_methodology}
In D-, there was no clear overall process to perform an experiment, or determine whether you even need one: how to prepare, execute and review an experiment, which questions to ask, how to look for existing solutions, etc. Different partners had different ways of doing things, and there was no clear guidance or manual to steer them all. This leads to miscommunications, discussions, inefficiency, stress and less than optimal experiments.

**Lesson learned:** A generic guidance methodology is needed for analysing the need, and preparing, executing and reviewing an experiment.

## Each trial created its own test-bed {#one_testbed}

Each of the organised trials in D- created his own, unique, test-bed to perform the trial, i.e. the test-bed was based on:
- A legacy system owned by one of the D- partners
- The High-Level Architecture (HLA), an open but complex standard for connecting different simulators, but with only a few (expensive) commercial providers and a steep learning curve
- A semi-open source system based on Apache Kafka, a message streaming service

 This may have made sense for a small one-off project that does not need to be repeated, but for a pan-European project, a lot of resources were wasted. In particular, this meant that:
- Every solution or simulator provider had to connect his system to different test-beds, using different protocols
- Every solution or simulator provider had to deal with different message types
- Setting up and managing the test-bed was difficult, and offered little learning opportunity

**Lesson learned:** Each trial should use the same test-bed (*one test-bed to rule them all*).

## Test-beds were not open source {#open_source}

As already stated in the previous chapter, none of the used test-beds were completely open source. Again, this does not matter within the scope of one project, were partners could use these test-beds license free, but if you want to remain sustainable *after* the project, and be attractive to *outside* parties, this will be a serious roadblock. Besides obvious aspects as costs for getting a license, it would create a strong dependency on the owning party: each change you would like to make would have to be approved. And after an approval, it would take time to implement the change request, potentially leading to serious delays.

In addition, from a developer's point of view, dealing with a large and complex closed source environment is not very pleasant. Failures in your software may be caused by bugs in the legacy system, which are often hard to determine or proof. And for any bug that is discovered, it is up to the owner when he will fix it. There is no chance to quickly fix it yourself.

**Lesson learned:** The test-bed should be fully open source.

## All test-beds used a message-oriented architecture {#message_oriented}

Each trial needed to connect many, quite different, software systems: end-user solutions, incident simulators, 3D visualisations etc. But although each test-bed was different, they all used a message-based infrastructure. The reasoning behind that is simple: when you have *n* systems, the number of connections between different systems will quickly explode (*#connections* = &sum; *n-i*, where *i*=1..*n*-1). So it is better that the test-bed uses a kind of mail service or *message broker*: if you want to communicate something, tell it to the broker and he will make sure that your message is delivered to the right person at the right time.

**Lesson learned:** The test-bed should have a message-oriented architecture.

## Each test-bed used its own set of message standards {#standard}

When different systems need to talk to each other, the messages they exchange must be well understood, at least at a syntactic level (*I can read your message*), and preferably also on a semantic level (*I understand your message*). The latter, however, has implications beyond what this project tries to solve here, as it would entail a universal translator (*the 'Babel fish' for those who have read 'The Hitchhikers guide to the Galaxy'*). To further complicate matters, in a crisis management environment a test-bed has to deal with two types of systems: solutions and simulators, each with their own set of messages.

For simulators, often DIS ([Distributed Interactive Simulation](https://en.wikipedia.org/wiki/Distributed_Interactive_Simulation)) or HLA ([High Level Architecture](https://en.wikipedia.org/wiki/High-level_architecture)) are used as standards to exchange messsages. Syntactically, they can be easily interpreted, albeit that often their stricts schema's do not allow for sufficient freedom to express deviations from the standard, and certain fields may be misused to communicate this missing information.

For solutions in the operational crisis management domain, the CAP, EMSI and EDXL DE standards are often encountered. But also here, we see in practice different flavours, and even a simple standard as CAP (Common Alerting Protocol) has different implementations across countries, but often also between different organisations. Furthermore, not all standards are freely available, for example you need to pay for the TSO/EMSI standard. And even if these costs are often neglible in a large project, it may cause delays, since a developer needs it, but has to get approval in ordert to buy it, and he is probably not allowed to share it with project partners.

To deal with these issues, the test-bed should have:
- A well-defined set of messages
- Each message can be validated syntactically
- A message should be close to the common standards (i.e. you are allowed to tweak the standard to suit your trial)
- Each message's definition (often called schema) must be easily accessible to all participants

**Lesson learned:** The test-bed should use well-defined, easily accessible, syntactically correct messages, and close to common standards.

## The definition of test-bed was confusing {#definition}

In D-, participants had no clear picture of the scope of the test-bed. To perform an experiment, you often need most of the following components:
- Operational systems: either legacy systems, or new systems that you wish to evaluate
- Simulators: to create a fictive incident, such as a flooding, earthquake or explosion, and a virtual representation of the world
- Gateways for exchanging messages between operationals systems, between simulators, and between operational systems and simulators
- Support tools, for administrating the technical infrastucture, controlling a trial or experiment and observing/reviewing the results
- Location, i.e. the place where the trial or experiment takes place
- Services, like sharing maps, census data, etc.

So for some participants, the test-bed was only the gateway between operational systems. For others, it contained all of the above.

**Lesson learned:** The test-bed should be clearly scoped, i.e. what it is, and what it is not

## Test-bed management was complex {#complete}

The complexity is partially related to the previous observation that each experiment created its own test-bed enviroment. However, the problem goes deeper than this, since an experiment also needs:
- Administration of all systems: are all systems up-and-running; is everyone connected correctly, so they receive the expected messages; are some messages secured properly.
- Supporting tools: what is the main list of scenario events, and how do we share; what do we need to observe during an experiment, and how do we collect these observations for an after action review; how do we evaluate the outcome of an experiment.
- Data services: Maps, map layers, weather reports, census data, etc. need to be shared between operational systems and simulators
- Reproducing a test-bed: In case we would like to redo an experiment

**Lesson learned:** The test-bed must be easily reproducible, and offer administrative as well as supporting tools and services

