# 6.   Conclusions and way forward

Now that the Test-bed’s environment, its high-level use-cases and its components and their reasons of existence are described in the previous chapters, it is time to look ahead at the development and implementation of the Test-bed. This chapter looks back at the previous chapters to draw some general conclusions about the Test-bed and look ahead on the development, implementation and functional review of the Test-bed. In the third and final section, links between WP923 \(i.e. development and implementation of the Test-bed\) and other SPs and WPs are described.

## 6.1   Overall feedback on the Test-bed’s requirements specifications

Chapter 4 describes the high-level use-cases in which the components must function. The description of the environment the Test-bed is used in and descriptions of the components provide the specifications that apply as a “must” \(i.e. a requirement\) or as a “should” \(i.e. not a hard requirement, but a wish that should be complied to as much as possible\). These musts and shoulds are essential for a Test-bed to be useful and valuable in the trials yet to come, being both the four Trials and Final Demo within the D+-project and future trials outside this project.

This document does not describe how these requirements and wishes are to be fulfilled. Decisions on which technology is used to develop the components and why these off-the-shelve, innovative or newly created technologies are used, as well as choices made in the development of human-software interfaces are to be described in the deliverables D923.21, D923.22 and D923.23 Reference Implementation \(versions 1, 2 and 3\).

Whether the specifications documented in this deliverable are fully valid, complete and/or feasible is yet to be shown. Conclusions about this can only be drawn when the components are developed and used in Trials: the proof is in the pudding. It is deliberately not foreseen that at this moment these specifications are fully correct and complete and actually will never fully be. The environments the Test-bed is to be used in are different per location and are dynamic over time in every potential location: technologies change, opinions of users differ and experiences grow. This is the main reason this requirements specifications document is a living document, allowing change when experiences in using the Test-bed are gathered. The development of the components is also staged, to offer several versions in time with a growing level of maturity.

## 6.2   Envisioned development and implementation steps

The Test-bed will be developed in 3 phases:

##### Version 1 – to be used in Trials 1 and 2

This provides a first version of the CIS, CSS, logging within the CIS and CSS, adapters for Solutions and Simulators, Test-bed Admin tool, Observer Support Tool and the Play Service functioning as a first version of the Scenario Manager and Time Service. These components together form the functional core. The quality level of this version is that of a first prototype with a focus on functionality and stability needed to execute Trials 1 and 2. Potentially also a first version of the AAR component is developed. When specifically needed in the Trials, also a data-set of the fictive crisis environment\(s\) of Trial 1 or 2 is provided.

After use in Trials 1 and 2, this version is evaluated and the specifications will be updated regarding experiences gained in the use of the Test-bed. Updates on specifications and design choices will function as a base for developing version 2.

##### Version 2 – to be used in Trials 3 and 4 and Final Demo

This version comprises of all component. The components should be reasonably stable with a quality level surpassing that of a first prototype. It should contain data-sets and basic scenarios that can be used for effectively connecting and testing Solutions and Simulators to the CIS and CSS and it should contain data-sets needed to execute Trials 3 and 4.

After use in Trials 3 and 4, this version is evaluated and the specifications will be updated regarding experiences gained in the use of the Test-bed. Updates on specifications and design choices will function as a base for developing version 3.

##### Version 3

This version is the final version of all component. The quality level should surpass that of version 2. It should contain more data-sets and basic scenarios than available in version 2, to better support effectively connecting and testing Solutions and Simulators to the CIS and CSS and executing D+-external Trials.

This version comes with a final, online version of the specifications and design choices and documentation for implementation of the Test-bed outside D+. As these documents are available online via GitBook, people can still contribute to them even after the completion of the D+-project.

## 6.3   Dependencies of the Test-bed’s development on other SP’s and WP’s

All Test-bed’s components are developed in WP923. But this WP has links and even dependencies with other WPs and SPs. Especially the dependencies provide requirements for the development scheme and quality of the Test-bed.

##### WP922 – Evaluation of the Trial Guidance Methodology

The success of the Trials and thereby the Trial Guidance Methodology \(i.e. how to prepare them, execute them and evaluate them\) is under the influence of the successful use of the Test-beds components. For instance, the Observer Support Tool should make the observation easier and more detailed. So if these observations fail, the evaluation a Trial is in danger. On a more operational level, the Observer Support Tool must provide the functionality to create observation templates complying to requirements for good observations set by the Trial Guidance Methodology.

##### T924.1 – Training Module

The Training Module is primarily aimed at people who want to do a Trial. This Training Module will contain a section explaining the Test-bed and what it can offer \(i.e. of which components it consists of and for what these components are intended to be used\). Although there is no hard dependency between WP923 and T924.1, the Training Module will highly benefit from images or even videos showing interfaces of some components with understandable, applicable \(demo-\) Trial content.

##### SP93 – development of Portfolio of Solutions and Guidance Tool

Descriptions of the test-bed’s component should also be taken up in the Portfolio of Solutions. This provides an accessible entrance to what the Test-bed comprises of, also for people outside D+.

The Guidance Tool should in due time contain forms to enter scenario information and describe injects in these scenarios. The template of injects should be aligned with the definition of an inject in the Scenario Manager and the CSS.

##### SP94 and T924.2 – support to and execution of Trials and Final Demo

The successful execution of Trials of course is highly dependent on timely availability of the components needed in each Trial. The quality of these components needs to be fit-for-use. Fit-for-use means the quality of a component should not jeopardize the success of the Trial \(e.g. should not cause a crash of the Test-bed or a Solution\), but it does not mean that in a Trial every component must have the quality level of a final version.

For an effective \(technical\) support to Trials in T924.2, it is essential that the Test-bed can be easily \(partly\) implemented at a Trial Owner’s location, but also at Solution providers for linking up their Solution to the test-bed \(if needed and possible\). The Docker environment supports this easy installation, but this dependency also requires that each component is well document and potential bugs encountered can be quickly pinpointed and resolved.

##### WP954 – Test-bed’s sustainability

As already described, the Test-bed must be developed such that it can also be used outside/after D+. The development and implementation of the Test-bed this has a strong link with the sustainability tasks in WP954. It can even be stated that the sustainability of the Test-bed and thereby results of the D+-project \(highly\) depends on development choices made in the development of the components.

