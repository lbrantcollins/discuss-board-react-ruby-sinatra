const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
	entry: './src/index.js',
	// when webpack creates the single file bundle,
	// it will create/output it in 'project_path/dist/index_bundle.js'
	output: {
		path: path.resolve(__dirname, 'dist'),
		filename: 'index_bundle.js'
	},
	module: {
		// let webpack know how to transform React and JSX code to regular JS
		rules: [
			{ 
				test: /\.(js)$/,     // search for any .js file
			  	use: 'babel-loader' 	// transform using babel-loader
			},
			{
				test: /\.css$/,		// search for any .css file
				use: [ 'style-loader', 'css-loader']  // make those styles active on resulting page
			}
		]
	},
	mode: 'development',   // to deploy, change to 'production' (and some other changes)
	plugins: [
		new HtmlWebpackPlugin({
			template: 'src/index.html'
		})
	]
}