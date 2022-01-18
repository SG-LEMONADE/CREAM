const withImages = require("next-images");

module.exports = withImages({
	images: {
		domains: ["kream-phinf.pstatic.net"],
	},
	env: {
		END_POINT: "ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081/",
	},
	webpack(config) {
		config.module.rules.unshift({
			test: /\.svg$/,
			use: ["@svgr/webpack"],
		});

		return config;
	},
});
