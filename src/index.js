import React, { Component } from 'react';
import ReactDOM from 'react-dom';
require('babel-polyfill'); // allows async/await
require('dotenv'); // allows .env for environment vars

require('./index.css'); 

// use the API url from environment if it exists
const API_URL = process.env.REACT_APP_API_URL || ''; 


class App extends Component {
	constructor() {
		super();

		this.state = {
			keywordIds: [],
		}
	}

	componentDidMount = async () => {

		console.log("REACT_APP_API_URL", process.env.REACT_APP_API_URL);
		console.log("Inside componentDidMount()");

   	try {

         const allKeywordIdsResponse = await fetch(API_URL + '/keywords/3')

         const parsedResponse = await allKeywordIdsResponse.json();

         console.log(parsedResponse);

         if (parsedResponse.status.code === 200) {

            await this.setState({
               keywordIds: parsedResponse.data,
            })

         }

      } catch (err) {
         console.log(err)
      }

	}

	render() {

		const keywordIdList = this.state.keywordIds.map( keywordId => {
			return <li key={keywordId.id}> {keywordId.keyword_id} </li>
		})

		return(

			<div>
				<h3>Hello, world!</h3>

				<ul>
					{keywordIdList}
				</ul>

			</div>

		)
	}

}


ReactDOM.render(

	<App />,

	document.getElementById('app')

)