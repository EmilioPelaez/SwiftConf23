//
//  ErrorHandlingSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ErrorHandlingSlide: Slide {
	var body: some View {
		HeaderSlide("Error Handling") {
			Element("The Responder Chain pattern can be used to centralize error handling")
			Element("Create handlers")
			Element("Create environment value")
		}
		.extend()
	}
	
	var script: String {
"""
Something that happens often is that a user will encounter an error where all we can do is show an alert
So we may end up with a lot of boilerplate that looks like this in many of our views of our application
By using the closure we just created we can send an event up the view hierarchy and setup a responder that will handle it
We create a responder that receives the event and if it's a Localized Error, we will show an alert like this
If we receive anything else, we'll just ignore it
Now we can go back to our view and remove all the code that shows the alert and replace it with a call to our closure
We need to make sure that our error handling modifier is high enough in the view hierarchy to respond to all the events
And because the responder chain is so modular, we can also inject other kinds of error handlers
For example, we could add a responder that will report every error to our analytics service but will not consume them
Of we could add a responder that looks for Authorization Errors and shows the login screen
"""
	}
}

struct ErrorHandlingSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ErrorHandlingSlide()
		}
	}
}

