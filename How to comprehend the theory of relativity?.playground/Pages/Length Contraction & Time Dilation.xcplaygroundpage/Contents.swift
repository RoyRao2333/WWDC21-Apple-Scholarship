//: ## ☪︎ Time Dilation and Length Contraction
/*:
 ___
- Important:
This is the first chapter of my Playground. Be sure you've finished the __Intro__. If so, then please go ahead and enjoy this chapter! :) \
In this chapter, you can learn two classic phenomena of special relativity. Go and check it out!
 ___
*/
/*:

&nbsp;
 
### Time Dilation
*/
/*:
- callout(Basic concept):
Time dilation is a physical phenomenon that for two identical clocks, one at rest and the other in motion, the observer will measure the moving clock as ticking slower than the clock that is at rest in the observer's own reference frame.
 
&nbsp;
 
In __Einstein's theory of relativity__, time dilation occurs in two situations:
- In __special relativity__, all clocks moving relative to an inertial system will go slower, and this effect has been accurately proved by the __Lorentz transformation__.
- In __general relativity__, the clock with lower potential energy in the gravitational field goes slower (known as __Gravitational time dilation__). (Not discussed in this chapter)
 
&nbsp;
 
In __the special theory of relativity__, the time dilation effect is reciprocal. That is, observing from any clock, the other's clock is slower (It is assumed that the mutual motion of the two is uniform and the two have no acceleration when observing each other). \
__Gravitational time dilation__, on the other hand, is not reciprocal. Observers at a high place feel that the clock at a low place is slow, while observers at a low place feel that the clock at a high place is moving faster. The dilation and the strength of the gravitational field are related to the position of the observer.
 
![DIVIDER](Preface_Assets/divider.png)
 
The equation for measuring time dilation in the special theory of relativity is: \
![TD_Equation](Preface_Assets/Chapter_I/TD_Equation.png)
 
where
- _Δt_ is the time interval between two local events (that is, two events that occur in the same place) according to the clock of an observer. This is called __proper time__.
- _Δt'_ is the time interval between the same two events according to the clock of another observer.
- _v_ is the velocity at which the second clock moves relative to the first clock.
- _c_ is the speed of light.
 
And _γ_ is the __Lorentz factor__, defined as: \
![Lorentz factor](Preface_Assets/Chapter_I/Lorentz_factor.png)
 
&nbsp;
 
It is obvious that the clock in motion ticks slower. \
In daily life, even the time dilation effect caused by high-speed spacecraft is too small to be detected, so it can be ignored. Time dilation is very important only when the object reaches more than 30,000 km/s (1/10 of the speed of light).
*/
/*:
 
___

&nbsp;
 
&nbsp;
 
&nbsp;
 
&nbsp;
 
### Length Contraction
*/
/*:
- callout(Basic concept):
Length contraction refers to the phenomenon that the length becomes smaller when the observer looks at an object with a non-zero relative velocity. This phenomenon is usually more obvious only when the relative velocity is close to the speed of light. And the length contraction can only be observed in the direction parallel to the motion of the object. For common objects, this effect can be ignored when they move at a normal speed. It makes sense to consider this phenomenon only if the speed of its motion is large enough, or in the motion of electrons.
 
&nbsp;
 
As the speed approaches the speed of light, this effect begins to become very obvious. \
This effect can be described by the following equation: \
![LC Equation](Preface_Assets/Chapter_I/LC_Equation.png)
 
where
- _L0_ is the inherent length of the object (the length of the object in the frame of reference relative to it)
- _L_ is the length of the object observed by the observer
- _v_ is the relative velocity between the observer and the moving object
- _c_ is the speed of light
 
And _γ(v)_ / _γ_ is still the __Lorentz factor__, defined as: \
![Lorentz factor](Preface_Assets/Chapter_I/Lorentz_factor.png)
 
&nbsp;
 
In this equation, the length of the object is parallel to the direction of its motion. The observer needs to measure the distance from both ends of the object at the same time and then subtract to get the length of the object. \
When the relative velocity approaches the speed of light, the length of the object in the corresponding direction becomes zero.
 
![DIVIDER](Preface_Assets/divider.png)
 
- callout(Spacetime diagram):
__Spacetime diagram__, also known as __Minkowski diagrams__, was developed by _Hermann Minkowski_ in 1908. It is a graphical illustration of the properties of space and time in the special theory of relativity, and used to represent the coordinates of events in Minkowski spacetime. It is a tool for understanding the phenomena of special relativity.
 
&nbsp;
 
In the __four-dimensional coordinate system__, time times the speed of light (ct) as one of the axes, called the time axis; the other x-axis, y-axis, z-axis are called the space axis. Every point in this four-dimensional spacetime represents an event __E__. Corresponding to a specific inertial reference frame, the time and place where __E__ occurs can be represented as __(ct, x, y, z)__. \
The activity of each particle in spacetime can be represented by a continuous curve on the spacetime diagram, which is called __the world line__.
 
&nbsp;
 
- Note: In order to facilitate the representation on the plane, some of the Minkowski diagrams we normally see only have a time axis (ct) and one space axis (x).
*/
/*:
 
___
 
&nbsp;
 
- Experiment:
In the mini game in this chapter, you can understand at a glance what __time dilation__ and __length contraction__ are, and you can also have a certain understanding of the special theory of relativity. \
Already itching to try? Run the code and find it out yourself!
*/

import Cocoa
import SwiftUI
import PlaygroundSupport

var str = "Hello, playground"

//: [Previous Chapter](Intro)
