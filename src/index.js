import React, { Component } from 'react';
import ReactDOM from 'react-dom';
require('babel-polyfill');
require('dotenv');

require('./index.css'); 

const api_url = process.env.API_URL || ''; 


class App extends Component {
	constructor() {
		super();

		this.state = {
			items: [],
		}
	}

	componentDidMount = async () => {

		console.log("API_URL", process.env.API_URL);
		console.log("Inside componentDidMount()");

   	try {

         const allItemsResponse = await fetch(api_url + '/items')

         const parsedResponse = await allItemsResponse.json();

         console.log(parsedResponse);

         // if (parsedResponse.status.code === 200) {

            await this.setState({
               items: parsedResponse.data,
            })

         // }

      } catch (err) {
         console.log(err)
      }

	}

	render() {

		const itemList = this.state.items.map( item => {
			return <li key={item.id}> {item.content} </li>
		})



		return(

			<div>
				<h3>Hello, world!</h3>

				<ul>
					{itemList}
				</ul>

			</div>

		)
	}

}


ReactDOM.render(

	<App />,

	document.getElementById('app')

)