module.exports = {
	stories: ["../src/**/*.stories.mdx", "../src/**/*.stories.@(js|jsx|ts|tsx)"],
	addons: ["@storybook/addon-links", "@storybook/addon-essentials"],
	framework: "@storybook/react",
	core: {
		builder: "webpack5",
	},
	typescript: { reactDocgen: false },
	webpackFinal: async (config) => {
		config.module.rules = config.module.rules.map((rule) => {
			if (!rule.test.test(".svg")) {
				return rule;
			}

			const newRule = rule;
			// Changes existing default rule to not handle SVG files
			newRule.test =
				/\.(ico|jpg|jpeg|png|gif|eot|otf|webp|ttf|woff|woff2)(\?.*)?$/;
			return newRule;
		});

		// Adds new SVG loader
		config.module.rules.push({
			test: /\.svg$/,
			use: ["@svgr/webpack", "url-loader"],
		});

		return config;
	},
};
