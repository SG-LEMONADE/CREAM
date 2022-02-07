const withImages = require("next-images");

module.exports = withImages({
	images: {
		domains: ["kream-phinf.pstatic.net"],
	},
	env: {
		END_POINT_USER:
			"http://ec2-13-125-85-156.ap-northeast-2.compute.amazonaws.com:8081",
		END_POINT_PRODUCT:
			"http://ec2-13-124-253-180.ap-northeast-2.compute.amazonaws.com:8081",
		ERROR_code: {
			"-18": "중복된 이메일입니다!",
			"-19": "이메일을 확인해주세요!",
			"-20": "비밀번호를 확인해주세요!",
		},
	},
	webpack(config) {
		config.module.rules.unshift({
			test: /\.svg$/,
			use: ["@svgr/webpack"],
		});

		return config;
	},
});
