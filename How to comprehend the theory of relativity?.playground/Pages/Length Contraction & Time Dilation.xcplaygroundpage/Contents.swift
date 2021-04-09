//: ## ☪︎ Length Contraction and Time Dilation
/*:
 ___
- Important:
This is the first chapter of my Playground. Be sure you've finished the __Intro__. If so, then please go ahead and enjoy this chapter! :) \
In this chapter, you can learn two classic phenomena of special relativity. Go and check it out!
 ___
*/
/*:

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
 
- __L0__ is the inherent length of the object (the length of the object in the frame of reference relative to it)
- __L__ is the length of the object observed by the observer
- __V__ is the relative velocity between the observer and the moving object
- __C__ is the speed of light
 
And γ(v) is the Lorentz factor, defined as: \
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
- Experiment:
1
*/

import Cocoa
import SwiftUI
import PlaygroundSupport

var str = "Hello, playground"

//: [Previous Chapter](Intro)
