# <a id="top"></a>Orientation Layout Guide

## Table of Content

 - [Preamble](#preamble)
	 - [What do we want to achieve by the end of this guide?](#goals)
 - [Part 1 : The Existing Code](#part-1)
	 - [The Device Types and their Screen Sizes](#device-types)
	 - [Aggregating the Sizing Information](#sizing-info)
	 - [Building the UI in response to the Sizing Information](#responsive-builder)
	 - [Building the UI in response to Orientation](#orientation-layout)
	 - [Building the UI Based on Both Orientation and Screen Size](#working-together)
 - [Part 2 : The Code You Need to Write](#part-2)
	 - [Writing the View Class](#view-class)
	 - [The Different Layout Widgets](#different-layout-widgets)
	 - [The StatefulWidget and the Separate States for each Screen Size and Orientation](#states)
	 - [Add your 'View' Class to the Routing Information](#routing)

 

## <a id="preamble"></a>Preamble

This guide is based off of what I did for my screen, the Contact Screen which is [Stateful](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) not [Stateless](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) . If the screen you are working on is Stateless you should still be able to use this guide minus the parts about the [State](https://api.flutter.dev/flutter/widgets/State-class.html).  

If you had looked at my code for the Contact Screen previously, you may have noticed that I was using the Provider, ChangeNotifier and ChangeNotifierProvider from the [provider package](https://pub.dev/packages/provider) like in the videos that were sent in the group. However, after reading more about State management in the flutter documentation, I realized that was not the appropriate solution for my screen, hence I removed it. 

The essence of it is that Provider should be used when there is something that you want to be able to access/modify across screens, like app settings that you would want to persist across screens. The Contact Screen does not access/modify any data outside of the screen so the use of Provider would be extra processing expense. 

You can read more about these state management concepts [here](https://flutter.dev/docs/development/data-and-backend/state-mgmt/ephemeral-vs-app) and [here](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

### <a id="goals"></a>What do we want to achieve by the end of this guide? (Goals)

:black_square_button: The functionality to switch between layouts when the screen size changes/ display a particular layout depending on the screen size.

:black_square_button: The functionality to switch between layouts when the user rotates the screen

:black_square_button: Different layouts for different screen sizes

:black_square_button: Different layouts for different screen orientations 

<div align="right"><a href="#top">[Top]</a></div>

## <a id="part-1"></a>Part 1 : The Existing Code
*First, let us go through the existing code...*
 
### <a id="device-types"></a>The Device Types and their Screen Sizes

Flutter supports many platforms and so there is a variety of possible devices and sceen sizes that the app could be displayed on. The device types we are focusing on in this guide are mobile (phone) and tablet.

Since these device types will always be the same, meaning a mobile device will not suddenly become a tablet, a simple [enum](https://dart.dev/guides/language/language-tour#enumerated-types) class was created to assign device types based on screen size:

```dart
enum  DeviceScreenType { Mobile, Tablet, Desktop }
```
<sup>fst_app_flutter > lib > models > enums > device_screen_type.dart</sup>


This enum is used like this:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/enums/device_screen_type.dart';

DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
	double deviceWidth = mediaQuery.size.shortestSide;

	if (deviceWidth > 950) {
		return DeviceScreenType.Desktop;
	}  

	if (deviceWidth > 600) {
		return DeviceScreenType.Tablet;
	}
 
	return DeviceScreenType.Mobile;
}
```

<sup>fst_app_flutter > lib > utils > get_device_screen_type.dart<sup>

It is important to note the [MediaQueryData](https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html) object that is passed in. It allows us to get various information about the device including the current orientation and screen size. MediaQueryData is typically obtained in a widget's build method through the [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) object that is passed in using [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html).[of](https://api.flutter.dev/flutter/widgets/MediaQuery/of.html). 
Eg:
```dart 
@override 
Widget build(BuildContext context) {
	MediaQueryData mq = MediaQuery.of(context);
	// rest of the build method
}
```
The reason why we use the `mediaQuery.size.shortestSide` to determine the device width and not the `mediaQuery.size.width` is that the `mediaQuery.size.width` and `mediaQuery.size.height` values will swap places once the devices changes orientation.

Take this device for example:

![portrait](https://github.com/richtwin567/fst_app_flutter/blob/contact_screen/Orientation_Layout_Explanation/MediaQuery.size_explanation/portrait.png)

And when rotated:

![landscape](https://github.com/richtwin567/fst_app_flutter/blob/contact_screen/Orientation_Layout_Explanation/MediaQuery.size_explanation/landscape.png)

This would incorrectly cause the tablet layout to be displayed since the device width has exceeded 600 if we used `mediaQuery.size.width` instead of `mediaQuery.size.shortestSide`.

<div align="right"><a href="#top">[Top]</a></div>

### <a id="sizing-info"></a>Aggregating the Sizing Information


So, we have a means to determine the device type based on screen size. We will also be needing other information, like orientation. Instead of calling `MediaQuery.of` and accessing the `MediaQueryData` properties, everytime we want this information, we will store it in an object of type `SizingInformation`.

```dart
import 'package:flutter/widgets.dart';
import 'package:fst_app_flutter/models/enums/device_screen_type.dart';  

class SizingInformation {
	final Orientation orientation;
	final Size screenSize;
	final DeviceScreenType deviceScreenType;
		
	SizingInformation({
		this.orientation,
		this.screenSize,
		this.deviceScreenType,
	});

	@override
	String toString() {
		return 'Orientation:$orientation DeviceScreenType:$deviceScreenType ScreenSize:$screenSize';
	}
}
```
<small>fst_app_flutter > lib > utils > sizinginformation.dart</small>

<div align="right"><a href="#top">[Top]</a></div>


### <a id="responsive-builder"></a>Building the UI in response to the Sizing Information

We have our sizing information now. Next, we will use it to build the UI. Take a look at the code for the `ResponsiveBuilder` class.

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/utils/get_device_screen_type.dart';
import 'package:fst_app_flutter/utils/sizinginformation.dart';

class ResponsiveBuilder extends StatelessWidget {
	final Widget Function(
		BuildContext context,
		SizingInformation sizingInformation,
	) builder;

	const ResponsiveBuilder({Key key, @required this.builder}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		var mediaQuery = MediaQuery.of(context);
		var sizingInformation = SizingInformation(
				orientation: mediaQuery.orientation,
				deviceScreenType: getDeviceType(mediaQuery),
				screenSize: mediaQuery.size,
		return builder(context, sizingInformation);
	}
}
```
<small>fst_app_flutter > lib > widgets > responsive_builder.dart</small>

`ResponsiveBuilder` has a single field; a function called `builder` which accepts a `BuildContext` object and a `SizingInformation` object and return a [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html). In its build method, instantiates the `SizingInformation` object. It gets the `MediaQueryData` and passes it to `getDeviceType` which is used to set the `deviceScreenType` field. The `SizingInformation` is then passed to the `builder` whose `Widget` is returned.

<br></br>
So where and how do we use the `ResponsiveBuilder`? In `ScreenTypeLayout`:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/enums/device_screen_type.dart';
import 'package:fst_app_flutter/widgets/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
	// Mobile will be returned by default
	final  Widget mobile;
	final  Widget tablet;
	final  Widget desktop;  

	const  ScreenTypeLayout(
		{Key key, @required this.mobile, this.tablet, this.desktop})
		: 	assert(mobile !=  null),
			super(key: key);

	@override
	Widget build(BuildContext context) {
		return ResponsiveBuilder(builder: (context, sizingInformation) {
			
			// If sizing indicates Tablet and we have a tablet widget then return
			if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
				if (tablet != null) {
					return tablet;
				}
			}  

			// If sizing indicates desktop and we have a desktop widget then return
			if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
				if (desktop !=  null) {
					return desktop;
				}
			}

			 // Return mobile layout if nothing else is supplied
			return mobile;
		});
	}
}
```
<small>fst_app_flutter > lib > widgets > screen_type_layout.dart</small>

Whatever widget you pass into `ScreenTypeLayout` for it's mobile field will always be returned if `SizingInformation` indicates that its a mobile device.

So switching between layouts based on screen size is sorted out - we can check it off the goals list.

:ballot_box_with_check:  ~~The functionality to switch between layouts when the screen size changes/ display a particular layout depending on the screen size.~~

:black_square_button: The functionality to switch between layouts when the user rotates the screen

:black_square_button: Different layouts for different screen sizes

:black_square_button: Different layouts for different screen orientations 

Next, let's deal with orientation.

<div align="right"><a href="#top">[Top]</a></div>

### <a id="orientation-layout"></a>Building the UI in response to Orientation

The `OrientationLayout` class was created to deal with this. Flutter has a  [OrientationBuilder](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html) class but it would not be appropriate for our purposes. According to Flutter, the `OrientationBuilder`:
> Builds a widget tree that can depend on the parent widget's orientation (distinct from the device orientation).

This could easily produce erroneous results if we used it.

Take a look at the code for the `OrientationLayout` class:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/widgets/responsive_builder.dart';

class OrientationLayout extends StatelessWidget {
	final Widget Function(BuildContext context) landscape;
	final Widget Function(BuildContext context) portrait;
	
	const OrientationLayout({
		Key key,
		this.landscape,
		@required this.portrait,
	}) :  	assert(portrait != null),
			super(key: key);

	@override
	Widget build(BuildContext context) {
		return ResponsiveBuilder(
			builder: (context, sizingInformation) {
				if (sizingInformation.orientation == Orientation.landscape) {	
					if (landscape != null) {
						return landscape(context);
					}
				}
				
				return  portrait(context);
			},
		);
	}
}
```
<small>fst_app_flutter > lib > widgets > orientation_layout.dart</small>

The `OrientationLayout` class has two build methods as fields. One called `landscape` to build the landscape layout and one called `portrait` to build the portrait layout. These methods are set in the constructor. In the build method, you can see that we used the `ResponsiveBuilder` again, to get `SizingInformation.orientation`. Depending on the orientation either `portrait` or `landscape`'s `Widget` will be returned. In the case of `landscape`, it is only returned if it is not `null`.

The `landscape` and `portrait` methods are what you will create in Part 2. For now, let's cross this off the list.

:ballot_box_with_check:  ~~The functionality to switch between layouts when the screen size changes/ display a particular layout depending on the screen size.~~

:ballot_box_with_check:  ~~The functionality to switch between layouts when the user rotates the screen.~~

:black_square_button: Different layouts for different screen sizes.

:black_square_button: Different layouts for different screen orientations. 

<div align="right"><a href="#top">[Top]</a></div>

### <a id="working-together"></a>Building the UI Based on Both Orientation and Screen Size

All we need to do for this is to pass an instance of `OrientationLayout` into the `mobile` and `tablet` parameters of `ScreenTypeLayout`. You will see this being done in detail in Part 2.

<div align="right"><a href="#top">[Top]</a></div>

## <a id="part-2"></a>Part 2 : The Code You Need to Write

Now that you have gone through the various classes involved in responsive layout building, let's go through how you will use them.

### <a id="view-class"></a>Writing the View Class

The 'View' class you write will be the top-most widget for your screen. The [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html) will push and pop and instance of your 'View' class when switching screens. The 'View' class will be where you make use of `ScreenTypeLayout` and `OrientationLayout` to build the UI based off both screen type and orientation.

Take a look at the `ContactView` class. 

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

/// Contact Screen View. Controls the layout that is displayed using
/// [ScreenTypeLayout] and [OrientationLayout] to switch based on device type
/// and screen orientation.
class ContactView extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return ScreenTypeLayout(
			mobile: OrientationLayout(
				portrait: (context) => ContactViewMobilePortrait(),
				landscape: (context) => ContactViewMobileLandscape(),
			),
			tablet: OrientationLayout(
				portrait: (context) => ContactViewTabletPortrait(),
				landscape: (context) => ContactViewTabletLandscape(),
			),
		);
	}

}
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_view.dart</small>

`ContactViewMobilePortrait()`, `ContactViewMobileLandscape()`, `ContactViewTabletPortrait()` and `ContactViewTabletLandscape()` build the appropriate layout for each device screen type and orientation.

<div align="right"><a href="#top">[Top]</a></div>

### <a id="different-layout-widgets"></a> The Different Layout Widgets

Let's take a look at `ContactViewMobilePortrait()` and `ContactViewMobileLandscape()`:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile_state.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_stateful.dart';

/// Full mobile portrait contact view made using [ContactViewMobilePortraitState].
class ContactViewMobilePortrait extends StatelessWidget{

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: ContactViewStateful(state: ContactViewMobilePortraitState()));
	}
}  

/// Full mobile landscape contact view made using [ContactViewMobileLandscapeState].
class ContactViewMobileLandscape extends StatelessWidget{

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: ContactViewStateful(state: ContactViewMobileLandscapeState()));
	}
}
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_view_mobile.dart</small>

And at `ContactViewTabletPortrait()` and `ContactViewTabletLandscape()`:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_stateful.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_tablet_state.dart';

/// Full portrait tablet contact view made using [ContactViewTabletPortraitState].
class ContactViewTabletPortrait extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: ContactViewStateful(state: ContactViewTabletPortraitState()));
	}
}

/// Full landscape tablet landscape view made using [ContactViewTabletLandscapeState].
class ContactViewTabletLandscape extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: ContactViewStateful(state: ContactViewTabletLandscapeState()));
	}
}
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_view_tablet.dart</small>

What you may notice that these classes have in common is `ContactViewStateful` in the body of each `Scaffold`. It accepts a `state` and this is where the classes differ. A different object is passed in as the `state` in each class.

<div align="right"><a href="#top">[Top]</a></div>

### <a id="states"></a>The StatefulWidget and the Separate States for each Screen Size and Orientation

I created `ContactViewStateful` since there was no need to create four different [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)s and then four different [State](https://api.flutter.dev/flutter/widgets/State-class.html) classes because the `StatefulWidget` would never change, only the `State`.

The `ContactViewStateful` class:
```dart
import 'package:flutter/material.dart';

/// A single [StatefulWidget] to prevent code duplication for various screen layouts.
/// [state] is the state for the different screen layouts.
class ContactViewStateful extends StatefulWidget {

	/// The [State] that this contact page should use.
	final State<ContactViewStateful> state;
	
	const ContactViewStateful({Key key, @required this.state}) : super(key: key);

	@override
	State<ContactViewStateful> createState() => state;
	
} // ContactViewStateful definition
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_view_stateful.dart</small>

The `State` passed in is a subclass of `ContactViewState`. So 
`ContactViewTabletLandscapeState`, `ContactViewTabletPortraitState`, `ContactViewMobileLandscapeState` and `ContactViewMobilePortraitState` that were passed to `ContactStateful` in the classes in contact_view_tablet.dart and contact_view_mobile.dart, are all sublasses of `ContactViewState`.

I won't show the whole class since its long, but it is defined like so:
```dart
abstract class ContactViewState extends State<ContactViewStateful>
	with TickerProviderStateMixin {
	// fields and methods
}
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_state.dart</small>

The build method is not implemented. Other methods to be used in the build method of the subclasses are defined, however.

For example, the `ContactViewMobilePortraitState` class:

```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_state.dart';

...

/// [ContactViewState] designed for phones in portrait orientation.
class ContactViewMobilePortraitState extends ContactViewState {
	
	@override
	Widget build(BuildContext context) {

		// width and height calculations made using the [MediaQueryData]
		var mq = MediaQuery.of(context);

		// horizontal and vertical padding for the list of contacts
		var padH = mq.size.width * 0.1;
		var padV = (mq.size.height - (kToolbarHeight *  2)) * 0.07;
	
		return Scaffold(
			backgroundColor: Theme.of(context).backgroundColor,
			body: SafeArea(
				child: Stack(
					children: <Widget>[
						Container(),
						buildMovingContactListArea(
							height: mq.size.height - (kToolbarHeight * 2),
							padH: padH,
							padV: padV,
							width: mq.size.width,
							posFromTop: kToolbarHeight * 2,
							posFromLeft: 0.0,
							thickness: 1.0,
							growLeft: 0.0,
							growTop: (kToolbarHeight *  2) * 0.5,
							growBottom: 0.0,
							growRight: 0.0,
							posFromBottom: 0.0,
							posFromRight: 0.0,
							controller: dropdownController,
						),
						buildFilterDropdownArea(context,
							posFromTop: kToolbarHeight,
							width: MediaQuery.of(context).size.width,
							height: kToolbarHeight,
							isExpanded: true,
							elevation: 4.0),
						buildAppBarArea(
							height: kToolbarHeight,
							animationIntervalStart: 0.40,
							animationIntervalEnd: 1.0,
							actions:  <Widget>[],
							elevation:  0.0),
					],
				),
			),
		);
	}

}
```
<small>fst_app_flutter > lib > screens > contact_screen > contact_view_mobile_state.dart</small>

All methods and fields used that you do not see a definition for in the `ContactViewMobilePortraitState` class were already defined in `ContactViewState`. The other state classes are done in a similar manner.

Go ahead and create your different `State` classes. Once you have done that we can check off the rest of the goal items.

:ballot_box_with_check:  ~~The functionality to switch between layouts when the screen size changes/ display a particular layout depending on the screen size.~~

:ballot_box_with_check:  ~~The functionality to switch between layouts when the user rotates the screen.~~

:ballot_box_with_check:  ~~Different layouts for different screen sizes.~~

:ballot_box_with_check:  ~~Different layouts for different screen orientations.~~

<div align="right"><a href="#top">[Top]</a></div>

#### <a id="routing"></a>Add your 'View' Class to the Routing Information

Create a name for your page's route and store it in routes.dart in the routing folder:

```dart
// All the routes for each page are stored here  

/// [HomeView] route
const homeRoute = '/home';

/// [ContactView] route
const contactRoute = '/contact';

/// [ContactDetailPage] route
const contactDetailRoute = '/contactDetail';

// Add your route here
```
<small>fst_app_flutter > lib > routing > routes.dart</small>

Then add a case for your route in the generateRoute switch statement in generate_routes.dart
```dart
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/routing/slide_up_route.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view.dart';
import 'routes.dart';

/// Handles routing in the app
class Router {

	/// Controls how each [Route] is generated
	static Route<dynamic> generateRoute(RouteSettings settings) {
		switch (settings.name) {	
			case contactRoute:
				return  MaterialPageRoute(builder: (context) => ContactView());
			case contactDetailRoute:
				return  SlideUpPageRoute(page: ContactDetailPage(settings.arguments));
			// Add your route here:
			// case myRoute:
			//		handle route
			default:
				return MaterialPageRoute(builder: (context) => HomeView());
		}
	}

}
```

<small>fst_app_flutter > lib > routing > generate_routes.dart</small>

<div align="right"><a href="#top">[Top]</a></div>

# That's all for this Guide!


