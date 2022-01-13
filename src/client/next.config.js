const withImages = require("next-images");

module.exports = withImages({
	images: {
		domains: ["kream-phinf.pstatic.net"],
	},
	env: {
		END_POINT: "www.naver.com/",
	},
	webpack(config) {
		config.module.rules.unshift({
			test: /\.svg$/,
			use: ["@svgr/webpack"],
		});

		return config;
	},
});
