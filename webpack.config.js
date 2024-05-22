const path = require("path");
const webpack = require("webpack");

module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';

  return {
    mode: isProduction ? "production" : "development",
    devtool: isProduction ? "source-map" : "eval-source-map",
    entry: {
      application: "./app/javascript/application.js"
    },
    output: {
      filename: "[name].js",
      sourceMapFilename: "[file].map",
      chunkFormat: "module",
      path: path.resolve(__dirname, "app/assets/builds"),
    },
    plugins: [
      new webpack.optimize.LimitChunkCountPlugin({
        maxChunks: 1
      })
    ]
  };
};
