	import React, { Component } from 'react';

	componentDidMount = async () => {

   	try {

         const allItemsResponse = await fetch(process.env.REACT_APP_BACKEND_URL + '/items/')

         const parsedResponse = await allItemsResponse.json();

         if (parsedResponse.status.code === 200) {

            await this.setState({
               items: parsedResponse.data,
            })

         }

      } catch (err) {
         console.log(err)
      }

	}