const withImages = require("next-images");

module.exports = withImages({
	images: {
		domains: ["kream-phinf.pstatic.net"],
		disableStaticImages: true,
	},
	env: {
		DEPLOY_VER: false,
		END_POINT_USER: "http://www.kangho.shop:8000",
		END_POINT_PRODUCT: "http://www.kangho.shop:8000",
		ERROR_code: {
			"-16": "access token 만료",
			"-18": "중복된 이메일입니다! 🧐",
			"-19": "이메일을 확인해주세요! 🤨",
			"-20": "비밀번호를 확인해주세요! 😢",
			"-50": "선택하신 사이즈를 확인해주세요! 😮",
			"-51": "본인이 등록하신 물품을 구매하거나 판매할 순 없습니다! 😱",
			"-52": "해당 거래는 삭제된 거래입니다! 😲",
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
