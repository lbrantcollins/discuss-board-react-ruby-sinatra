import React, { Component } from 'react';
import ReactDOM from 'react-dom';

// style-loader npm module 
// will inject these styles into the single page app build
require('./index.css');  



// what is in a component?
// state (not always)
// lifecycle events (not always)
// UI (always)

// @babel/preset-env npm module will tranform ES6 classes 
// to ES5 constructors for browser compatability
class App extends Component {

	render() {

		// @babel/preset-react npm module will transform JSX to JS
		return(
			<div>
			Hello, world! I've changed again!
			</div>

		)
	}

}


ReactDOM.render(

	<App />,

	document.getElementById('app')

)